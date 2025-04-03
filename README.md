# StampVault

**StampVault** (中文名：邮斋) 是一个专注于邮票收藏与展示的移动端应用程序，致力于为集邮爱好者提供一个优雅、便捷的邮票管理与交流平台。

本项目为 **前端部分**，使用 [Flutter](https://flutter.dev/) 构建，支持 Android 与 iOS 双平台运行。

---

## 📁 项目结构

```
lib/
├── assets/                # 静态资源（图片、图标、字体等）
│   ├── activityChart/
│   ├── atlasImages/
│   ├── ...
│   └── myIcons.dart       # 图标映射配置
│
├── chat/                  # 聊天模块
│   ├── models/            # 消息、用户等数据模型
│   ├── widgets/           # 聊天相关 UI 组件
│   ├── chat.dart
│   └── ...
│
├── common/                # 通用工具，如 API 接口封装、数据处理
│
├── login/                 # 登录与注册功能页面
│
├── mainPages/             # 主页面相关内容
│
├── bottom.dart            # 底部导航栏
├── flutter_neumorphic.dart# 拟物化风格组件支持
└── main.dart              # 应用入口
```

---

## 🚀 快速开始

1. 确保你已安装 Flutter SDK：
   ```bash
   flutter --version
   ```

2. 克隆本项目：
   ```bash
   git clone https://github.com/RuiqiYing/StampVault.git
   cd StampVault
   ```

3. 安装依赖：
   ```bash
   flutter pub get
   ```

4. 启动项目（Android/iOS 模拟器或真机）：
   ```bash
   flutter run
   ```

---

## 📌 功能概览

- 🧾 集邮清单展示与管理
- 📬 聊天与评论互动
- 👤 用户登录/注册模块
- 📊 活动图表与数据可视化
- 📸 图鉴浏览与邮票详情页

---

## 📱 技术栈

- Flutter 2.0.4
- Dart 2.12.4
- Neumorphic UI 风格组件
- 基于模块化结构设计

---

## 📄 许可证

本项目基于 MIT License 开源，欢迎自由使用与贡献。

---

> 如果你是一位热爱集邮的开发者，欢迎加入我们一起打造更好的 StampVault！
