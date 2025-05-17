# IntegrationTools

用于Koolshare路由器的辅助工具集合，帮助解锁更多功能。

## 禁用包检测功能

此工具可以禁用Koolshare系统的包检测功能，允许安装非官方插件（如SSR等）。

### 方法一：使用脚本自动执行（推荐）
1. 在「系统管理」-「系统设置」里面打开「Allow SSH password login」的设置
2. 在 [putty.org](https://www.putty.org) 下载 Putty 并安装（或使用其他SSH工具）
3. 在 Putty 中使用路由器的 IP 地址来连接
4. 输入登录路由器的账号、密码

通过以下任一命令直接执行:

```bash
# 方法1: 使用curl
sh -c "$(curl -sSL https://raw.githubusercontent.com/liu294100/IntegrationTools/main/Asus_merlin/disable_detect_package.sh)"

# 方法2: 使用wget
sh -c "$(wget -qO- https://raw.githubusercontent.com/liu294100/IntegrationTools/main/Asus_merlin/disable_detect_package.sh)"
```

### 方法二：手动SSH操作

如果您更喜欢手动操作，请按照以下步骤进行：

1. 在「系统管理」-「系统设置」里面打开「Allow SSH password login」的设置
2. 在 [putty.org](https://www.putty.org) 下载 Putty 并安装（或使用其他SSH工具）
3. 在 Putty 中使用路由器的 IP 地址来连接
4. 输入登录路由器的账号、密码
5. 输入以下命令来禁用包检测：
   ```
   sed -i 's/\tdetect_package/\t# detect_package/g' /koolshare/scripts/ks_tar_install.sh
   ```
6. 完成后，您可以重新离线安装 SSR 或其他非官方插件

### 功能说明

此工具会执行以下操作:
1. 注释掉`ks_tar_install.sh`文件中的`detect_package`代码行
2. 这样可以绕过Koolshare对非官方插件的检测机制
3. 使您能够安装各种第三方插件（如SSR、V2Ray等）

### 恢复方法

如果需要恢复原始功能，可以手动运行:
```bash
# 方法一：如果使用了自动脚本（会自动创建备份）
cp -f /koolshare/scripts/ks_tar_install.sh.bak /koolshare/scripts/ks_tar_install.sh

# 方法二：手动恢复检测功能
sed -i 's/\t# detect_package/\tdetect_package/g' /koolshare/scripts/ks_tar_install.sh
```

## 常见问题

1. **为什么要禁用包检测？**
   - Koolshare路由器固件默认只允许安装官方插件，禁用包检测后可以安装第三方/非官方插件

2. **修改后有什么风险？**
   - 禁用检测可能导致安装不兼容的插件，请确保您了解所安装插件的来源和兼容性

3. **操作失败怎么办？**
   - 请检查您是否有SSH权限，以及是否正确输入了命令
   - 确认您的路由器运行的是Koolshare固件
