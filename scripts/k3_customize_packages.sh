#!/bin/bash

# k3
# only build k3
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3|' target/linux/bcm53xx/image/Makefile
# k3 device packages
sed -i 's|$(BRCMFMAC_4366C0)|$(IEEE8021X) kmod-brcmfmac k3wifi k3screenctrl|g' target/linux/bcm53xx/image/Makefile
# k3 proprietary wifi driver
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/k3-brcmfmac4366c-firmware package/k3/k3wifi
# k3 screen
git clone -b master --depth 1 --single-branch https://github.com/lwz322/luci-app-k3screenctrl package/k3/luci-app-k3screenctrl
git clone -b master --depth 1 --single-branch https://github.com/lwz322/k3screenctrl_build package/k3/k3screenctrl_build

# access control
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-accesscontrol package/new/luci-app-accesscontrol
# AdGuard Home
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome package/new/luci-app-adguardhome
# AutoCore
cp -rf ../autocore package/new/autocore
# automount
rm -rf ./feeds/packages/kernel/exfat-nofuse
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/automount package/new/automount
svn co https://github.com/openwrt/packages/trunk/utils/antfs-mount package/utils/antfs-mount
svn co https://github.com/openwrt/packages/trunk/kernel/antfs package/kernel/antfs
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/kernel/exfat package/kernel/exfat
# autosamba
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autosamba package/new/autosamba
# arpbind
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-arpbind package/new/luci-app-arpbind
# DDNS
rm -rf ./feeds/packages/net/ddns-scripts
rm -rf ./feeds/luci/applications/luci-app-ddns
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun package/new/ddns-scripts_aliyun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_dnspod package/new/ddns-scripts_dnspod
svn co https://github.com/openwrt/packages/branches/openwrt-18.06/net/ddns-scripts feeds/packages/net/ddns-scripts
svn co https://github.com/openwrt/luci/branches/openwrt-18.06/applications/luci-app-ddns feeds/luci/applications/luci-app-ddns
# Filetransfer
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-filetransfer package/new/luci-app-filetransfer
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-lib-fs package/new/luci-lib-fs
# frp
rm -f ./feeds/luci/applications/luci-app-frps
rm -f ./feeds/luci/applications/luci-app-frpc
rm -rf ./feeds/packages/net/frp
rm -f ./package/feeds/packages/frp
git clone -b master --depth 1 --single-branch https://github.com/kuoruan/luci-app-frpc.git package/new/luci-app-frpc
git clone -b master --depth 1 --single-branch https://github.com/lwz322/luci-app-frps.git package/new/luci-app-frps
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/frp package/new/frp
# FullCone
svn co https://github.com/Lienol/openwrt/trunk/package/network/fullconenat package/new/openwrt-fullconenat
wget -P target/linux/generic/hack-4.14/ https://raw.githubusercontent.com/Lienol/openwrt/19.07/target/linux/generic/hack-4.14/952-net-conntrack-events-support-multiple-registrant.patch
pushd feeds/luci
cat ../../../patches/fullconenat-luci.patch | git apply
popd
mkdir -p package/network/config/firewall/patches
wget -P package/network/config/firewall/patches/ https://raw.githubusercontent.com/Lienol/openwrt/19.07/package/network/config/firewall/patches/fullconenat.patch
# IPv6 helper
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipv6-helper package/new/ipv6-helper
# IPSEC
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ipsec-vpnd package/new/luci-app-ipsec-vpnd
# OpenAppFilter
git clone -b master --depth 1 --single-branch https://github.com/destan19/OpenAppFilter.git package/new/OpenAppFilter
# OpenClash
git clone -b master --depth 1 --single-branch https://github.com/vernesong/OpenClash package/new/luci-app-openclash
rm -rf feeds/packages/libs/libcap
svn co https://github.com/openwrt/packages/branches/openwrt-21.02/libs/libcap feeds/packages/libs/libcap
# Passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/new/luci-app-passwall
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/shadowsocks-libev
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/new/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/new/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/new/pdnsd
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/new/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocksr-libev package/new/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/packages/trunk/net/shadowsocks-libev package/new/shadowsocks-libev
# SeverChan
git clone -b master --depth 1 --single-branch https://github.com/tty228/luci-app-serverchan package/new/luci-app-serverchan
# Scheduled Reboot
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-autoreboot package/new/luci-app-autoreboot
# Traffic Usage Monitor
git clone -b master --depth 1 --single-branch https://github.com/brvphoenix/wrtbwmon package/new/wrtbwmon
git clone -b master --depth 1 --single-branch https://github.com/brvphoenix/luci-app-wrtbwmon package/new/luci-app-wrtbwmon
# UPNP
rm -rf ./feeds/packages/net/miniupnpd
svn co https://github.com/coolsnowwolf/packages/trunk/net/miniupnpd feeds/packages/net/miniupnpd
# upx & ucl
svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
sed -i '/builddir dependencies/i\tools-y += ucl upx' tools/Makefile
sed -i '/builddir dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile
# USB Printer
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-usb-printer package/new/luci-app-usb-printer
# vlmcsd
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-vlmcsd package/new/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/vlmcsd package/lean/vlmcsd
# xlnetacc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-xlnetacc package/new/luci-app-xlnetacc
# Zerotier
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-zerotier package/new/luci-app-zerotier
# zram-swap
rm -rf package/system/zram-swap
svn co https://github.com/openwrt/openwrt/trunk/package/system/zram-swap package/system/zram-swap

# default settings and translate
cp -rf ../default-settings package/new/lean-translate

exit 0
