#!/usr/bin/env bash

if [ -z $1 ]; then
    echo "Require subject"
    exit 1
fi

subject=$1

key_name="id_rsa"

if [ ! -z $2 ]; then
    key_name=$2
fi

ssh_port=19374

if [ ! -z $3 ]; then
    ssh_port=$3
fi

echo "Copy private key $key_name to vdn"

scp -P $ssh_port ~/.ssh/$key_name root@localhost:/root/.ssh/edu_rsa

echo "Clone project git@github.com:claudusd-edu/licpro-2022-js-project-$subject.git"

ssh -p $ssh_port root@localhost "GIT_SSH_COMMAND='ssh -i /root/.ssh/edu_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'  git clone git@github.com:claudusd-edu/licpro-2022-js-project-$subject.git /root/javascript"


echo "Mount dir"
mkdir -p ~/vdn-javascript

sshfs root@localhost:/root/javascript ~/vdn-javascript -p $ssh_port
