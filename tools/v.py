import base64
import io
import mimetypes
import os
import subprocess
import sys

# Fix Windows GBK encoding issues
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')


def _ensure_dependencies():
    """安装缺失的依赖，失败则明确报错。"""
    missing = []
    try:
        import google.generativeai  # noqa: F401
    except ImportError:
        missing.append("google-generativeai")
    try:
        from openai import OpenAI  # noqa: F401
    except ImportError:
        missing.append("openai")
    try:
        from PIL import Image  # noqa: F401
    except ImportError:
        missing.append("pillow")

    if missing:
        print(f"[*] 正在安装必要依赖: {', '.join(missing)}...")
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", "-q"] + missing,
            capture_output=True, text=True
        )
        if result.returncode != 0:
            raise RuntimeError(f"依赖安装失败:\n{result.stderr}")


_ensure_dependencies()

import google.generativeai as genai
from openai import OpenAI
from PIL import Image


def encode_image(image_path):
    """将图片转为 base64 编码，自动检测 MIME 类型。"""
    mime_type, _ = mimetypes.guess_type(image_path)
    if not mime_type or mime_type not in ("image/jpeg", "image/png", "image/webp"):
        mime_type = "image/png"  # 兜底
    with open(image_path, "rb") as f:
        return mime_type, base64.b64encode(f.read()).decode("utf-8")


def main():
    if len(sys.argv) < 2:
        print("用法: v <图片路径> [问题] [--gpt|--gemini]")
        return

    img_path = sys.argv[1]
    prompt = "请详细解析此图内容。如果是图表，请提取数据和坐标趋势；如果是日常图，请描述细节。"

    mode = "--gpt" if os.getenv("OPENAI_API_KEY") else "--gemini"

    for arg in sys.argv[2:]:
        if arg == "--gpt":
            mode = "--gpt"
        elif arg == "--gemini":
            mode = "--gemini"
        else:
            prompt = arg

    if not os.path.exists(img_path):
        print(f"错误: 找不到文件 {img_path}")
        return

    print(f"[*] 正在启动视觉解析器 (模式: {mode})...")

    try:
        if mode == "--gpt":
            api_key = os.getenv("OPENAI_API_KEY")
            if not api_key:
                raise ValueError("未检测到 OPENAI_API_KEY")

            client = OpenAI(
                base_url="https://models.inference.ai.azure.com",
                api_key=api_key,
            )

            mime_type, base64_img = encode_image(img_path)
            response = client.chat.completions.create(
                model="gpt-4o",
                messages=[{
                    "role": "user",
                    "content": [
                        {"type": "text", "text": prompt},
                        {"type": "image_url", "image_url": {"url": f"data:{mime_type};base64,{base64_img}"}},
                    ],
                }],
            )
            print(f"\n[AI视觉反馈 - GitHub GPT-4o]:\n{response.choices[0].message.content}")

        elif mode == "--gemini":
            api_key = os.getenv("GOOGLE_API_KEY")
            if not api_key:
                raise ValueError("未检测到 GOOGLE_API_KEY")

            genai.configure(api_key=api_key)
            model = genai.GenerativeModel("gemini-2.0-flash")
            response = model.generate_content([prompt, Image.open(img_path)])
            print(f"\n[AI视觉反馈 - Gemini 2.0]:\n{response.text}")

    except Exception as e:
        error_msg = str(e)
        if "429" in error_msg:
            print("\n[!] 触发频率限制，请稍后再试，或尝试切换另一个模型 (--gpt / --gemini)")
        elif "403" in error_msg:
            print("\n[!] 认证失败或区域受限。请检查 API Key 是否正确，或尝试开启/关闭代理。")
        else:
            print(f"\n[!] 解析出错: {error_msg}")


if __name__ == "__main__":
    main()
