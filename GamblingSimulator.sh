#!/bin/bash -x

echo "Welcome To Gambler"

#Constant
BET=1
STAKE=100

checkResult=$(( $RANDOM % 2 ))
case $checkResult in
	0)
		echo "Win" ;;
	1)
		echo "Loss" ;;
esac
