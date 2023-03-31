#!/bin/bash
export $(cat  variables | xargs)
echo $INSTANCE_1
echo $INSTANCE_2
echo $INSTANCE_3
ansible-playbook -i inventory.ini play.yaml 
# ansible-playbook -i inventory.ini test.yaml