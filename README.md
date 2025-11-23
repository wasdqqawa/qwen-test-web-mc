# 在线M3U8播放器

一个基于Vue 3和HLS.js的在线M3U8直播流播放器，支持多种功能和优化的用户体验。

## 功能特性

- 📺 **M3U8流播放**: 支持HLS格式的直播流播放
- 🎛️ **画质切换**: 自动检测并切换不同画质的流
- 🔊 **音量控制**: 支持音量调节和静音功能
- 🎮 **播放控制**: 播放/暂停控制
- 🖥️ **全屏模式**: 支持全屏播放
- 📜 **播放历史**: 本地存储播放历史记录
- 🌐 **跨浏览器支持**: 支持Chrome、Firefox、Safari、Edge等主流浏览器
- 📱 **响应式设计**: 适配移动端和桌面端

## 技术栈

- [Vue 3](https://vuejs.org/) - 渐进式JavaScript框架
- [Vite](https://vitejs.dev/) - 下一代前端构建工具
- [HLS.js](https://github.com/video-dev/hls.js/) - JavaScript HLS播放器
- [Vue Router](https://router.vuejs.org/) - Vue.js官方路由管理器

## 预设流地址

播放器内置了多个测试流地址，包括：
- Mux测试流
- Apple官方测试流
- Big Buck Bunny测试流
- 法国新闻频道

## 使用说明

1. 在输入框中输入有效的M3U8直播流地址
2. 点击"加载流"按钮开始播放
3. 可以使用预设按钮快速加载常用流
4. 播放过程中可以切换画质、调节音量、全屏播放等

## 性能优化

- 代码分割和懒加载
- 资源压缩和缓存优化
- 移除生产环境中的调试信息
- 优化的构建配置
- 内存泄漏防护

## 本地开发

### 环境要求

- Node.js 16.x 或更高版本
- npm 或 yarn

### 安装和运行

```bash
# 克隆项目
git clone <repository-url>
cd m3u8-player

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

开发服务器将在 `http://localhost:3000` 上运行。

### 构建生产版本

```bash
# 构建生产版本
npm run build

# 预览生产构建
npm run preview
```

## 部署到GitHub Pages

项目已配置为支持GitHub Pages部署：

```bash
# 部署到GitHub Pages
npm run deploy
```

## 项目结构

```
.
├── public/                 # 静态资源
├── src/
│   ├── components/         # Vue组件
│   │   └── M3U8Player.vue # 主播放器组件
│   ├── App.vue            # 根组件
│   └── main.js            # 应用入口
├── index.html             # HTML模板
├── package.json           # 项目配置
├── vite.config.js         # Vite配置
└── README.md              # 项目说明
```

## 浏览器兼容性

- Chrome 62+
- Firefox 53+
- Safari 11+
- Edge 79+

## 常见问题

### 播放失败

1. 检查M3U8地址是否有效
2. 确认服务器支持CORS（跨域资源共享）
3. 检查网络连接是否正常

### 画质切换不生效

- 确保M3U8流包含多个画质版本
- 某些流可能不支持动态画质切换

## 贡献

欢迎提交Issue和Pull Request来改进项目。

## 许可证

本项目采用 [MIT License](LICENSE) 许可证。

## 更新日志

### v1.1.0
- 添加画质切换功能
- 添加播放控制（音量、静音、播放/暂停）
- 添加全屏模式
- 添加播放历史记录
- 优化UI界面
- 性能优化和错误处理改进

### v1.0.0
- 初始版本
- 基础M3U8播放功能
- 预设流地址