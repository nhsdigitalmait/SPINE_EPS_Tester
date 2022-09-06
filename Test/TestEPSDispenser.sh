#!/bin/bash
# 
# Script for testing each message which the TKW EPS Simulator supports
# This script 
# 1. 
#

messageArchiveLocation="/home/riro/TKW-5.0.5/TKW/config/SPINE_EPS_Tester/EPS_MessageArchive"
tkwTransmitterBaseLocation="/home/riro/TKW-5.0.5/TKW/config/SPINE_EPS_Tester"
testLogLocation="/home/riro/TKW-5.0.5/TKW/config/SPINE_EPS_Tester/Test/logs/"$(date "+%Y%m%d%H%M%S")
mkdir $testLogLocation

# Define a timestamp function
timestamp() {
  date +"%T" # current time
}

mkLogFile(){
    #create Test log
    current_time=$(date "+%Y%m%d%H%M%S")
    mkdir $testLogLocation/$1
    testLog=$testLogLocation/$1/"$current_time"_"$1".log
    printf "Starting Test Run: \n" >> $testLog 
    echo $testLog
}

# create an array of message types
#declare -a arr=("PORX_IN060102UK30" "PORX_IN080101UK31" "PORX_IN090101UK31" "PORX_IN100101UK31" "PORX_IN132004UK30" "PORX_IN510101UK31" "PORX_IN540101UK31")
declare -a arr=("PORX_IN060102UK30")


cd $tkwTransmitterBaseLocation

#Give user time to change their mind
echo "Testing EPS Dispenser"
echo "Delete all previous logs"
read -n 1 -p "Press any key to continue..."
echo "continuing"


#Delete all existing logs
rm $tkwTransmitterBaseLocation/logs/*.log
rm $tkwTransmitterBaseLocation/transmitter_sent_messages_localhost_eps/*.log
rm $tkwTransmitterBaseLocation/simulator_saved_messages/*.metadata

#Delete any messages in source which may have been sent prviously
rm $tkwTransmitterBaseLocation/transmitter_source_for_localhost_eps/*.XML

#loop through all message types
for i in "${arr[@]}"
do
   echo testing Message Type: "$i"
   #Loop through all messages 
    for filepath in $messageArchiveLocation/$i/*.XML; do
        [ -e "$filepath" ] || continue

        # get the filename only from filepath
        xbase=${filepath##*/}
        filename=${xbase%.*}

        #Make the log file
        testLog=$(mkLogFile $filename)

        #copy request file into transmit folder
        cp $filepath  $tkwTransmitterBaseLocation/transmitter_source_for_localhost_eps
        
        #Send message to EPS Dispenser
        echo transmitting $filepath
        java -jar ../../TKW-x.jar -transmit tkw-x_Client_mth_eps_localhost_for_$i.properties >> $testLog

        #move the evidence into the test folder
        mv $tkwTransmitterBaseLocation/logs/*.log $testLogLocation/$filename/
        mv $tkwTransmitterBaseLocation/transmitter_sent_messages_localhost_eps/*.log $testLogLocation/$filename/
        mv $tkwTransmitterBaseLocation/simulator_saved_messages/*.metadata $testLogLocation/$filename/

        #remove the request file from transmit folder
        rm $tkwTransmitterBaseLocation/transmitter_source_for_localhost_eps/*.XML
    done
done
