echo -e "\e[36m>>>>>>> Download the Repositories <<<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m>>>>>>> Install Rabbitmq <<<<<<<<<<<\e[0m"
dnf install rabbitmq-server -y

echo -e "\e[36m>>>>>>> Enable Rabbitmq-server <<<<<<<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[36m>>>>>>> Add server User <<<<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123

echo -e "\e[36m>>>>>>> Permission to User <<<<<<<<<<<\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
