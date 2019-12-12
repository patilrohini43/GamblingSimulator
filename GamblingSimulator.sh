#!/bin/bash -x

echo "Welcome To Gambler"

#Constant
BET=1
DAY=20

#Varible
win=0
lost=0
totalAmount=0

declare -A GameDictionary

function getDailyResult()
{
for (( i=0; i<=$DAY; i++ ))
do
	stake=100
	higherResult=$(( stake + stake / 2 ))
	lowerResult=$(( stake / 2 ))
	while [ $higherResult -gt $stake ] && [ $lowerResult -lt $stake ]
	do
		checkResult=$(( $RANDOM % 2 ))
		case $checkResult in
		1)
			((stake++))
			((win++)) ;;
		0)
			((stake--))
			((lost++)) ;;
		esac
	done
		totalAmount=$(( 100  - $stake ))
		GameDictionary["Day"$i]=$totalAmount
done
		echo ${GameDictionary[@]}
}

getMonthlyResult(){

len=${#GameDictionary[@]}
for(( i=0; i<$len; i++ ))
do
	echo "day_$i ==== ${GameDictionary[Day$i]} "
done
}

getProfit()
{
profitValue=$( printf '%s\n' ${GameDictionary[@]} | awk '{sum+=$0}END{print sum}' )
echo $profitValue
}

###########  Main Method #################

getDailyResult
getMonthlyResult
getProfit
