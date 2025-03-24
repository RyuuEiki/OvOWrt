# OvOWrt

云编译OpenWRT ROCKCHIP R68s固件

# 目录简要说明：

workflows——自定义CI配置

Scripts——自定义脚本

Config——自定义配置

# 自用插件

- Nikki
- SmartDNS

# Tips

- 如需使用opkg安装插件，需在 `系统-软件包-配置OPKG` `/etc/opkg.conf` 中删除 ` option check_signature`，否则会无法更新软件源。
