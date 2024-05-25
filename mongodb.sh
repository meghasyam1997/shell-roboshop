echo -e "\e[36m>>>>>>> Copy MongoRepo File <<<<<<<<<<<\e[0m"
cp /home/centos/shell-roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>> Install MongoDB <<<<<<<<<<<\e[0m"
dnf install mongodb-org -y

echo -e "\e[36m>>>>>>> Enable mogodb <<<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl start mongod

echo -e "\e[36m>>>>>>> Change port <<<<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[36m>>>>>>> Restart Mongodb <<<<<<<<<<<\e[0m"
systemctl restart mongod