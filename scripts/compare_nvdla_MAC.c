#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int lines_equal(char *, char *, FILE *f);
int counter_a = 0;	
int counter_b = 0;	

int main() {	
	
	int number_of_checks = 10000;
	int errors = 0;

	FILE * fp_dat;
	char * line_dat = NULL;
	size_t len_dat = 0;
	ssize_t read_dat;
	fp_dat = fopen("/home/goldman/testing_environment/results_testbench/exact_results_MAC.txt", "r");

	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/compare_results_MAC.txt", "w");

	if (fp_dat == NULL){
		printf("Error opening file dat.txuxt");		
		exit(EXIT_FAILURE);
	}
	if (f == NULL){
    		printf("Error opening file!\n");
    		exit(1);
	}
	
	while ((read_dat = getline(&line_dat, &len_dat, fp_dat)) != -1 && counter_a<number_of_checks) {
		FILE * fp_wt;
		char * line_wt = NULL;
		size_t len_wt = 0;
		ssize_t read_wt;
		fp_wt = fopen("/home/goldman/testing_environment/results_testbench/results_MAC.txt", "r");		
		counter_b = 0;

		counter_a++;
		counter_b++;
		read_wt = getline(&line_wt, &len_wt, fp_wt);
		int are_equal = lines_equal(line_wt,line_dat,f);
		int k = 0; 
		while(are_equal == 0 && (read_wt = getline(&line_wt, &len_wt, fp_wt)) != -1){
			counter_b++;
			are_equal = lines_equal(line_wt,line_dat,f);
			k++;		
		}
		if(are_equal == 0){
			errors++;
			printf("Line: %d?\n",counter_a);
		}
		fclose(fp_wt);
		
	}
	printf("Errors: %d\n",errors);
	fclose(fp_dat);
	fclose(f);
	if (line_dat)
		free(line_dat); 
	return 0;
}


int lines_equal(char * line_wt, char * line_dat, FILE *f){
	/*Get exact result (ns_a)*/
	char sub_b[12][1028];		
	char * pch2;
	pch2 = strtok (line_dat," ");
	int j=0;		
	while (pch2 != NULL)
	{
	  strcpy(sub_b[j],pch2);
	  pch2 = strtok (NULL, " ");
	  j++;
	}
		
	char *token2 = sub_b[4]; 
	long int ns_a;
	sscanf(token2, "%llx", &ns_a);
	if(ns_a > 0x7fffffffffffffff){
		ns_a = ~ns_a+1;
	}

	/*Get simulation result (ns_token)*/
	char sub_a[12][1028];		
	char * pch;
	pch = strtok (line_wt," ");
	int i=0;		
	while (pch != NULL)
	{
	  strcpy(sub_a[i],pch);
	  pch = strtok (NULL, " ");
	  i++;
	}
		
	char *token = sub_a[8]; 
	/*Saco la x del 1er lugar*/         
	//char *ps = sub_a[8];
	//memmove (sub_a[8], sub_a[8]+1, strlen (sub_a[8]+1) + 1);
		
	long int ns_token;		
	long int mask = 0xffffffc000000000;		
	ns_token = strtol(sub_a[8], NULL, 16);
				
	int n = 37;
	int bitStatus = (ns_token >> n) & 1;
	if(bitStatus)
		ns_token = ns_token | mask ; 
	
	//fprintf(f,"At line %d: %llx (%lld) -- At line %d: %llx (%lld) -- %s",counter_a,ns_a,ns_a,counter_b,ns_token,ns_token,sub_a[8]);	
	long int absolute = ns_a - ns_token;
	int flag = absolute;
	if(flag == 0){
		fprintf(f,"At line %d: %llx (%lld) -- At line %d : %llx (%lld)\n",counter_a,ns_a,ns_a,counter_b,ns_token,ns_token);
		return 1;
	}else{
		return 0;
	}
	
}
