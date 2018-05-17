#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {	
	int counter = 0;
	FILE * fp_appr;
	char * line_appr = NULL;
	size_t len_appr = 0;
	ssize_t read_appr;
	fp_appr = fopen("/home/goldman/testing_environment/results_testbench/results_MUL.txt", "r");
	
	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/relative_error.txt", "w");

	if (fp_appr == NULL){
		printf("Error opening file appr");		
		exit(EXIT_FAILURE);
	}
	if (f == NULL){
    		printf("Error opening file!\n");
    		exit(1);
	}

	while ((read_appr = getline(&line_appr, &len_appr, fp_appr)) != -1) {
		
		char sub_a[32], sub_b[32], sub_c[32], sub_d[32], sub_e[32], sub_f[32], sub_g[32], sub_h[32], sub_i[32], sub_j[32], sub_k[32], sub_l[32];

    		strcpy(sub_a, strtok(line_appr , " "));
    		strcpy(sub_b, strtok(NULL, " "));
    		strcpy(sub_c, strtok(NULL, " "));
    		strcpy(sub_d, strtok(NULL, " "));
    		strcpy(sub_e, strtok(NULL, " "));
		strcpy(sub_f, strtok(NULL, " "));
    		strcpy(sub_g, strtok(NULL, " "));
    		strcpy(sub_h, strtok(NULL, " "));
    		strcpy(sub_i, strtok(NULL, " "));
		strcpy(sub_j, strtok(NULL, " "));
    		strcpy(sub_k, strtok(NULL, " "));
    		strcpy(sub_l, strtok(NULL, " "));    		

		char *substr_a = sub_c; 	
		char *substr_b = sub_f ; 	
		char *token = sub_i; 
		char *sign = sub_l;	
		
		/*Conversion to ints*/
		short int ns_a = 0;
		ns_a = strtol(substr_a, NULL, 16);
		short int ns_b = 0;
		ns_b = strtol(substr_b, NULL, 16);

		/*Calculation*/
		int exact_result = ns_a*ns_b;
		
		long int ns_appr = 0;
		ns_appr = strtol(token, NULL, 16);
	
		/*Calculus of relative error*/
		long double relative_error = 0;
		int absolute = 0;
		absolute = exact_result - ns_appr;
		if(absolute != 0){
			relative_error = ((float)absolute/(float)exact_result)*100;
			if(relative_error > 23){
				fprintf(f, "exact result is %hx*%hx = %04x (%d in decimal) -- aprox result is = %04x (%d in decimal) (sign is %s)-- error is %Lf\n",ns_a, ns_b, exact_result, exact_result, ns_appr, ns_appr, sign, relative_error);
			}		
		}else{
			//fprintf(f, "exact result is %hx*%hx = %04x -- aprox result is = %04x -- error is %i -- at line %i\n",ns_a, ns_b, exact_result, ns_appr, absolute, counter);	
		}
				
		counter++;	 		
	}

	fclose(fp_appr);
	fclose(f);
	if (line_appr)
		free(line_appr);
	return 0;
}



	

