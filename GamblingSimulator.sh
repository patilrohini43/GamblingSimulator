#!/bin/bash -x

echo "Welcome To Gambler"

#Constant
BET=1

#Varible
stake=100

function getDailyResult()
{
higherResult=$(( stake + stake / 2 ))
lowerResult=$(( stake / 2 ))

while [ $higherResult -gt $stake ] && [ $lowerResult -lt $stake ]
do
checkResult=$(( $RANDOM % 2 ))
case $checkResult in
	0)
		((stake++)) ;;
	1)
		((stake--)) ;;
esac
done
echo $stake
}

getDailyResult
