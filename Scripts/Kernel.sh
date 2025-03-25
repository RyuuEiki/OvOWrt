#!/bin/sh  # 严格保持 /bin/sh 兼容性

# 目标配置文件路径
TARGET_CONFIG="target/linux/rockchip/armv8/config-6.6"

# 配置参数列表（兼容POSIX写法，逐行处理）
CONFIG_ENTRIES="
CONFIG_NETFILTER=y
CONFIG_SHORTCUT_FE=y
CONFIG_FAST_CLASSIFIER=y
CONFIG_MODULES=y
CONFIG_NF_CONNTRACK=y
CONFIG_TCP_CONG_BBR=y
"

# 创建目录结构（如果不存在）
mkdir -p "$(dirname "$TARGET_CONFIG")" || exit 1

# 检查/创建配置文件
touch "$TARGET_CONFIG" || exit 1

# 逐行处理配置项
echo "$CONFIG_ENTRIES" | while read -r entry; do
    # 跳过空行
    [ -z "$entry" ] && continue
    
    # 提取配置键名
    key=$(echo "$entry" | cut -d'=' -f1)
    
    # 删除旧条目（兼容无 -i 参数的 sed）
    sed "/^$key=/d" "$TARGET_CONFIG" > "${TARGET_CONFIG}.tmp"
    mv "${TARGET_CONFIG}.tmp" "$TARGET_CONFIG"
    
    # 追加新条目
    echo "$entry" >> "$TARGET_CONFIG"
done

# 最终去重处理
sort -u "$TARGET_CONFIG" -o "$TARGET_CONFIG"

echo "配置已更新：$TARGET_CONFIG"