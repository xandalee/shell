#!/bin/bash
#please install pinentry-gui package which is required.
echo "Welcome, I am ready to encrypt a file/folder for you"
echo "currently I have a limitation, Place me to thh same folder, where a file to be 
encrypted is present"
echo "Enter the Exact File Name with extension"
read file;
gpg -c $file
echo "I have encrypted the file successfully..."
echo "Now I will be removing the original file"
rm -rf $file
#usage "gpg -d filename.gpg > filename" to decrypt it.
exit 0