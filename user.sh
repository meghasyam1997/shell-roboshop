echo -e "\e[36m>>>>>>> Disable Nodejs <<<<<<<<<<<\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>> Install Nodejs <<<<<<<<<<<\e[0m"
dnf install nodejs -y

echo -e "\e[36m>>>>>>> Create App User <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create App Directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download App Content <<<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m>>>>>>> Unzip the user <<<<<<<<<<<\e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[36m>>>>>>> Download Dependencies <<<<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>> Copy the Service <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>> Daemon Reload <<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>> Enable User Service <<<<<<<<<<<\e[0m"
systemctl enable user
systemctl start user