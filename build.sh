#!/bin/bash
export $(cat  variables | xargs)

#write your ci/cd code here
echo $SSH_PASSWORD > passwd.file
apt update
apt install sshpass rsync ansible python3 -y
ansible-galaxy collection install gluster.gluster 
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.docker

if [ ! -f /root/.ssh/id_rsa ]; then
    ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
fi

sshpass -f passwd.file ssh-copy-id -o StrictHostKeyChecking=no root@$INSTANCE_1
sshpass -f passwd.file ssh-copy-id -o StrictHostKeyChecking=no root@$INSTANCE_2
sshpass -f passwd.file ssh-copy-id -o StrictHostKeyChecking=no root@$INSTANCE_3

echo "[all]" > inventory.ini
echo $INSTANCE_1 >> inventory.ini
echo $INSTANCE_2 >> inventory.ini
echo $INSTANCE_3 >> inventory.ini
echo "[gluster_server]">> inventory.ini
echo $INSTANCE_1 >> inventory.ini

ansible-playbook -i inventory.ini play.yaml --extra-vars "backend_1=$INSTANCE_1 backend_2=$INSTANCE_2 backend_3=$INSTANCE_3"
# --extra-vars "backend_1=$INSTANCE_1 backend_2=$INSTANCE_2 backend_3=$INSTANCE_3"