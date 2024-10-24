# iOS-Vision-Pro-


---

VisionProPopup Tweak

项目介绍

VisionProPopup 是一个 iOS Tweak，展示了一个 Vision Pro 风格的毛玻璃效果弹窗。此 Tweak 利用 iOS 的 UIVisualEffectView 创建出带有模糊背景和圆角的弹窗效果。

功能特色

现代化的 Vision Pro 风格设计

毛玻璃背景效果

自定义圆角弹窗布局


项目目录结构

VisionProPopup/
│
├── control              // 控制文件，包含包的元数据
├── Makefile             // 项目的 Makefile，定义编译规则
├── Tweak.xm             // Tweak 的主代码文件
├── layout/              // 可选的布局文件夹，用于存放界面布局相关文件
├── plist/               // 可选的 plist 文件夹，用于配置文件
└── deb/                 // 编译后生成的 .deb 文件会放在这里

环境准备

1. 安装 Theos：在系统中安装 Theos 环境。

git clone --recursive https://github.com/theos/theos.git ~/theos
echo "export THEOS=~/theos" >> ~/.bashrc
source ~/.bashrc


2. 安装依赖项：确保你已经安装了 dpkg、ldid、clang 等编译工具。


3. 项目初始化：确保你已经克隆或创建了项目目录。



编译与打包步骤

1. 修改 Makefile

确保 Makefile 中的配置正确，类似如下：

ARCHS = arm64 arm64e
TARGET = iphone:clang:13.7:13.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VisionProPopup

VisionProPopup_FILES = Tweak.xm
VisionProPopup_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
    install.exec "killall -9 SpringBoard"

2. 修改 control 文件

确保项目根目录下的 control 文件中的包信息是正确的，例如：

Package: com.hyang.visionpropopup
Name: Vision Pro Popup
Depends: mobilesubstrate
Version: 1.0-1
Architecture: iphoneos-arm
Description: Vision Pro 风格的毛玻璃弹窗
Maintainer: Hyangu
Author: Hyangu 
Section: Tweaks

3. 编译项目

在项目的根目录下，运行以下命令编译并打包项目：

make package

编译完成后，会在 deb/ 文件夹中生成一个 .deb 文件。

4. 安装到设备

通过 SSH 或者文件管理器（如 Filza）将生成的 .deb 文件传输到你的设备上。通过以下命令进行安装：

dpkg -i /path/to/VisionProPopup.deb

然后重启 SpringBoard 以应用 Tweak：

killall -9 SpringBoard

5. 测试

安装成功后，重新启动设备或重启 SpringBoard，应该会在 SpringBoard 启动时显示 Vision Pro 风格的毛玻璃弹窗。

贡献指南

欢迎任何形式的贡献，提交问题或拉取请求时请确保代码风格一致，并附带详细的描述说明。

许可证

此项目遵循 MIT 许可证。详细信息请参考 LICENSE。


---

通过这个 README.md 文件，用户可以轻松了解如何使用 Theos 编译和打包这个 Tweak 项目。

