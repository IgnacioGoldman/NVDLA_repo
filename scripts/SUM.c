/*The following C is to test if the addition after the approx multiplication is doing correct*/
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int main() {
	long signed int result = 0;
	signed int result_aprox_mul_00 = 0x090dea6a;
	signed int result_aprox_mul_01 = 0xe00c3ee0;
	signed int result_aprox_mul_02 = 0x3663d1e2;
	signed int result_aprox_mul_03 = 0x13200d2f;
	signed int result_aprox_mul_04 = 0x0c8d77ea;
	signed int result_aprox_mul_05 = 0xc453583f;
	signed int result_aprox_mul_06 = 0xc5021a11;
	signed int result_aprox_mul_07 = 0x00bbbbb0;
	signed int result_aprox_mul_08 = 0xd7343738;
	signed int result_aprox_mul_09 = 0x366e9486;
	signed int result_aprox_mul_10 = 0xd97b10b8;
	signed int result_aprox_mul_11 = 0xc0a8ab50;
	signed int result_aprox_mul_12 = 0x0237a5e2;
	signed int result_aprox_mul_13 = 0x0013c65c;
	signed int result_aprox_mul_14 = 0xf42cf669;
	signed int result_aprox_mul_15 = 0x0124ee2e;
	signed int result_aprox_mul_16 = 0x134d7d01;
	signed int result_aprox_mul_17 = 0xe77e3004;
	signed int result_aprox_mul_18 = 0x2090d6bc;
	signed int result_aprox_mul_19 = 0x079ddef2;
	signed int result_aprox_mul_20 = 0x3b39426f;
	signed int result_aprox_mul_21 = 0x046460ad;
	signed int result_aprox_mul_22 = 0x0b20966e;
	signed int result_aprox_mul_23 = 0xe4b2bb01;
	signed int result_aprox_mul_24 = 0xf71139e5;
	signed int result_aprox_mul_25 = 0x0dd3c4d2;
	signed int result_aprox_mul_26 = 0xe083f920;
	signed int result_aprox_mul_27 = 0x00c1b3fc;
	signed int result_aprox_mul_28 = 0xcf7b1160;
	signed int result_aprox_mul_29 = 0xfc29cfbc;
	signed int result_aprox_mul_30 = 0xef4874ea;
	signed int result_aprox_mul_31 = 0xcca65a80;

	result = result_aprox_mul_00 +
		 result_aprox_mul_01 +
		 result_aprox_mul_02 +
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
		 result_aprox_mul_20 +	
		 result_aprox_mul_21 +
		 result_aprox_mul_22 +
		 result_aprox_mul_23 +
		 result_aprox_mul_24 +
		 result_aprox_mul_25 +
		 result_aprox_mul_26 +
		 result_aprox_mul_27 +
		 result_aprox_mul_28 +
		 result_aprox_mul_29 +
		 result_aprox_mul_30 +	
	         result_aprox_mul_31;	

	printf("%08x (%d) \n",result,result);
	
}

