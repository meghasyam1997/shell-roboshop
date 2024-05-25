echo -e "\e[36m>>>>>>> Install Python <<<<<<<<<<<\e[0m"
dnf install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>> Create App User <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create App Directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download App Content <<<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[36m>>>>>>> Unzip the Payment <<<<<<<<<<<\e[0m"
unzip /tmp/payment.zip
cd /app

echo -e "\e[36m>>>>>>> Download Python Dependencies <<<<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>> Copy payment Service <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>> Enable Payment Service <<<<<<<<<<<\e[0m"
systemctl enable payment
systemctl start payment