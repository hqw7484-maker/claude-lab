import os
import random
import sys
import time

import requests

# Fix Unicode encoding on Windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# --- 配置常量 ---
IMAGE_WIDTH = 1024
IMAGE_HEIGHT = 1024
REQUEST_TIMEOUT = 40
DEFAULT_OUTPUT = "gallery/art_2.jpg"

STRATEGIES = [
    {"id": "flux",    "name": "Flux.1 (High-Res)",   "params": f"model=flux&width={IMAGE_WIDTH}&height={IMAGE_HEIGHT}&nologo=true"},
    {"id": "turbo",   "name": "SDXL Turbo (Fast)",    "params": f"model=turbo&width={IMAGE_WIDTH}&height={IMAGE_HEIGHT}&nologo=true"},
    {"id": "default", "name": "Standard Default",     "params": f"width={IMAGE_WIDTH}&height={IMAGE_HEIGHT}&nologo=true"},
]


def generate_best_image(prompt, filename=DEFAULT_OUTPUT):
    os.makedirs(os.path.dirname(filename), exist_ok=True)

    encoded_prompt = requests.utils.quote(prompt)
    seed = random.randint(1, 99999)

    print(f"\n[*] 正在启动轮询生成流程 (Seed: {seed})...")

    for strategy in STRATEGIES:
        try:
            url = f"https://image.pollinations.ai/prompt/{encoded_prompt}?{strategy['params']}&seed={seed}"
            print(f"    [尝试] {strategy['name']} ... ", end="", flush=True)

            start_time = time.time()
            response = requests.get(url, timeout=REQUEST_TIMEOUT)
            duration = round(time.time() - start_time, 2)

            if response.status_code == 200:
                content_type = response.headers.get("Content-Type", "")
                if "image" not in content_type:
                    print(f"⚠️ 异常: 非图片响应 ({content_type})")
                    continue

                with open(filename, "wb") as f:
                    f.write(response.content)

                with open(f"{filename}.txt", "w", encoding="utf-8") as f:
                    f.write(f"Model: {strategy['name']}\nPrompt: {prompt}\nSeed: {seed}\nTime: {duration}s")

                print(f"✅ 成功! (用时: {duration}s)")
                print(f"💡 本次最终出图模型: 【{strategy['name']}】")
                return True
            else:
                print(f"❌ 失败 (Code: {response.status_code})")

        except Exception as e:
            print(f"⚠️ 异常: {str(e)[:30]}...")
            continue

    print("\n[-] 告急：所有高质量路径均已阻塞，请检查网络或稍后重试。")
    return False


if __name__ == "__main__":
    p = sys.argv[1] if len(sys.argv) > 1 else "futuristic lab, cinematic light"
    generate_best_image(p)
