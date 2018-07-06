/*The following C is to test if the addition after the approx multiplication is doing correct*/
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int main() {
	long int result = 0;
	int result_aprox_mul_00 = 0xffc179da;
	int result_aprox_mul_01 = 0x0082cea8;
	int result_aprox_mul_02 = 0xfb6dd000;
	int result_aprox_mul_03 = 0x006ad280;
	int result_aprox_mul_04 = 0x0055ddc0;
	int result_aprox_mul_05 = 0xfebca7e0;
	
	int result_aprox_mul_06 = 0xffe0f800;
	int result_aprox_mul_07 = 0x0027a9dd;
	int result_aprox_mul_08 = 0x0055d198;
	int result_aprox_mul_09 = 0xff83b98c;
	int result_aprox_mul_10 = 0xfea881a0;
	int result_aprox_mul_11 = 0xfff52234;

	int result_aprox_mul_12 = 0xfb96e080;
	int result_aprox_mul_13 = 0xffc8c9a2;
	int result_aprox_mul_14 = 0x01feb8b0;
	int result_aprox_mul_15 = 0x0030cf2d;
	int result_aprox_mul_16 = 0xfa25e780;
	int result_aprox_mul_17 = 0xff0de200;
	int result_aprox_mul_18 = 0x01183720;
	int result_aprox_mul_19 = 0x0185ed00;
	int result_aprox_mul_20 = 0x3b39426f;

	
	

	result = result_aprox_mul_00 +
		 result_aprox_mul_01;
		 /*result_aprox_mul_02 +
		 result_aprox_mul_03 +
		 result_aprox_mul_04 +
		 result_aprox_mul_05 +
		 result_aprox_mul_06 +
		 result_aprox_mul_07 +
		 result_aprox_mul_08 +
		 result_aprox_mul_09 +
		 result_aprox_mul_10 +	
		 result_aprox_mul_11 +
		 result_aprox_mul_12 +
		 result_aprox_mul_13 +
		 result_aprox_mul_14 +
		 result_aprox_mul_15 +
		 result_aprox_mul_16 +
		 result_aprox_mul_17 +
		 result_aprox_mul_18 +
		 result_aprox_mul_19 +
		 result_aprox_mul_20;*/	

	printf("%08x\n",result);
	
}

