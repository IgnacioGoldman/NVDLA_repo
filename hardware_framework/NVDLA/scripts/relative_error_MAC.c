#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int main() {	
	
	FILE * fp_dat;
	char * line_dat = NULL;
	size_t len_dat = 0;
	ssize_t read_dat;
	fp_dat = fopen("/home/goldman/testing_environment/results_testbench/compare_results_MAC.txt", "r");

	

	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/relative_error_MAC.txt", "w");

	if (fp_dat == NULL){
		printf("Error opening file dat.txuxt");		
		exit(EXIT_FAILURE);
	}
	if (f == NULL){
    		printf("Error opening file!\n");
    		exit(1);
	}
	int counter = 0;
	while ((read_dat = getline(&line_dat, &len_dat, fp_dat)) != -1 && counter<10000) {
		FILE * fp_wt;
		char * line_wt = NULL;
		size_t len_wt = 0;
		ssize_t read_wt;
		fp_wt = fopen("/home/goldman/testing_environment/results_testbench/results_MAC.txt", "r");
		
		/*Take the exact result (ns_a)*/
		char sub_a[12][1028];		
		char * pch;
		pch = strtok (line_dat," ");
		int i=0;		
		while (pch != NULL){
		  strcpy(sub_a[i],pch);
		  pch = strtok (NULL, " ");
		  i++;
		}
		long int ns_a;
		sscanf(sub_a[3], "%llx", &ns_a);
		if(ns_a > 0x7fffffffffffffff){
			ns_a = ~ns_a+1;
		}
		//printf("%llx\n",ns_a);

		/*Take the line where is the approximate result to compare with the exact*/
		int line = atoi(sub_a[8]);
		int j = 0;
		while(j<line){
			read_wt = getline(&line_wt, &len_wt, fp_wt);
			j++;
		}
		//printf("Line: %i -- %s",line,line_wt);
		/*Take the approx result (ns_token)*/
		char sub_b[12][1028];		
		char * pch2;
		pch2 = strtok (line_wt," ");
		int k=0;		
		while (pch2 != NULL){
		  strcpy(sub_b[k],pch2);
		  pch2 = strtok (NULL, " ");
		  k++;
		}
		//printf("%s",sub_b[8]);
		

		char *token = sub_b[8]; 	
		long int ns_token;		
		long int mask = 0xffffffc000000000;		
		ns_token = strtol(sub_b[8], NULL, 16);
				
		int n = 37;
		int bitStatus = (ns_token >> n) & 1;
		if(bitStatus)
			ns_token = ns_token | mask ; 
		
		//printf("%llx -- %llx\n",ns_a,ns_token);

		long int absolute = ns_a - ns_token;
		//printf("%llx\n",absolute);
		int flag = absolute;
		//printf("%i\n",absolute);
		if(flag != 0){	
			long double relative_error = 0;
			relative_error = ((float)absolute/(float)ns_a)*100;
			if(relative_error > 0 || relative_error < 0){
				fprintf(f,"%s * %s =\n exact result: %llx (%ld) nvdla result: %llx (%ld) -- error is %Lf -- absolute is %lld\n",sub_b[2],sub_b[5],ns_a,ns_a,ns_token,ns_token,relative_error,absolute);
			}
				
		}else{
			fprintf(f,"%s * %s =\nexact result: %llx (%ld) nvdla result: %llx (%ld) -- error is 0 -- absolute is %lld\n",sub_b[2],sub_b[5],ns_a,ns_a,ns_token,ns_token,absolute);	
		}	
		counter++;
		fclose(fp_wt); 
	}
		
	fclose(fp_dat);
	fclose(f);
	return 0;
}

