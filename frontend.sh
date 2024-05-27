script_path=$(dirname $0)
source $script_path/common.sh

echo $script_path
exit

echo -e "\e[36m>>>>>>> Install Nginx <<<<<<<<<<<\e[0m"
dnf install nginx -y

echo -e "\e[32m>>>>>>> Enable Nginx <<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx

echo -e "\e[32m>>>>>>> Remove the App Directory<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m>>>>>>> Download the app content <<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32m>>>>>>> Unzip the Frontend <<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[32m>>>>>>> Copy the Roboshop Configuration <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32m>>>>>>> Restart Nginx <<<<<<<<<<<\e[0m"
systemctl restart nginx