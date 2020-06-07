if [ $# -gt 2 ] || [ $# -lt 1 ] ; then 
echo 'Usage: <./scav.sh> <name_of_directory> <Depth>'
exit 0
fi

function scan_dir {

    for f in `ls $1 2> /dev/null`
    do
        
        	if [ -d $1/$f ]
        	then
            		dirs_num=$(($dirs_num+1))
            		scan_dir $1/$f
        	else
            		files_num=$(($files_num+1))
            		size=`stat -c%s $1/$f 2> /dev/null`
            		stat=`stat -c "%a %n" $1/$f 2> /dev/null | cut -c 1-3`
            		permission_array[$counter]=$stat
            		counter=$((counter+1))
            		total_size=$((size+total_size))
            		update_table $1/$f $size
            fi
        
    done
}

function update_table {
    if [ $2 -gt ${files_sizes[0]} ]; then
        file_names[5]=${file_names[4]}
        file_names[4]=${file_names[3]}
        file_names[3]=${file_names[2]}
        files_names[2]=${files_names[1]}
        files_names[1]=${files_names[0]}
        files_sizes[5]=${files_sizes[4]}
        files_sizes[4]=${files_sizes[3]}
        files_sizes[3]=${files_sizes[2]}
        files_sizes[2]=${files_sizes[1]}
        files_sizes[1]=${files_sizes[0]}
        files_names[0]=$1
        files_sizes[0]=$2
    elif [ $2 -gt ${files_sizes[1]} ]; then
        file_names[5]=${file_names[4]}
        file_names[4]=${file_names[3]}
        file_names[3]=${file_names[2]}
        files_names[2]=${files_names[1]}
        files_sizes[5]=${files_sizes[4]}
        files_sizes[4]=${files_sizes[3]}
        files_sizes[3]=${files_sizes[2]}
        files_sizes[2]=${files_sizes[1]}
        files_names[1]=$1
        files_sizes[1]=$2
    elif [ $2 -gt ${files_sizes[2]} ]; then
        file_names[5]=${file_names[4]}
        file_names[4]=${file_names[3]}
        file_names[3]=${file_names[2]}
        files_sizes[5]=${files_sizes[4]}
        files_sizes[4]=${files_sizes[3]}
        files_sizes[3]=${files_sizes[2]}
        file_names[2]=$1
        files_sizes[2]=$2
    elif [ $2 -gt ${files_sizes[3]} ]; then
        file_names[5]=${file_names[4]}
        file_names[4]=${file_names[3]}
        files_sizes[5]=${files_sizes[4]}
        files_sizes[4]=${files_sizes[3]}
        file_names[3]=$1
        files_sizes[3]=$2
    elif [ $2 -gt ${files_sizes[4]} ]; then
        files_names[5]=${file_names[4]}
        files_sizes[5]=${files_sizes[4]}
        file_names[4]=$1
        file_sizes[4]=$2
    elif [ $2 -gt ${files_sizes[5]} ]; then
        file_names[5]=$1
        file_sizes[5]=$2
    fi
}

files_num=0
dirs_num=0
total_size=0
counter=0
p_counter_a=0
p_counter_b=0
p_counter_c=0
p_counter_d=0
p_counter_e=0
p_counter_f=0
p_counter_g=0
p_counter_h=0
p_counter_i=0
p_counter_j=0
p_counter_k=0
p_counter_l=0
p_counter_m=0
files_names=(hidden_file hidden_file hidden_file hidden_file hidden_file)
files_sizes=(0 0 0 0 0)

perm_a="777"
perm_b="750"
perm_c="755"
perm_d="700"
perm_e="544"
perm_f="666"
perm_g="764"
perm_h="455"
perm_i="774"
perm_j="644"
perm_k="640"
perm_l="664"
perm_m="600"

scan_dir $1

echo Monitored Directory: $1

if [ $# -eq 2 ]; then 
	echo Depth: $2
	echo
else
	echo Depth: 0
	echo
fi

echo Number of directories: $dirs_num
echo Number of files: $files_num

printf '\nTotal size on disk: '
printf "MB " & echo "scale=2; $total_size/1024/1024" | bc -l


echo -e Permissions on files '\n'

for i in ${permission_array[@]}; do
    if [ $i -eq $perm_a ]; then
        p_counter_a=$((p_counter_a+1))
    elif [ $i -eq $perm_b ]; then
        p_counter_b=$((p_counter_b+1))
    elif [ $i -eq $perm_c ]; then
        p_counter_c=$((p_counter_c+1))
    elif [ $i -eq $perm_d ]; then 
        p_counter_d=$((p_counter_d+1))
    elif [ $i -eq $perm_e ]; then 
        p_counter_e=$((p_counter_e+1))
    elif [ $i -eq $perm_f ]; then
        p_counter_f=$((p_counter_f+1))
    elif [ $i -eq $perm_g ]; then
        p_counter_g=$((p_counter_g+1))
    elif [ $i -eq $perm_h ]; then
        p_counter_h=$((p_counter_h+1))
    elif [ $i -eq $perm_i ]; then
        p_counter_i=$((p_counter_i+1))
    elif [ $i -eq $perm_j ]; then
        p_counter_j=$((p_counter_j+1))
    elif [ $i -eq $perm_k ]; then
        p_counter_k=$((p_counter_k+1))
    elif [ $i -eq $perm_l ]; then
        p_counter_l=$((p_counter_l+1))
    elif [ $i -eq $perm_m ]; then
        p_counter_m=$((p_counter_m+1))
    fi
done


perm_counter=${#permission_array[@]}

echo $perm_a $((p_counter_a*100/perm_counter)) %
echo $perm_b $((p_counter_b*100/perm_counter)) %
echo $perm_c $((p_counter_c*100/perm_counter)) %
echo $perm_d $((p_counter_d*100/perm_counter)) %
echo $perm_e $((p_counter_e*100/perm_counter)) %
echo $perm_f $((p_counter_f*100/perm_counter)) %
echo $perm_g $((p_counter_g*100/perm_counter)) %
echo $perm_h $((p_counter_h*100/perm_counter)) %
echo $perm_i $((p_counter_i*100/perm_counter)) %
echo $perm_j $((p_counter_j*100/perm_counter)) %
echo $perm_k $((p_counter_k*100/perm_counter)) %
echo $perm_l $((p_counter_l*100/perm_counter)) %
echo $perm_m $((p_counter_m*100/perm_counter)) %
echo 

echo -e Large files '\n'

find $1 -printf '%p\t\t %s bytes \n'  2> /dev/null | sort -nrk 2 | head -5 | nl -w 2 -s  '. '
#n for numeric sorting, r for reverse order and k 2 for the second column.

echo -e '\nLastly Modified files\n'

ls -1t $1 | head -5 | nl -w 2 -s  '. ' 

echo -e '\nLastly Accessed files\n'

find $1 -type f | xargs stat --format '%n  %w' | sort -nrk 2 | head -5 | nl -w 2 -s  '. '

echo -e '\nLargest Dirs\n'

du -Sh $1 | sort -n -r | head -n 5 | nl -w 2 -s  '. '

echo -e '\nDirs with more files\n'

find $1 -type d -print0 | while read -d '' dir; do
    files=("$dir"/*)
    printf "%s \t\t %d\n" "$dir" "${#files[@]}"
done | sort -nrk 2 | head -5 | nl -w 2 -s  '. ' 
echo -e '\n'


