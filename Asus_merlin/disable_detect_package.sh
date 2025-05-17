#!/bin/sh

# 脚本名称: disable_detect_package.sh
# 功能描述: 禁用koolshare的detect_package检测功能
# 作者: liu294100
# GitHub: https://github.com/liu294100/IntegrationTools

echo "======================================================"
echo "开始禁用koolshare检测包功能..."
echo "======================================================"

# 检查目标文件是否存在
if [ ! -f "/koolshare/scripts/ks_tar_install.sh" ]; then
    echo "错误: 未找到目标文件 /koolshare/scripts/ks_tar_install.sh"
    echo "请确认您在koolshare系统上运行此脚本"
    exit 1
fi

# 备份原始文件
cp -f /koolshare/scripts/ks_tar_install.sh /koolshare/scripts/ks_tar_install.sh.bak
if [ $? -ne 0 ]; then
    echo "错误: 无法创建备份文件，请检查权限"
    exit 1
fi
echo "已创建原始文件备份: /koolshare/scripts/ks_tar_install.sh.bak"

# 执行替换操作
sed -i 's/\tdetect_package/\t# detect_package/g' /koolshare/scripts/ks_tar_install.sh
if [ $? -ne 0 ]; then
    echo "错误: 执行sed命令失败"
    echo "正在恢复备份..."
    cp -f /koolshare/scripts/ks_tar_install.sh.bak /koolshare/scripts/ks_tar_install.sh
    exit 1
fi

# 验证修改
if grep -q "# detect_package" /koolshare/scripts/ks_tar_install.sh; then
    echo "✓ 成功修改文件，detect_package已被注释"
    echo "======================================================"
    echo "操作完成！koolshare的包检测功能已禁用"
    echo "现在您可以安装非官方插件了"
    echo "======================================================"
else
    echo "错误: 修改未成功应用，请检查文件权限或手动执行以下命令:"
    echo "sed -i 's/\tdetect_package/\t# detect_package/g' /koolshare/scripts/ks_tar_install.sh"
    echo "正在恢复备份..."
    cp -f /koolshare/scripts/ks_tar_install.sh.bak /koolshare/scripts/ks_tar_install.sh
    exit 1
fi

exit 0