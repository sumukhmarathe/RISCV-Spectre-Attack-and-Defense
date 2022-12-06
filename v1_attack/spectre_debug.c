#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Changes Start
// #ifdef _MSC_VER
// #include <intrin.h> /* for rdtscp and clflush */
// #pragma optimize("gt",on)
// #else
// #include <x86intrin.h> /* for rdtscp and clflush */
// #endif

//Add RISC files
#include "cache.h"
#include "encoding.h"

#define CACHE_HIT_THRESHOLD 50
#define BOUND 100
// Changes End
/// Try something

void main(){

int i, junk, junk1;
uint8_t x, y;
register uint64_t time1, time2, time3, time4;
volatile uint8_t * addr;
uint8_t temp = 0;

printf("start test");
	y = 10;
	addr = &y;
	time1 = rdcycle();
	junk = *addr;
	time2 = rdcycle() - time1;
		
	asm volatile("fence.i");
	
	for(i= 0 ; i< BOUND + 2; i++)
		if (i<BOUND){
		temp  &= y;
		//x = 1;
		//asm volatile("");
		//printf("inside if condition of for loop: i = %d\n", i);
		}
	asm volatile("fence.i");
	
	time3 = rdcycle();
	junk1 = *addr;
	time4 = rdcycle() - time3;
	
	printf("Initial access %d \n", time2);
	printf("Second access %d \n", time4);
	
	/*asm volatile("fence.i");
	
	for(i= 0 ; i<bound + 2; i++){
	if (i<bound) {
	printf("mispeculation resolved\n");
	}
	}
	
	asm volatile("fence.i");
	
	time1 = rdcycle();
	junk1 = *addr;
	time2 = rdcycle() - time1;
	printf("Final access %d \n", time2);*/
	
printf("End test");
	}
	
	



