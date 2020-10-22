#! /bin/bash -x

echo 'Welcome to Flip Coin Combination Program'

getCoinStatus(){
    if [ $(( RANDOM%2 )) -eq 1 ]
    then
        echo "Head"
    else
        echo "Tail" 
    fi       
}
