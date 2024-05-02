#!/bin/bash
while true; do
	date=$(date "+%a %H:%M %d/%m/%Y")
	cpu=$(top -bn1 | grep Cpu)	
	ram=$(free -h | grep Mem)
	storage=$(df -h | grep /home)
	battery=$(acpi V | grep -o ...%)
	xsetroot -name "[DISK ${storage:34:3} RAM ${ram:27:5} CPU ${cpu:19:3}% BAT$battery] [$date]"
	sleep 3 
done
