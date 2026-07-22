echo -n "Please enter a foldername: "
read d_name
echo
if [[ -d $d_name ]]; then
	names=($(ls ${d_name}))
	f_count=0
	dir_count=0

	#creating log files
	f_log="$d_name.txt"
	f_count_log=$d_name-count.txt
	touch $f_log
	touch $f_count_log
	#loops through array of filenames
	for x in ${names[@]}
	do
		if [[ -f $d_name/$x ]]; then
			ext=$(ls $d_name/$x | rev | cut -d"." -f1 -s | rev ) #file extension
			if [[ -z $ext ]]; then
				ext="_others"
			fi
			if ! [[ -d $d_name/$ext ]]; then
				echo "Subdirectory created: '$d_name/$ext/'" | tee -a $f_log
				dir_count=$((dir_count+1))
				mkdir $d_name/$ext
			fi
			echo "Moving '$d_name/$x' -> '$d_name/$ext/$x'" | tee -a $f_log
			mv $d_name/$x $d_name/$ext/
			f_count=$((f_count+1))
		fi
	done
	echo
	echo "Files moved: $f_count" | tee -a $f_count_log
	echo "Subdirectories created: $dir_count" | tee -a $f_count_log
else
	echo "'$d_name' does not exist"
	exit
fi
