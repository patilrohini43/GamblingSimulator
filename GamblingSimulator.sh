#!/bin/bash -x

echo "Welcome To Gambler"

#Constant
BET=1
DAY=20

#Varible
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
				stake=$(( $stake + $BET )) ;;
			0)
				stake=$(( $stake - $BET )) ;;
			esac
		done

		totalAmount=$(( 100  - $stake ))
		GameDictionary["Day"$i]=$totalAmount

	done

	len=${#GameDictionary[@]}
	for(( i=1; i<$len; i++ ))
	do
		echo "day_$i ==== ${GameDictionary[Day$i]} "
	done
}

getGamblingProfit()
{
	profitValue=$( printf '%s\n' ${GameDictionary[@]} | awk '{sum+=$0}END{print sum}' )
	echo $profitValue
}

getMonthDaysWinLoss()
{
	len=${#GameDictionary[@]}
	for(( i=2; i<$len; i++ ))
	do
 		day=$(( $i - 1))
		GameDictionary[Day$i]=$(( ${GameDictionary[Day$i]} + ${GameDictionary[Day$day]} ))
	done
	echo ${GameDictionary[@]}
}

getLuckyAndUnLuckyDay()
{
	len=${#GameDictionary[@]}
	for (( i=1; i<$len; i++))
	do
		echo "	Day $i" ${GameDictionary[Day$i]}
	done | sort -k3 -nr |awk 'NR==20{ print "UnLucky"  $0 } AND NR==1{ print "Lucky" $0 }'
}


function main()
{
	getDailyResult
	getGamblingProfit
	getMonthDaysWinLoss
	getLuckyAndUnLuckyDay
}

############## Main Method #############
main



