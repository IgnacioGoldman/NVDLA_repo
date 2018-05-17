#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int compare_lines(char *, char *);
long int hit = 0;
long int error = 0;
long int counter = 1;

int main() {	
	
	FILE * fp_wt;
	char * line_wt = NULL;
	size_t len_wt = 0;
	ssize_t read_wt;
	fp_wt = fopen("/home/goldman/testing_environment/results_testbench/results_MAC.txt", "r");

	FILE * fp_dat;
	char * line_dat = NULL;
	size_t len_dat = 0;
	ssize_t read_dat;
	fp_dat = fopen("/home/goldman/testing_environment/results_testbench/MAC_results_EXPECTED.txt", "r");

	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/MAC_compare_results.txt", "w");

	if (fp_wt == NULL){
		printf("Error opening file wt.txt");		
		exit(EXIT_FAILURE);
	}
	if (fp_dat == NULL){
		printf("Error opening file dat.txt");		
		exit(EXIT_FAILURE);
	}
	if (f == NULL){
    		printf("Error opening file!\n");
    		exit(1);
	}

	while ( (read_wt = getline(&line_wt, &len_wt, fp_wt)) != -1 && (read_dat = getline(&line_dat, &len_dat, fp_dat)) != -1) {
		/*Genero el MAC y devuelvo el resultado*/
		/*Convierto a negativo en caso de que lo sea*/
		
		int c = compare_lines(line_wt,line_dat);
		int k = 0; 
		while(c == 0 && k<20){
			read_dat = getline(&line_dat, &len_dat, fp_dat)	;		
			c = compare_lines(line_wt,line_dat);
			k++;		
		}		
		
		counter++;
	}
	printf("Hits: %d -- Errors: %d -- Total: %d",hit,error,counter);
	fclose(fp_wt);
	fclose(fp_dat);
	fclose(f);
	if (line_wt)
		free(line_wt);
	if (line_dat)
		free(line_dat); 
	return 0;
}


int compare_lines(char * line_wt, char * line_dat){
	long int ns_a = 0;
	ns_a = strtol(line_wt, NULL, 16);
	if (ns_a > 32767)
    	ns_a -= 0x1000000L;

	long int ns_b = 0;
	ns_b = strtol(line_dat, NULL, 16);
	if (ns_b > 32767)
  	ns_b -= 0x1000000L;

	if(ns_a == ns_b){
		printf("Hit at line: %i\n",counter);		
		hit++;
		return 1;		
	}else{			
		//error++;
		printf("Error at line: %i\n",counter);
		return 0;	
	}
}
