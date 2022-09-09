#Do the validation here.
#This is to validate user is root ot sudo

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo  -e "\e[31m Try executing the script with a sudo or root user \e[0m"
    exit 1
fi

# Declare the stat function and call it when it's needed.
stat(){
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m SUCCESS \e[0m"
    else 
        echo -e "\e[31m Failure. Look for the log \e[0m"
    fi
}