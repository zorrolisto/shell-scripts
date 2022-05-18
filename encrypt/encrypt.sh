#!/bin/bash

encrypt_text(){
	local file_to_encrypt=$1
	local file_encrypted="./encryptionFiles/file.enc"
	openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in "$file_to_encrypt" -out "$file_encrypted"
    echo "File encrypted: $file_encrypted"
}
desencrypt_text(){
	local file_to_desencrypt=$1
	local file_desencrypted="./encryptionFiles/file.txt"
	openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in "$file_to_desencrypt" -out "$file_desencrypted"
    echo "File desencrypted: $file_desencrypted"
}

show_menu(){
    echo ""
	echo "Choose a alternative:"
	echo "1) Encrypt a file"
	echo "2) Desencrypt a file"
	echo "3) Insert an encrypt text to an image"
	echo "4) Extract an encrypt text to an image"
    echo -n "Opción a elegir: > "
}
encrypt_file_option(){
    echo "Insert the path of the file to encrypt"
    read path_of_file_to_encrypt
    encrypt_text "$path_of_file_to_encrypt"
}
desencrypt_file_option(){
    echo "Insert the path of the file to desencrypt"
    read path_of_file_to_desencrypt
    desencrypt_text "$path_of_file_to_desencrypt"
}
insert_encrypt_file_to_image_option(){
    echo "insert_encrypt_file_to_image_option"
}
extract_encrypt_file_to_image_option(){
    echo "extract_encrypt_file_to_image_option"
}

select_alternative(){
    echo ""
    case $1 in
        1)
            encrypt_file_option
        ;;
        2)
            desencrypt_file_option
        ;;
        3)
            insert_encrypt_file_to_image_option
        ;;
        4)
            extract_encrypt_file_to_image_option
        ;;
        *)
            echo "No hay esa opción"
        ;;

    esac
}

main(){
	show_menu
	read alternative_choosed
    select_alternative "$alternative_choosed"
}

main

#encrypt:
#openssl enc -aes-256-cbc -in file.txt -out file.enc
#desencrypt:

openssl enc -d -aes-256-cbc -in "$file_to_desencrypt" -out "$file_desencrypted"
#openssl enc -d -aes-256-cbc -in file.enc -out file.txt
