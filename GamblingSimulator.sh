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
		GameDictionary[$i]=$totalAmount
done
		echo ${GameDictionary[@]}
}


getDailyResult

winValue=$( printf '%s\n' ${GameDictionary[@]} | sort -n | tail -1 )
echo $winValue
lossValue=$( printf '%s\n' ${GameDictionary[@]} | sort -n | head -1 )
echo $lossValue

profitValue=$( printf '%s\n' ${GameDictionary[@]} | awk '{sum+=$0}END{print sum}' )
echo $profitValue



