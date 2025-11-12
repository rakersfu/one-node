#!/usr/bin/env sh
set -e

# 检查环境变量是否存在
if [ -z "$UUID" ]; then
  echo "Error: UUID 环境变量未设置"
  exit 1
fi

if [ -z "$DOMAIN" ]; then
  echo "Error: DOMAIN 环境变量未设置"
  exit 1
fi

# 使用模板文件生成最终配置
# 假设你有 /app/xy/config.json.template 和 /app/keepalive.sh.template
envsubst < /app/xy/config.json.template > /app/xy/config.json
envsubst < /app/keepalive.sh.template > /app/keepalive.sh

# 保证 keepalive.sh 可执行
chmod +x /app/keepalive.sh

# 如果需要，可以在这里修改 DNS 或添加 crontab（可选）
# cp /etc/resolv.conf /etc/resolv.conf.bak
# echo "nameserver 1.1.1.1" > /etc/resolv.conf
# echo "nameserver 8.8.8.8" >> /etc/resolv.conf
# (crontab -l 2>/dev/null; echo "*/5 * * * * /app/keepalive.sh") | crontab -

# 执行 CMD 中的命令
exec "$@"
