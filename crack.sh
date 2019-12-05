#!/bin/bash
info='#====================================================
#	面板破解成功，感谢你的使用！
#	System: Required: CentOS 6/7,Debian 8/9,Ubuntu 16+
#	version: 1.0
#	Author: voiin
#	Blogs: http://www.axrni.cn&&http://voiin.com
#====================================================='
wget -N --no-check-certificate https://raw.githubusercontent.com/voiin/bt-panel/master/install.sh && bash install.sh
if [ -f "/www/server/panel/static/css/site.css" ];then
	echo "开始安装专业版"
else
	echo "安装失败"		
	exit
fi
wget -N --no-check-certificate https://raw.githubusercontent.com/voiin/bt-panel/master/update.sh && bash update.sh pro
crack=$(cat /www/server/panel/class/common.py|grep "get_order_status")
_164=$(sed -n 164p /www/server/panel/class/common.py)
if [ "$crack" = "$_164" ];then
	echo "开始生成panel默认信息"
else
	exit
fi
address=$(cat /www/server/panel/data/iplist.txt)
port='8888'
arry=""
for x in $(seq 1 6)
do
	arry="$arry$x"
done
username=$(cd /www/server/panel && python tools.py panel $arry) 

echo -e "\033[33m==========宝塔面板专业板已为你装好，下面是面板信息================\033[0m"
echo -e "\033[33mBt-Panel: http://$address:$port\033[0m"
echo -e "\033[33musername: $username\033[0m"
echo -e "\033[33mpassword: $arry\033[0m"
echo -e "\033[31mWarning:\033[0m"
echo -e "\033[31mIf you cannot access the panel, \033[0m"
echo -e "\033[31mrelease the following port (8888|888|80|443|20|21) in the security group\033[0m"
echo -e "\033[33m==================================================================\033[0m"

while [ "$go" != 'y' ] && [ "$go" != 'n' ]
do
	read -p "是否为你开启破解之旅?(y/n): " go
done

	if [ "$go" = 'n' ];then
		exit
	fi

cd /www/server/panel/class/
echo "正在进入配置文件......" && sleep 1
sed -i '164d' common.py
echo "正在植入破解代码......" && sleep 1
sed -i "163a\        data = {'status' : True,'msg' : {'endtime' : 32503651199}}" common.py
echo "正在还原编码格式......" && sleep 1
sed -i -e 's/
$//' common.py
touch /www/server/panel/data/userInfo.json
sleep 5
/etc/init.d/bt restart
echo -e "\033[36m$info\033[0m"
rm -f crack.sh

