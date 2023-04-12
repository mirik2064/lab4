#!/bin/bash

if [[ $# -eq 0 || $1 == "--help" ]]; then
	echo "Usage script.sh [OPTIONS]:"
	echo "	-h, --help        Display this help message"
	echo "	-d, --date        Display today's date"
    echo "	-l, --logs [N]    Create N (default 100) log files with names logx.txt"
    echo "	-e, --error [N]   Create N (default 100) error files"
    echo "	--init [link]     Clone the repository to the current directory and add the script directory to PATH"
	exit 0
fi

if [[ $1 == "--date" || $1 == "-d" ]]; then
	date +%Y-%m-%d

elif [[ $1 == "--init" ]]; then
	git clone $2
	echo 'export PATH="$PATH:'$(pwd)'"' >> ~/.bashrc
    source ~/.bashrc

elif [[ $1 == "--error" || $1 == "-e" ]]; then
	n=${2:-100}
	
	for (( i =  1; i <= $n; i++ )) do
		mkdir -p "error$i"
        echo "Filename: error$i.txt" > "error$i/error$i.txt"
        echo "Created by script: $0" >> "error$i/error$i.txt"
        echo "Creation date: $(date)" >> "error$i/error$i.txt"
	done

elif [[ $1 == "--logs" || $1 == "-l" ]]; then
	n=${2:-100}

    for (( i =  1; i <= $n; i++ )) do
		filename="log$i.txt"
		echo "Filename: $filename" >> $filename
		echo "Created by script: $0" >> $filename
		echo "Creation date: $(date +%Y-%m-%d)" >> $filename
    done

else
	echo "Invalid option: $1"
	echo "Use script.sh --help to display available options"
fi