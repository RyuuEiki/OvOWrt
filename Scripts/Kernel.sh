#!/bin/sh

# 目标配置文件路径
TARGET_CONFIG="$GITHUB_WORKSPACE/wrt/target/linux/rockchip/armv8/config-6.6"

# 配置参数列表（自动去重）
CONFIG_ENTRIES=(
    "CONFIG_NETFILTER=y"
    "CONFIG_SHORTCUT_FE=y"
    "CONFIG_FAST_CLASSIFIER=y"
    "CONFIG_MODULES=y"
    "CONFIG_NF_CONNTRACK=y"
    "CONFIG_TCP_CONG_BBR=y"
)

# 创建目录结构（如果不存在）
mkdir -p "$(dirname "$TARGET_CONFIG")" || exit 1

# 检查/创建配置文件
touch "$TARGET_CONFIG" || exit 1

# 处理每条配置项
for entry in "${CONFIG_ENTRIES[@]}"; do
    key=$(echo "$entry" | cut -d'=' -f1)
    
    # 删除旧条目（如果有）
    sed -i "/^$key=/d" "$TARGET_CONFIG"
    
    # 追加新条目
    echo "$entry" >> "$TARGET_CONFIG"
done

# 特殊处理重复参数（如多个NETFILTER）
sort -u "$TARGET_CONFIG" -o "$TARGET_CONFIG"

echo "配置已更新：$TARGET_CONFIG"