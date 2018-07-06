/*Inference int8 reduced*/
module mul_unit (out, a, b);
	output [15:0] out;
        input [7:0] a;
        input [7:0] b;

 	wire [7:0] a_magnitude; 
 	wire [7:0] b_magnitude; 
 	wire [15:0] mult_out; 
 	wire [15:0] mult_out_2c; 
 	wire [15:0] wirex_out; 
	wire sign_m;

	
        assign a_magnitude = (a[7])? ((~a)) : a;
	assign b_magnitude = (b[7])? ((~b)) : b;
	assign sign_m = a[7]^b[7];
	assign mult_out_2c = (sign_m)? ((~mult_out)) : mult_out;
        assign out = mult_out_2c;

mult8x8_inference u_mult8(
.x0          ( a_magnitude[7] ),
.x1          ( a_magnitude[6] ),
.x2          ( a_magnitude[5] ),
.x3          ( a_magnitude[4] ),
.x4          ( a_magnitude[3] ),
.x5          ( a_magnitude[2] ),
.x6          ( a_magnitude[1] ),
.x7          ( a_magnitude[0] ),
.x8          ( b_magnitude[7] ),
.x9          ( b_magnitude[6] ),
.x10         ( b_magnitude[5] ),
.x11         ( b_magnitude[4] ),
.x12         ( b_magnitude[3] ),
.x13         ( b_magnitude[2] ),
.x14         ( b_magnitude[1] ),
.x15         ( b_magnitude[0] ),
.y1          ( mult_out[0]  ), 
.y2          ( mult_out[1]  ), 
.y3          ( mult_out[2]  ), 
.y4          ( mult_out[3]  ), 
.y5          ( mult_out[4]  ), 
.y6          ( mult_out[5]  ), 
.y7          ( mult_out[6]  ), 
.y8          ( mult_out[7]  ), 
.y9          ( mult_out[8]  ), 
.y10         ( mult_out[9]  ), 
.y11         ( mult_out[10] ), 
.y12         ( mult_out[11] ), 
.y13         ( mult_out[12] ), 
.y14         ( mult_out[13] ), 
.y15         ( mult_out[14] ), 
.y16         ( mult_out[15] ) 
);

endmodule





