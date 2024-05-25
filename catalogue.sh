echo -e "\e[36m>>>>>>> Disable Nodejs <<<<<<<<<<<\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>> Install Nodejs <<<<<<<<<<<\e[0m"
dnf install nodejs -y

echo -e "\e[36m>>>>>>> App User <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create App Directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download App Content <<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>> Unzip the catalogue <<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>> Install Nodejs Dependencies <<<<<<<<<<<\e[0m"
cd /app
npm install

echo -e "\e[36m>>>>>>> Copy the catalogue Service <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>> Daemon Reload <<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>> Enable Catalogue Service <<<<<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[36m>>>>>>> Copy Mongo Repo <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>> Install MongoDB <<<<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y
mongo --host mongodb-dev.devops1997.online </app/schema/catalogue.js