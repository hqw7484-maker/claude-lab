# 🧪 Claude Lab 2026 实验室手册 (通用性第一原则)

## 👁️ 视觉解析指令 (解决“眼瞎”问题的通用网关)
> 当输入以下指令时，请直接运行对应的本地 Python 脚本，并根据返回的文字描述进行后续逻辑分析。

- `v <file> [prompt]`: **执行命令**：`python tools/v.py <file> "[prompt]"`
  - *用途*：默认调用 Gemini 快速解析图片/图表。
- `vg <file> [prompt]`: **执行命令**：`python tools/v.py <file> "[prompt]" --gpt`
  - *用途*：调用 GPT-4o 进行更高精度的对比解析。

## 🧠 大脑模型切换 (继承当前会话上下文)
- `ds`: **执行命令**：`/config set model deepseek-v4-pro`
  - *用途*：切换到 DeepSeek (计算与逻辑核心)。
- `gm`: **执行命令**：`/config set model google:gemini-2.0-flash`
  - *用途*：切换到 Gemini (视觉与长文本分析)。
- `gp`: **执行命令**：`/config set model gpt-4o`
  - *用途*：切换到 GPT (联网调研与综合分析)。

## 🔬 实验室准则 (必读)
1. **优先使用 `v` 指令**：遇到任何图片（.jpg, .png）或 PDF 截图，不要使用 `read_file`，直接调用 `v <文件名>`。
2. **逻辑联动**：运行 `v` 指令后，终端回显的文字即为图片的真实内容。请根据这些文字协助用户完成代码编写或数据调研。
3. **隔离安全**：所有操作仅限项目文件夹及其子目录。默认工作目录为项目根目录。

## 🎨 艺术创作 (高质量轮询流水线)
> **原则**：AI 必须作为“导演”扩写创意，并作为“助手”汇报结果。

- `gen “[desc]”` : **执行命令**：`python tools/generate_art.py “[desc]”`
  - **前置逻辑**：AI 收到指令后，必须先将描述扩写为包含”材质(PBR)、光影(Cinematic Lighting)、渲染(Octane Render)”的专业英文 Prompt。
  - **执行逻辑**：运行脚本启动阶梯轮询（Flux -> Turbo -> Standard）。图片输出至 `gallery/` 目录。
  - **后置逻辑**：读取终端回显的 `💡 本次最终出图模型`，并明确告知用户。

### 🖼️ 生图标准操作流程 (SOP)
1. **扩写汇报**：输出“正在设计高质量提示词：[扩写后的文本]”。
2. **静默生成**：自动执行 `python tools/generate_art.py "[扩写后的文本]"`。
3. **身份告知**：告知用户：”生成成功！本次由 [模型名称] 出图，已覆盖 gallery/art_2.jpg”。
4. **验收联动**：主动询问：”需要我调用 `v gallery/art_2.jpg` 帮您检查画作细节吗？”