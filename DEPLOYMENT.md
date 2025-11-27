# Minecraft-Style 3D WebGL Game - 部署指南

## 项目概述

这是一个基于Unity 3D的Minecraft风格WebGL游戏，支持方块放置/破坏、3D世界探索等基础Minecraft功能。项目旨在通过GitHub Pages进行部署，提供浏览器内的完整游戏体验。

## 项目结构

```
.
├── Assets/                 # Unity项目资源
│   ├── Scenes/            # 游戏场景
│   │   └── SampleScene.unity
│   ├── Scripts/           # C#脚本
│   │   ├── PlayerController.cs    # 玩家控制
│   │   ├── WorldGenerator.cs      # 世界生成
│   │   └── BlockInteraction.cs    # 方块交互
│   ├── Materials/         # 材质文件
│   │   ├── BedrockMaterial.mat
│   │   ├── DirtMaterial.mat
│   │   ├── GrassMaterial.mat
│   │   └── StoneMaterial.mat
│   └── Textures/          # 纹理文件
├── Build/                 # 构建输出目录
│   └── WebGL/             # WebGL构建输出
├── Packages/              # Unity包管理
├── ProjectSettings/       # Unity项目设置
├── .github/               # GitHub配置
│   └── workflows/         # GitHub Actions工作流
│       └── static.yml     # WebGL部署工作流
├── README.md              # 项目说明
├── DEPLOYMENT.md          # 部署指南 (当前文件)
├── build_webgl.sh         # WebGL构建脚本
└── index.html             # 主页
```

## 构建要求

### 本地开发环境
- Unity 2021.3 LTS 或更高版本
- 支持WebGL构建模块

### GitHub Actions 环境
- Ubuntu latest
- Unity 2021.3.15f1 (通过 game-ci/unity-setup 安装)

## 本地构建步骤

1. **安装Unity**
   - 下载并安装 Unity Hub
   - 通过Unity Hub安装 Unity 2021.3 LTS 或更高版本
   - 安装时确保选择"WebGL Build Support"模块

2. **打开项目**
   - 启动Unity Hub
   - 点击"Add"按钮，选择当前项目目录
   - 使用Unity 2021.3 LTS 打开项目

3. **配置构建设置**
   - 在Unity编辑器中，选择 File → Build Settings
   - 选择 WebGL 平台
   - 点击"Switch Platform"按钮
   - 在"Build"选项卡中，设置以下参数：
     - Target: WebGL
     - Build Type: Web
     - Server: Local File Server
     - 其他设置使用默认值

4. **执行构建**
   - 点击"Build"按钮
   - 选择 `Build/WebGL` 目录作为输出位置
   - 等待构建完成

## GitHub Pages 部署

项目已配置自动部署到GitHub Pages：

### 自动部署
1. 将代码推送到 `main` 分支
2. GitHub Actions 会自动触发构建和部署流程
3. 构建完成后，访问 `https://<username>.github.io/<repository>` 查看游戏

### 手动部署
1. 在本地构建WebGL版本
2. 将 `Build/WebGL` 目录中的所有文件上传到GitHub仓库
3. 在GitHub仓库设置中启用GitHub Pages
4. 选择根目录作为源

## 游戏功能

### 玩家控制
- WASD / 方向键：移动
- 鼠标：视角控制
- 空格键：跳跃

### 方块交互
- 鼠标左键：破坏方块
- 鼠标右键：放置方块
- 最大交互距离：5米

### 世界生成
- 程序化地形生成
- 基于Perlin噪声的高度图
- 多种方块类型（基岩、石头、泥土、草方块）

## 技术细节

### Unity设置
- 使用CharacterController进行物理交互
- 射线检测实现方块交互
- 材质数组管理不同方块类型
- 优化的内存管理避免泄漏

### WebGL优化
- 禁用动态批处理（WebGL不支持）
- 合理的纹理压缩设置
- 适当的LOD设置
- 内存使用优化

## 浏览器兼容性

- Chrome 90+
- Firefox 89+
- Safari 14+
- Edge 90+

## 故障排除

### 构建错误
- 确保安装了WebGL构建支持
- 检查Unity版本是否兼容
- 验证项目设置是否正确

### 部署问题
- 确保GitHub Pages已启用
- 检查工作流权限设置
- 验证构建目录路径正确

### 游戏问题
- 检查浏览器控制台错误
- 确认WebGL支持已启用
- 验证所有依赖资源已加载

## 开发说明

### 添加新方块类型
1. 在Materials目录中创建新材质
2. 在WorldGenerator.cs中添加材质到blockMaterials数组
3. 在GetBlockType方法中添加新方块类型逻辑
4. 更新方块放置逻辑以支持新类型

### 优化性能
1. 使用对象池减少GC压力
2. 实现视距剔除
3. 优化网格合并
4. 合理使用LOD系统

## 许可证

本项目采用 MIT 许可证 - 详见 LICENSE 文件。