#!/bin/bash
info='#================================================
#	面板破解成功，感谢你的使用！
#	System: Required: CentOS 6/7,Debian 8/9,Ubuntu 16+
#	version: 1.0
#	Author: wilin
#	Blogs: www.axrni.cn&&voiin.com
#================================================='
wget -N --no-check-certificate https://raw.githubusercontent.com/voiin/bt-panel/master/install.sh && bash install.sh
if [ -f "/www/server/panel/static/css/site.css" ];then
	echo "开始下载专业版";
else
	echo "安装失败";		
	exit;
fi
wget -O update.sh https://raw.githubusercontent.com/voiin/bt-panel/master/update_pro.sh && bash update.sh
address=$(cat /www/server/panel/data/iplist.txt)
port='8888'
arry=""
for x in $(seq 1 6)
do
	arry="$arry$x"
done
cd /www/server/panel && python tools.py panel $arry
username=$(cd /www/server/panel && python tools.py panel $arry) 
echo -e "=================================================================="
echo -e "宝塔面板专业板已为你装好，下面是面板信息"
echo -e "Bt-Panel: http://$address:$port"
echo -e "username: $username"
echo -e "password: $arry"
echo -e "\033[33mWarning:\033[0m"
echo -e "\033[33mIf you cannot access the panel, \033[0m"
echo -e "\033[33mrelease the following port (8888|888|80|443|20|21) in the security group\033[0m"
echo -e "=================================================================="

while [ "$go" != 'yes' ] && [ "$go" != 'no' ]
do
	read -p "是否为你开启破解之旅?(yes/no): " go
done

	if [ "$go" = 'no' ];then
		exit;
	fi

cd /www/server/panel/class/
sed -i '163d' common.py
sed -i '162a\        data = {'status' : True,'msg' : {'endtime' : 32503651199}};' common.py
cd /www/server/panel/data/
touch userInfo.json
/etc/init.d/bt restart
echo "$info"
rm -rf crack.sh

