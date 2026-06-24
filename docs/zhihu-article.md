# 我把四个AI大脑塞进了一个终端，现在它帮我画画、读图、写代码、查论文

---

**先说结论：** 我搭了一个开源的 AI 实验室，一个终端里能同时用 DeepSeek、Gemini、GPT-4o、Flux 四个模型。一键安装，免费画画，免费读图。项目已经开源在 GitHub，不想自己折腾的可以找我远程装好。

---

## 它到底能干嘛？

不要讲概念，直接看效果。

### 1. 一句话出图（完全免费）

我在对话里打了这几个字：

```
gen "cyberpunk city at night, neon rain"
```

12 秒后，终端里弹出了这张图：

![AI生成赛博朋克城市](gallery/art_2.jpg)

**重点：** 这个功能调用的是 Pollinations API，完全免费。你没有 Midjourney 会员？没关系。用的是 Flux 模型，质量不输收费工具。

### 2. AI 帮你看图

我让 AI 分析自己刚画的图：

```
vg gallery/art_2.jpg
```

它返回：

> 赛博朋克风格的城市夜景。路面因雨水湿滑，霓虹灯光在沥青上形成鲜艳倒影。两侧现代化建筑外墙上布满明亮广告屏。流线型未来感汽车停在路边。远处天际线是密集高楼和无尽灯火。

**这意味着什么？** 你看论文里的数据图、PPT 里的流程图、甚至路边随手拍的表格，它都能帮你读出来。而且 Gemini 和 GPT-4o 的视觉接口都是**免费**的。

### 3. 当场换脑子

聊着聊着觉得 DeepSeek 算力不够？切 GPT-4o。要看长文本？切 Gemini。一句命令，上下文不丢：

```
ds   →  DeepSeek（逻辑计算核心）
gm   →  Gemini（视觉 + 长文本）
gp   →  GPT-4o（联网调研）
```

### 4. 抓网页、读论文、画图表

```
python tools/fetch.py "https://arxiv.org/abs/2301.11320"
```

直接抓回论文标题、作者、摘要。然后让 AI 帮你总结、翻译、画示意图——一条龙。

---

## 怎么做到的？

架构其实很简单：

```
你的终端
    │
    └─ Claude Code CLI  ←  DeepSeek（主力大脑）
            │
            ├─ v.py          视觉网关（Gemini + GPT-4o，都免费）
            ├─ generate_art.py  AI 绘画（Flux 流水线，免费）
            ├─ fetch.py       网页抓取（零依赖）
            └─ memory/        持久记忆（关了重开还记得你）
```

核心思路就一条：**不绑定任何一个模型供应商。** 工具是我写的，脑子可以随时换。今天是 DeepSeek + Gemini，明天 Anthropic 出了更好的模型，改一行配置就切过去。

---

## 安装有多简单？

就三步：

```powershell
git clone https://github.com/hqw7484-maker/claude-lab.git
cd claude-lab
.\一键安装.ps1    # 自动装 Python + Node.js + 所有依赖
.\start_lab.ps1   # 启动
```

`一键安装.ps1` 会自动检测你的环境，缺 Python 装 Python，缺 Node 装 Node，然后装 Claude Code CLI，装 Python 依赖，最后引导你填 API 密钥。

**全程不需要懂代码。**

---

## 要花多少钱？

| 功能 | 费用 |
|------|------|
| AI 对话（DeepSeek） | ~1元/百万字 |
| 图片识别（Gemini） | **免费** |
| 高精度识别（GPT-4o） | **免费**（GitHub Models） |
| AI 绘画（Flux） | **免费**（Pollinations API） |
| 网页抓取 | **免费** |

**唯一的硬性开销是 DeepSeek API。** 正常使用一个月几块钱到十几块钱。比 ChatGPT Plus 每月 20 美元便宜一个数量级。

---

## 开源地址

GitHub: **[hqw7484-maker/claude-lab](https://github.com/hqw7484-maker/claude-lab)**

MIT 协议，随便用、随便改、随便商用。觉得有用就给个 Star ⭐

---

## 不想折腾？我帮你装好

虽然安装已经简化到一行命令，但我知道有些朋友：

- 不会注册 DeepSeek 开发者账号
- 不知道怎么充值和拿 API Key
- PowerShell 报错看不懂
- 想自定义配置但不知道改哪里

**找我远程安装，30 分钟内搞定，包教包会。**

服务内容：
- 远程桌面帮你装好所有环境
- 帮你注册并配置 DeepSeek + Gemini + GitHub Models 三个 API
- 跑通第一个 Demo（出图 + 读图）
- 教你日常使用和切换模型

**价格：XX 元/次**（含后续一个月内免费咨询）

需要的私信我，或者加微信/QQ：XXXXX

---

*如果你觉得这篇文章有用，欢迎点赞收藏，让更多人用到免费好用的 AI 工具。*
