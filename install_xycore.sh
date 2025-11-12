#!/bin/bash
set -e

# 一键安装脚本
# 功能：下载 release 压缩包，解压到 /opt/xycore/，并创建软链接

REPO="your-repo-owner/your-repo"   # 修改为你的 GitHub 仓库路径
INSTALL_DIR="/opt/xycore"
PACKAGE="release-package.tar.gz"

echo ">>> 安装依赖工具"
sudo apt-get update
sudo apt-get install -y wget unzip tar

echo ">>> 下载最新 release 压缩包"
curl -L -o $PACKAGE https://github.com/$REPO/releases/latest/download/$PACKAGE

echo ">>> 解压到 $INSTALL_DIR"
sudo mkdir -p $INSTALL_DIR
sudo tar -xzf $PACKAGE -C $INSTALL_DIR

echo ">>> 创建软链接到系统目录"
sudo ln -sf $INSTALL_DIR/build/xy /usr/local/bin/xy
sudo ln -sf $INSTALL_DIR/build/td /usr/local/bin/td
sudo ln -sf $INSTALL_DIR/build/supercronic /usr/local/bin/supercronic
sudo ln -sf $INSTALL_DIR/build/geoip.dat /usr/local/share/geoip.dat
sudo ln -sf $INSTALL_DIR/build/geosite.dat /usr/local/share/geosite.dat

echo ">>> 清理临时文件"
rm -f $PACKAGE

echo ">>> 安装完成！"
echo "你可以运行以下命令验证："
echo "  xy version"
echo "  td --version"
echo "  supercronic --version"
