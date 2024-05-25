echo -e "\e[36m>>>>>>> Install Maven <<<<<<<<<<<\e[0m"
dnf install maven -y

echo -e "\e[36m>>>>>>> Add App User <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create App Directory<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download App Content <<<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

echo -e "\e[36m>>>>>>> Unzip the shipping <<<<<<<<<<<\e[0m"
unzip /tmp/shipping.zip
cd /app

echo -e "\e[36m>>>>>>> Download Dependencies <<<<<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m>>>>>>> Copy the Service <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>> Daemon Reload <<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>> Enable Shipping <<<<<<<<<<<\e[0m"
systemctl enable shipping
systemctl start shipping

echo -e "\e[36m>>>>>>> Install Mysql <<<<<<<<<<<\e[0m"
dnf install mysql -y
mysql -h mysql-dev.devops1997.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m>>>>>>> restart Shipping <<<<<<<<<<<\e[0m"
systemctl restart shipping