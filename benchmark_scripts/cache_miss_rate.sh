#!/usr/bin/bash

# Creating binaries for all the files

echo "Start of script"
rm /script_test/cache_miss/cache_missrate.txt
rm /script_test/cache_miss/logs_miss.txt
#rm /script_test/LFENCE_programs/logs_full_LFENCE.txt


#### Create Binaries for code

cd /script_test
export PATH=/opt/riscv/bin:$PATH 

for file in /script_test/*.c; do
	filename=${file::-2}
	src=${filename:13}
	#echo "$filename"
	riscv64-unknown-elf-gcc -g $file -o /script_test/Binaries/$src
	
	#if riscv64-unknown-elf-gcc -g $file -o ${file::-2} > grep -q 'error'; then
   		#echo "Not compiled $file"
   	#else 
   		#echo "Compiled $file"
	#fi

done




###### Building on GEM5 for the binaries


for file in /script_test/Binaries/*; do
	#filename=${file::-2}
	src=${file:22}
	#echo "$file"
	
	
	
	
	###### Building on GEM5 o3 ##############
	
	cd /gem5
	build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py $file > /script_test/cache_miss/logs_miss.txt
	#build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py $file >> /script_test/LFENCE_programs/logs_full_LFENCE.txt
	
	
	if grep "error" /script_test/cache_miss/logs_miss.txt; then
   		echo "Error in building $src" 
   	else 
   	   grep "^$" /script_test/logs_LFENCE.txt >>  /script_test/cache_miss/cache_missrate.txt
   	   echo "$src" >> /script_test/cache_miss/cache_missrate.txt
   	   #echo "Runtime in o3 without LFENCE defense" >> /script_test/cache_miss/cache_missrate.txt
   	   #grep "Exiting @ tick" /script_test/logs_LFENCE.txt >>  /script_test/runtimes_LFENCE.txt
   	  # grep "system.cpu.dcache.overallMissRate::total" /gem5/m5out/stats.txt >>  /script_test/cache_miss/cache_missrate.txt
   	   awk '$1 == "system.cpu.dcache.overallMissRate::total" {print $2}' /gem5/m5out/stats.txt >> /script_test/cache_miss/cache_missrate.txt
   	    temp2=`awk '/'$src'/{nr[NR+4]; next}; NR in nr' /script_test/cache_miss/cache_missrate.txt`
   	  echo $temp2
	fi
	
	#echo "Speedup:" >> /script_test/cache_miss/cache_missrate.txt
	#echo "scale=4; $temp2 / $temp1" | bc >> /script_test/cache_miss/cache_missrate.txt
	
	
	
	
	####### Building on GEM5 o3 with CacheFlush defense ####
	
	cd /RISCV-Spectre-Attack-and-Defense/gem5
	build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py $file > /script_test/cache_miss/logs_miss.txt
	#build/RISCV/gem5.opt configs/learning_gem5/part1/two_level.py $file >> /script_test/logs_full.txt
	
	
	
	if grep "error" /script_test/logs.txt; then
   		echo "Error in building $src" 
   	else 
   	   #grep "^$" /script_test/logs.txt >>  /script_test/cache_miss/cache_missrate.txt
   	   #echo "Runtime with Cache Flush defense" >> /script_test/runtimes_LFENCE.txt
   	   #grep "Exiting @ tick" /script_test/logs.txt >>  /script_test/runtimes.txt
   	  # grep "system.cpu.dcache.overallMissRate::total" /RISCV-Spectre-Attack-and-Defense/gem5/m5out/stats.txt >>  /script_test/cache_miss/cache_missrate.txt
   	   awk '$1 == "system.cpu.dcache.overallMissRate::total" {print $2}' /RISCV-Spectre-Attack-and-Defense/gem5/m5out/stats.txt >> /script_test/cache_miss/cache_missrate.txt
   	   temp1=`awk '/'$src'/{nr[NR+2]; next}; NR in nr' /script_test/runtimes.txt`
   	  echo $temp1
   	  
	fi
	

done

echo "Done Building hopefully"


