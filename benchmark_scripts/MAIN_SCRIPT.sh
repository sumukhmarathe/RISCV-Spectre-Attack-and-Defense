#!/usr/bin/bash

# Creating binaries for all the files

echo "Start of script"
rm runtimes_compiled.txt
rm logs_LFENCE.txt
rm logs_inorder.txt
rm logs_cacheflush.txt
rm logs_o3.txt



compiler_binary=$1

#### Create Binaries for code without LFENCE

# cd ../benchmark_codes/baseline_programs
export PATH=/opt/riscv/bin:$PATH 

for file in ../benchmark_codes/baseline_programs/*.c; do
	filename=${file::-2}
	src=${filename:37}
	#echo "$filename"
	$compiler_binary -g $file -o ../benchmark_codes/baseline_programs/Binaries/$src -static
	
	#if riscv64-unknown-elf-gcc -g $file -o ${file::-2} > grep -q 'error'; then
   		#echo "Not compiled $file"
   	#else 
   		#echo "Compiled $file"
	#fi

done



##### Create Binaries for code with LFENCE

# cd /script_test/LFENCE_programs
# export PATH=/opt/riscv/bin:$PATH 

for file in ../benchmark_codes/LFENCE_programs/*.c; do
	filename=${file::-2}
	src=${filename:34}
	#echo "$filename"
	$compiler_binary -g $file -o ../benchmark_codes/LFENCE_programs/Binaries/$src -static
	
	#if riscv64-unknown-elf-gcc -g $file -o ${file::-2} > grep -q 'error'; then
   		#echo "Not compiled $file"
   	#else 
   		#echo "Compiled $file"
	#fi

done



###### Building on GEM5 for the binaries


for file in ../benchmark_codes/baseline_programs/Binaries/*; do
	#filename=${file::-2}
	src=${file:46}
	echo "$file"
	
	
	
	
	
	
	
	##### Building on GEM5 inorder ######
	
	# cd /gem5
	../gem5/build/RISCV/gem5.opt ../gem5/configs/learning_gem5/part1/two_level_inorder.py $file > logs_inorder.txt
	#build/RISCV/gem5.opt configs/learning_gem5/part1/two_level_inorder.py $file >> /script_test/LFENCE_programs/logs_full_LFENCE.txt
	
	
	if grep "error" logs_inorder.txt; then
   		echo "Error in building $src" 
   	else 
   	   grep "^$" logs_inorder.txt >>  runtimes_compiled.txt
   	  # echo " " >> /script_test/LFENCE_programs/runtimes_compiled.txt
   	   echo "$src" >> runtimes_compiled.txt
   	   echo "Runtime for inorder" >> runtimes_compiled.txt
   	   #grep "Exiting @ tick" /script_test/logs_LFENCE.txt >>  /script_test/runtimes_compiled.txt
   	   awk '$3 == "tick" {print $4}' logs_inorder.txt >> runtimes_compiled.txt
   	    temp2=`awk '/'$src'/{nr[NR+4]; next}; NR in nr' runtimes_compiled.txt`
   	  echo $temp2
	fi
	
	#echo "Speedup:" >> /script_test/runtimes_compiled.txt
	#echo "scale=4; $temp2 / $temp1" | bc >> /script_test/runtimes_compiled.txt
	
	
	
	
	
	
	###### Building on GEM5 o3 with no LFENCE##############
	
	# cd /gem5
	../gem5/build/RISCV/gem5.opt ../gem5/configs/learning_gem5/part1/two_level.py $file > logs_o3.txt
	#build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py $file >> /script_test/LFENCE_programs/logs_full_LFENCE.txt
	
	
	if grep "error" logs_o3.txt; then
   		echo "Error in building $src" 
   	else 
   	   #grep "^$" logs_o3.txt >> runtimes_compiled.txt
   	   echo "Runtime in o3 without LFENCE defense" >> runtimes_compiled.txt
   	   #grep "Exiting @ tick" /script_test/logs_LFENCE.txt >>  /script_test/runtimes_compiled.txt
   	   awk '$3 == "tick" {print $4}' logs_o3.txt >> runtimes_compiled.txt
   	    temp2=`awk '/'$src'/{nr[NR+4]; next}; NR in nr' runtimes_compiled.txt`
   	  echo $temp2
	fi
	
	#echo "Speedup:" >> /script_test/LFENCE_programs/runtimes_compiled.txt
	#echo "scale=4; $temp2 / $temp1" | bc >> /script_test/LFENCE_programs/runtimes_compiled.txt
	
	
	
	
	
	
	##### Building on GEM5 o3 with LFENCE #####
	
	# cd /gem5
	../gem5/build/RISCV/gem5.opt ../gem5/configs/learning_gem5/part1/two_level.py ../benchmark_codes/LFENCE_programs/Binaries/$src > logs_LFENCE.txt
	#build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py /script_test/LFENCE_programs/Binaries/$src >> /script_test/LFENCE_programs/logs_full_LFENCE.txt
	
	
	if grep "error" logs_LFENCE.txt; then
   		echo "Error in building $src" 
   	else 
   	  # grep "^$" logs_LFENCE.txt >>  runtimes_compiled.txt
   	   echo "Runtime in o3 with LFENCE defense" >> runtimes_compiled.txt
   	   #grep "Exiting @ tick" /script_test/logs_LFENCE.txt >>  /script_test/runtimes_compiled.txt
   	   awk '$3 == "tick" {print $4}' logs_LFENCE.txt >> runtimes_compiled.txt
   	    temp2=`awk '/'$src'/{nr[NR+4]; next}; NR in nr' runtimes_compiled.txt`
   	  echo $temp2
	fi
	
	#echo "Speedup:" >> /script_test/LFENCE_programs/runtimes_compiled.txt
	#echo "scale=4; $temp2 / $temp1" | bc >> /script_test/LFENCE_programs/runtimes_compiled.txt
	
	
	####### Building on GEM5 o3 with CacheFlush defense ####
	
	# cd /gem5_cache_flush_defense
	../gem5_cache_flush_defense/build/RISCV/gem5.opt ../gem5_cache_flush_defense/configs/learning_gem5/part1/two_level.py $file > logs_cacheflush.txt
	../gem5_cache_flush_defense/build/RISCV/gem5.opt ../gem5_cache_flush_defense/configs/learning_gem5/part1/two_level.py $file >> logs_cacheflush_full.txt
	#build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py $file >> /script_test/logs_full.txt
	
	
	
	if grep "error" logs_cacheflush.txt; then
   		echo "Error in building $src" 
   	else 
   	 #  grep "^$" logs_cacheflush.txt >>  runtimes_compiled.txt
   	   echo "Runtime with Cache Flush defense" >> runtimes_compiled.txt
   	   #grep "Exiting @ tick" /script_test/logs.txt >>  /script_test/runtimes.txt
   	   awk '$3 == "tick" {print $4}' logs_cacheflush.txt >> runtimes_compiled.txt
   	   temp1=`awk '/'$src'/{nr[NR+2]; next}; NR in nr' runtimes_compiled.txt`
   	  echo $temp1
	  echo "" >> runtimes_compiled.txt
   	  
	fi
	

done

echo "Done Building hopefully"


