#!/bin/bash -x

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
		higherResult=$(( stake + stake * 50 / 100 ))
		lowerResult=$(( stake - stake * 50 / 100 ))

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

function getGamblingProfit()
{
	profitValue=$( printf '%s\n' ${GameDictionary[@]} | awk '{sum+=$0}END{print sum}' )
	echo $profitValue
}

function getMonthDaysWinLoss()
{
	len=${#GameDictionary[@]}
	for(( i=2; i<$len; i++ ))
	do
 		day=$(( $i - 1))
		GameDictionary[Day$i]=$(( ${GameDictionary[Day$i]} + ${GameDictionary[Day$day]} ))
	done
	echo ${GameDictionary[@]}
}

function getLuckyAndUnLuckyDay()
{
	len=${#GameDictionary[@]}
	for (( i=1; i<$len; i++))
	do
		echo "	Day $i" ${GameDictionary[Day$i]}
	done | sort -k3 -nr |awk 'NR==20{ print "UnLucky"  $0 } AND NR==1{ print "Lucky" $0 }'
}

gamblingMain()
{
	getDailyResult
	profit=$( getGamblingProfit )
	getMonthDaysWinLoss
	getLuckyAndUnLuckyDay

	echo "Amount For Playing Game $profit " 
	if [[ $profit -gt 0 ]]
	then
		read -p "Would you like to play game 1.Play Game 2.Stop" choice
		echo $choice
		case $choice in
			1)  gamblingMain ;;
			2)  echo "Gambling Stop" ;;
		esac
	else
		echo "Insufficient Amount...Thanks For Playing"
	fi

}

################# Main Method ################
gamblingMain
