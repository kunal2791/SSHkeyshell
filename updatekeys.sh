#!/usr/bin/env bash
# !/bin/bash
# Author " Rohit Miglani "
# Global variables

env="demo performance test smb-test smb-demo  tc-server"
domain_name="nginx domain super-admin mongo rabbitmq1 rabbitmq2 rabbitmq3"
tc_servers="tc-server tc3-server tc2-server tc1-server"

echo -e "  \n*********** This script updates user keys in specific environments ************\n"

read -p " Please select from below options :

         1. To update keys in all env ( demo performance test smb-test smb-demo  tc-server )
         2. To update key in anyone of the env ( demo performance test smb-test smb-demo  tc-server )
         3. To Update key in Database_backup server
         4. To update key in Teamcity server

 Enter Your Input : " option

# Function to specify how to use the script

usage_f() {
    echo -e " \n"
    echo -e "    Script usage: sh $0 "
    echo -e "    Select the correct option from the list as numeric value  for eg : 1 or 2 or 3 or 4 "
    echo -e "    Enter the key name which is present under public_keys folder for eg name_key.pub\n "
    exit
}

# Function to read user keys

read_f() {

read -p "enter name  of your keys( eg: name_key.pub ) : "  value

}

# Function to pass keys to a specific environment

pass_keys_f() {

env=$1

# updating keys

 for server in $domain_name
   do
    scp -r $value ec2-user@$server.$env.rocketips.net:/tmp
    ssh ec2-user@$server.$env.rocketips.net "bash -c 'echo -e " " >> /home/ec2-user/.ssh/authorized_keys && cd /tmp && cat $value >> /home/ec2-user/.ssh/authorized_keys'"

   echo -e "keys updated successfully for "$value
   echo -e "\n"
 done
}

tc_server() {
 for tc in $tc_servers
  do
 scp -r $value ubuntu@$tc.rocketips.net:/tmp
  ssh ubuntu@$teamcity.rocketips.net "bash -c 'echo -e " " >> /home/ubuntu/.ssh/authorized_keys && cd /tmp && cat $value >> /home/ubuntu/.ssh/authorized_keys'"
  echo -e "keys updated successfully for "$value
  echo -e "\n"
 done
}


if [ $option -eq 1 ]

then

read_f

for i in $env

do

pass_keys_f "$i"
tc_server "$i"

done


elif [ $option -eq 2 ]

then

read_f

read -p " Enter the environment name : " env
if [ $env==tc-server ]
 then
   tc_server
 else
pass_keys_f "$env"
#tc_server "$env"
fi
elif [ $option -eq 3 ]

then

# updating keys in Database Backup  server

read_f

  scp -r $value ubuntu@database.abc.net:/tmp
  ssh ubuntu@database.abc.net "bash -c 'echo -e " " >> /home/ubuntu/.ssh/authorized_keys && cd /tmp && cat $value >> /home/ubuntu/.ssh/authorized_keys'"
  echo -e "keys updated successfully for "$value
  echo -e "\n"


elif [ $option -eq 4 ]

then
# updating keys in Teamcity  server

read_f
tc_server "$env"

fi
