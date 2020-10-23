#! /bin/bash -x

echo 'Welcome to Flip Coin Combination Program'

declare -A combinationCountDict
declare -A combinationPercentDict

getCoinStatus(){
    if [ $(( RANDOM%2 )) -eq 1 ]
    then
        echo "H"
    else
        echo "T" 
    fi       
}


storePercent(){

   local totalCount=0

   for key in ${!combinationCountDict[@]}
   do
     totalCount=$(( totalCount + combinationCountDict[$key] ))
   done


   for key in ${!combinationCountDict[@]}
   do
      local selfCount=${combinationCountDict[$key]}

      combinationPercentDict[$key]=`awk 'BEGIN{printf "%.2f", ( ('$selfCount'/'$totalCount')*100 ) }'`
   done

   
}



storeCount(){
  
  local coinCombination=$1
  local flag=0

  for key in ${!combinationCountDict[@]}
  do
    if [ $coinCombination = $key ]
    then
        flag=1
        combinationCountDict[$key]=$(( combinationCountDict[$key] + 1 ))
        break
    fi
  done

  if [ $flag -eq 0 ]
  then
      combinationCountDict[$coinCombination]=1
  fi
 
}

singletCombination(){
    local count=0
    while [ $count -lt 100 ]
    do
      local coinStatus=$(getCoinStatus)

      storeCount $coinStatus

      ((count++))
    done
    storePercent
}


doubletCombination(){
    local count=0
    while [ $count -lt 100 ]
    do
      local coinStatus1=$(getCoinStatus)
      local coinStatus2=$(getCoinStatus)
      
      local coinStatus=`echo $coinStatus1""$coinStatus2`

      storeCount $coinStatus

      ((count++))
    done
    storePercent
}

TripletCombination(){
    local count=0
    while [ $count -lt 100 ]
    do
      local coinStatus1=$(getCoinStatus)
      local coinStatus2=$(getCoinStatus)
      local coinStatus3=$(getCoinStatus)

      
      local coinStatus=`echo $coinStatus1""$coinStatus2""$coinStatus3`

      storeCount $coinStatus

      ((count++))
    done
    storePercent
}


singletCombination
doubletCombination
TripletCombination

echo ${combinationCountDict[@]}
echo ${combinationPercentDict[@]}


