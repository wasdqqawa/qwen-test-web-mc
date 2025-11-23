#!/bin/bash

# 构建并准备部署Vue博客到GitHub Pages

echo "开始构建Vue博客项目..."

# 安装依赖
npm install

# 构建项目
npm run build

echo "项目构建完成！"

echo "构建文件已生成在 dist/ 目录中，可以部署到GitHub Pages。"

echo "要部署到GitHub Pages，请执行："
echo "1. 确保你已经配置了gh-pages: npm install gh-pages --save-dev"
echo "2. 在package.json中添加: \"deploy\": \"gh-pages -d dist\""
echo "3. 运行: npm run deploy"