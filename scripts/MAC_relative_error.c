#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long int mac(const char *a, const char *b);

int main() {	
	long int result_MAC = 0;
	int testHasX = 0;

	FILE * fp_appr;
	char * line_appr = NULL;
	size_t len_appr = 0;
	ssize_t read_appr;
	fp_appr = fopen("/home/goldman/testing_environment/results_testbench/results_MAC.txt", "r");
	
	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/MAC_relative_error.txt", "w");

	if (fp_appr == NULL){
		printf("Error opening file appr");		
		exit(EXIT_FAILURE);
	}
	if (f == NULL){
    		printf("Error opening file!\n");
    		exit(1);
	}
	int counter = 0;
	int total = 0;
	while ((read_appr = getline(&line_appr, &len_appr, fp_appr)) > 1) {
		char sub_a[12][1028];		
		char * pch;
		pch = strtok (line_appr," ");
		int i=0;		
		while (pch != NULL)
		{
		  strcpy(sub_a[i],pch);
		  pch = strtok (NULL, " ");
		  i++;
		}
		
		/*Saco la x del 1er lugar*/         
		char *ps_0 = sub_a[2];
		memmove (sub_a[2], sub_a[2]+1, strlen (sub_a[2]+1) + 1);
	
		/*Saco la x del 1er lugar*/         
		char *ps_1 = sub_a[5];
		memmove (sub_a[5], sub_a[5]+1, strlen (sub_a[5]+1) + 1);

		char *substr_a = sub_a[2]; 	
		char *substr_b = sub_a[5]; 	
		char *token = sub_a[8]; 
		
		result_MAC = mac(substr_a, substr_b);
		
		if(testHasX){                
			/*Saco la x del 1er lugar*/         
			char *ps = sub_a[8];
			memmove (sub_a[8], sub_a[8]+1, strlen (sub_a[8]+1) + 1);
		}

		long int ns_token;		
		long int mask = 0xffffffc000000000;		
		ns_token = strtol(sub_a[8], NULL, 16);
				
		int n = 37;
		int bitStatus = (ns_token >> n) & 1;
		if(bitStatus)
			ns_token = ns_token | mask ; 
		
		long int absolute = result_MAC - ns_token;
		int flag = absolute;

		if(ns_token != 0){
			if(flag != 0){	
				/*Calculus of relative error*/
				long double relative_error = 0;
				relative_error = ((float)absolute/(float)result_MAC)*100;
				fprintf(f,"exact result: %llx (%ld) nvdla result: %llx (%ld) -- error is %Lf\n",result_MAC,result_MAC,ns_token,ns_token,relative_error);
				counter++;
					
			}else{
				fprintf(f,"exact result: %llx (%ld) nvdla result: %llx (%ld) -- error is 0\n",result_MAC,result_MAC,ns_token,ns_token);	
			}	
		total++; 	
		}
	}
	printf("errors: %d -- total: %d",counter,total);
	fclose(fp_appr);
	fclose(f);
	return 0;
}


long int mac(const char *a, const char *b){
	long int result = 0;
	int i = 0;
	int i_sup = 0;
	int var_INT = 4;
	
	for( i = 0; i < 128; i = i + 4 ){
      		i_sup = 0;				
		i_sup = i+4;
		
		/*Agarro 2 o 4 hex de a*/		
	  	char *start_a = &a[i];
	  	char *end_a = &a[i_sup];
	  	char *substr_a = (char *)calloc(1, end_a - start_a + 1);
	  	memcpy(substr_a, start_a, end_a - start_a);
		
		short int ns_a = 0;		
		ns_a = strtol(substr_a, NULL, 16);
				
		/*Agarro 2 o 4 hex de b*/
	  	char *start_b = &b[i];
	  	char *end_b = &b[i_sup];
	  	char *substr_b = (char *)calloc(1, end_b - start_b + 1);
	  	memcpy(substr_b, start_b, end_b - start_b);
		
		short int ns_b = 0;		
		ns_b = strtol(substr_b, NULL, 16);
		
		/*Convierto a numeros*/
		int c = 0;		
		c = ns_a*ns_b;
		result = result + c;
		//printf("%i -- a:%s (%d in dec) * b: %s (%d in dec) = %04x (%d in dec) -- accumulation: %04x (%ld in dec)\n",i, substr_a, ns_a, substr_b, ns_b, c, c, result,result);
		
   	}
	return result;
}



	

