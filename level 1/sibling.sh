#!/bin/bash

file=$1

function create_sibling(){
    sudo useradd -m -d /home/$1 $2
    sudo usermod -aG sibling $2
    sudo touch /home/$1/website.txt

    sudo chown -R $title: /home/$1
    sudo chmod 400 /home/$1/website.txt
    sudo setfacl -R -m "u:$USER:rwx" /home/$1/website.txt
}

sudo groupadd sibling

if [ $# -eq 1 ]
then
    while read name title;
    do 
        create_sibling $name $title
    done < $file

else
    echo "Enter name:"
    read name
    echo "Enter sibling:"
    read title
    create_sibling $name $title
fi