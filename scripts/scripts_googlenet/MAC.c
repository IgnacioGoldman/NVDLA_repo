#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long int mac(const char *a, const char *b, int data_lenght);

int main(int argc, char *argv[]) {	
	long int result_MAC = 0;
	
	if(argc<=1) {
        	printf("You did not feed me arguments");
        	exit(1);
        }  
     	int data_lenght = atoi(argv[1]);  //argv[0] is the program name  //atoi = ascii to int
                               
	FILE * fp_appr;
	char * line_appr = NULL;
	size_t len_appr = 0;
	ssize_t read_appr;
	fp_appr = fopen("/home/goldman/testing_environment/results_testbench/results_MAC.txt", "r");
	
	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/exact_results_MAC.txt", "w");

	if (fp_appr == NULL){
		printf("Error opening file appr");		
		exit(EXIT_FAILURE);
	}
	if (f == NULL){
    		printf("Error opening file!\n");
    		exit(1);
	}
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
		
		char *substr_a = sub_a[2]; 	
		char *substr_b = sub_a[5]; 	
		char *token = sub_a[8]; 
		
		result_MAC = mac(substr_a, substr_b, data_lenght);
		fprintf(f,"%s * %s = %llx\n",sub_a[2],sub_a[5],result_MAC);
		
	}
	fclose(fp_appr);
	fclose(f);
	return 0;
}


long int mac(const char *a, const char *b, int data_lenght){
	long int result = 0;
	int i = 0;
	int i_sup = 0;
	int var_INT = 4;
	
	for( i = 0; i < data_lenght; i = i + 4 ){
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



	
