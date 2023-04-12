#!/bin/bash

if [[ $# -eq 0 ]] || [[ $1 == "--help" ]]
then
	echo "Usage:"
	echo "script.sh --date : Display today's date"
    echo "script.sh --logs [n] : Create n (default 100) log files with names logx.txt and write to them their name, the script that created them, and the current date"
	echo "script.sh --help : Display this help message"
	exit 0
fi

if [[ $1 == "--date" ]]
then
	date +%Y-%m-%d
elif [[ $1 == "--logs" ]]
then
	n=${2:-100}
    for (( i =  1; i <= $n; i++ ))
	do
		filename="log$i.txt"
		echo "Filename: $filename" >> $filename
		echo "Created by script: $0" >> $filename
		echo "Creation date: $(date +%Y-%m-%d)" >> $filename
    done
else
	echo "Invalid option: $1"
	echo "Use script.sh --help to display available options"
fi

if [[ -d ".git" ]]
then
	echo "Adding .gitignore file"
	echo "*log*" > .gitignore
	git add .gitignore
	git commit -m "Add .gitignore file"
	git push
	git checkout -b taskBranch
	git add .
	git commit -m "Add logs and .gitignore"
	git push
	git checkout main
	git merge taskBranch
	git tag v1.0
	git push --tags
fi
