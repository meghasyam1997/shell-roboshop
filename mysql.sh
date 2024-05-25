echo -e "\e[36m>>>>>>> Disable Mysql <<<<<<<<<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[36m>>>>>>> Copy Mysql Repo <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>> Install Mysql <<<<<<<<<<<\e[0m"
dnf install mysql-community-server -y

echo -e "\e[36m>>>>>>> Enable Myql <<<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld

echo -e "\e[36m>>>>>>> Create password <<<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1