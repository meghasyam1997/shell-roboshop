echo -e "\e[36m>>>>>>> Remove Nodejs <<<<<<<<<<<\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>> Install Nodejs <<<<<<<<<<<\e[0m"
dnf install nodejs -y

echo -e "\e[36m>>>>>>> Add app user <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create App directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download App content <<<<<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[36m>>>>>>> Unzip the app <<<<<<<<<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[36m>>>>>>> Install nodejs Dependencies <<<<<<<<<<<\e[0m"
cd /app
npm install

echo -e "\e[36m>>>>>>> Copy service file <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>> Daemon-reload <<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>> Enable the cart Service <<<<<<<<<<<\e[0m"
systemctl enable cart
systemctl start cart