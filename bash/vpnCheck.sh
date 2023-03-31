#!/usr/bin/bash

stty -echo;
read -r -p "Enter root password: " PASSWORD;
stty echo;

if [[ -n $COUNTRY_REQUIRED ]]; then
	if [[ -n $1 ]]; then
		COUNTRY_CODE=$1;
	elif [[ -n $ENV_COUNTRY_CODE ]]; then
		COUNTRY_CODE=$ENV_COUNTRY_CODE;
	else
		COUNTRY_CODE="UA";
	fi
fi

if [[ -n $COUNTRY_CODE ]]; then
	read -r -p "Country code: " COUNTRY_CODE;
fi

while [ TRUE ] ; do
	if [[ "No VPN connections found." == `cyberghostvpn --status` ]]; then
		echo "Establishing new connection to "$COUNTRY_CODE;
		echo $PASSWORD | sudo -S cyberghostvpn --connect --country-code $COUNTRY_CODE;
		date;
	fi
	echo "Connection is established";
	sleep 30s ;
done;
