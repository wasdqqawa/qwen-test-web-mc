# Minecraft 克隆游戏

一个基于Unity 3D的WebGL实现的Minecraft风格游戏，支持方块放置/破坏、3D世界探索和基本的Minecraft功能。

## 功能特性

- 🧱 **方块放置与破坏**: 点击鼠标左键破坏方块，右键放置方块
- 🎮 **3D世界探索**: 支持自由移动、跳跃等基本操作
- 🌍 **程序化世界生成**: 基于噪声算法生成的地形
- 🎯 **第一人称视角**: 流畅的3D视角控制
- 🌐 **WebGL兼容**: 可在浏览器中直接运行，支持GitHub Pages部署
- 🧱 **多种方块类型**: 包含基岩、石头、泥土、草方块等

## 技术栈

- [Unity 3D](https://unity.com/) - 3D游戏开发引擎
- [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) - 游戏逻辑编程语言
- [WebGL](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API) - Web图形渲染技术
- [Unity Physics](https://docs.unity3d.com/Manual/PhysicsSection.html) - 3D物理引擎

## 游戏操作

- WASD 或 方向键 - 移动角色
- 鼠标 - 控制视角
- 空格键 - 跳跃
- 鼠标左键 - 破坏方块
- 鼠标右键 - 放置方块

## 项目结构

```
.
├── Assets/                 # Unity项目资源
│   ├── Scenes/            # 游戏场景
│   ├── Scripts/           # C#脚本
│   ├── Materials/         # 材质文件
│   └── Textures/          # 纹理文件
├── ProjectSettings/       # Unity项目设置
├── Packages/              # Unity包管理
├── README.md             # 项目说明
└── index.html            # WebGL启动页面
```

## 开发说明

### 环境要求

- Unity 2021.3 LTS 或更高版本
- 支持WebGL构建模块

### 本地开发

1. 使用Unity Hub打开项目
2. 选择Assets/Scenes/SampleScene场景
3. 点击运行按钮进行测试

### 构建WebGL版本

1. 在Unity中选择 File → Build Settings
2. 选择 WebGL 平台
3. 点击 Build 按钮
4. 部署生成的文件到Web服务器

## 核心功能实现

### 1. 玩家控制器 (PlayerController.cs)
- 实现角色移动和重力系统
- 处理跳跃和地面检测
- 响应用户输入

### 2. 世界生成器 (WorldGenerator.cs)
- 使用Perlin噪声算法生成地形
- 创建不同类型的方块（基岩、石头、泥土、草方块）
- 管理方块材质和位置

### 3. 方块交互 (BlockInteraction.cs)
- 处理方块放置和破坏
- 使用射线检测确定交互对象
- 管理世界中的方块状态

## 部署到GitHub Pages

项目已配置为支持GitHub Pages部署：

1. 构建WebGL版本
2. 将构建结果上传到GitHub仓库
3. 在GitHub仓库设置中启用GitHub Pages

## 浏览器兼容性

- Chrome 90+
- Firefox 89+
- Safari 14+
- Edge 90+

## 未来功能

- 多人联机支持
- 更多方块类型
- 物品系统
- 光照系统
- 更复杂的地形生成

## 贡献

欢迎提交Issue和Pull Request来改进项目。

## 许可证

本项目采用 [MIT License](LICENSE) 许可证。
