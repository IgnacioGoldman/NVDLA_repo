#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

long int mac(const char *a, const char *b, int INT8, FILE *f_mul);

int main() {
	/*Set to 1 if INT8 MAC*/
	int INT8 = 0;
	printf("Press 0 if you want that MAC.c generate the MAC operation at INT16\nPress 1 if you want that MAC.c generate the MAC operation at INT8: ");
	scanf ("%d",&INT8);

	long int result_MAC = 0;

	FILE * fp_wt;
	char * line_wt = NULL;
	size_t len_wt = 0;
	ssize_t read_wt;
	fp_wt = fopen("/home/goldman/testing_environment/results_testbench/wt.txt", "r");

	FILE * fp_dat;
	char * line_dat = NULL;
	size_t len_dat = 0;
	ssize_t read_dat;
	fp_dat = fopen("/home/goldman/testing_environment/results_testbench/dat.txt", "r");

	FILE *f = fopen("/home/goldman/testing_environment/results_testbench/MAC_results_EXPECTED.txt", "w");
	FILE *f_MUL = fopen("/home/goldman/testing_environment/results_testbench/MUL_results_EXPECTED.txt", "w");

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
		const char *b = line_wt;
		const char *a = line_dat;
		/*Genero el MAC y devuelvo el resultado*/		
		result_MAC = mac(a, b, INT8, f_MUL);
		fprintf(f, "%08x\n", result_MAC);
		
	}
	fclose(fp_wt);
	fclose(fp_dat);
	fclose(f);
	fclose(f_MUL);
	if (line_wt)
		free(line_wt);
	if (line_dat)
		free(line_dat); 
	return 0;
}

long int mac(const char *a, const char *b, int INT8, FILE *f_MUL){
	long int result = 0;
	int i = 0;
	int i_sup = 0;
	int var_INT = 0;
	int CUT = 0;
	int out_ns_a= 0;
	int out_ns_b= 0;
	
	if(INT8 == 1){
		//var_INT = 2;		
		var_INT = 4;
		CUT = 2;
	}else{
		var_INT = 4;
		CUT = 0;	
	}
   	/* for loop execution */
  	for( i = 0; i < 128; i = i + var_INT ){
      		//printf("value of i: %d\n", i);
		i_sup = 0;				
		i_sup = i+var_INT;
		
		/*Agarro 2 o 4 hex de a*/		
	  	char *start_a = &a[i];
	  	char *end_a = &a[i_sup-CUT];
	  	char *substr_a = (char *)calloc(1, end_a - start_a + 1);
	  	memcpy(substr_a, start_a, end_a - start_a);
		
		/*Convierto a negativo en caso de que lo sea*/
		if(INT8 == 1){
			int8_t ns_a = 0;
			ns_a = strtol(substr_a, NULL, 16);
			out_ns_a = ns_a;		
		}else{
			short int ns_a = 0;		
			ns_a = strtol(substr_a, NULL, 16);
			out_ns_a = ns_a;
		}
				
		/*Agarro 2 o 4 hex de b*/
	  	char *start_b = &b[i];
	  	char *end_b = &b[i_sup];
	  	char *substr_b = (char *)calloc(1, end_b - start_b + 1);
	  	memcpy(substr_b, start_b, end_b - start_b);
		
		/*Convierto a negativo en caso de que lo sea*/
		if(INT8 == 1){
			int8_t ns_b = 0;
			ns_b = strtol(substr_b, NULL, 16);
			out_ns_b = ns_b;		
		}else{
			short int ns_b = 0;		
			ns_b = strtol(substr_b, NULL, 16);
			out_ns_b = ns_b;
		}
		
		//printf("%i hex son: %s*%s\n",i,substr_a,substr_b);
		//printf("%i dec son: %d*%d\n",i,out_ns_a,out_ns_b);
		/*Convierto a numeros*/
		long int c = 0;		
		c = out_ns_a*out_ns_b;
		fprintf(f_MUL, "%04x \n", c);
		result = result + c;
		//printf("c is: %ld, and the final result is: %ld\n",c,result);		

   	}
	printf("Resultado final en hex %d\n",result);
	
	return result;
}
