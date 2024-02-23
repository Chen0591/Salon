#!/bin/bash  
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"  
echo -e "\n~~~~~ MY SALON ~~~~~\n"  
 
MAIN_MENU() {  
  if [[ $1 ]]  
  then  
    echo -e "\n$1"  
  fi  
  echo "Welcome to My Salon, how can I help you?"   
  echo -e "\n1) cut\n2) color\n3) style"  
  read SERVICE_ID_SELECTED  

  case $SERVICE_ID_SELECTED in
1) Dating ;;
2) Dating ;;
3) Dating ;;
*) MAIN_MENU "Please enter a valid option."
esac
}
Dating(){
  echo "What's your phone number?"
  read CUSTOMER_PHONE
  #get customer message
  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE';")
  #if no customer's meassage
  if [[ -z $CUSTOMER_NAME ]]
  then
  echo "I don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  echo "What time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME
  #insert date into customers
  INSERT_CUSTOMER=$($PSQL "insert into customers(phone,name) values('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
  Get_cid=$($PSQL "select customer_id from customers where name='$CUSTOMER_NAME';");
  INSERT_ap=$($PSQL "insert into appointments(customer_id,service_id,time) values($Get_cid,$SERVICE_ID_SELECTED,'$SERVICE_TIME');")
  echo "I have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."
  #else
  else
  SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED;")
  echo "What time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
  fi
}
MAIN_MENU
