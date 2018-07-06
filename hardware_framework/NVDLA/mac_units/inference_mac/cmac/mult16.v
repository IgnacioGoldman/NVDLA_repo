module mult16 (out, a, b);
	output reg [31:0] out;
        input [15:0] a;
        input [15:0] b;

 	wire [15:0] a_magnitude; 
 	wire [15:0] b_magnitude; 
 	wire [31:0] mult_out; 
 	wire [31:0] mult_out_2c; 
 	wire [31:0] wirex_out; 
	wire sign_a;
	wire sign_b;
	wire sign_m;
  	wire [15:0] wire_pp1; 
  	wire [15:0] wire_pp2; 
  	wire [15:0] wire_pp3; 
  	wire [15:0] wire_pp4; 

	reg [31:0] check_out;

        assign sign_a = a[15]; 
        assign sign_b = b[15];
	assign a_magnitude = (sign_a)? ((~a)+1) : a;
	assign b_magnitude = (sign_b)? ((~b)+1) : b;
	assign sign_m = a[15]^b[15];
	assign mult_out = { 8'b0, wire_pp2, 8'b0} + {8'b0, wire_pp3, 8'b0} + {wire_pp4, wire_pp1};
	assign mult_out_2c = (sign_m)? ((~mult_out)+1) : mult_out;
        assign wirex_out = { sign_m , mult_out_2c[30:0]};
	//assign wirex_out = mult_out_2c;
	//assign out = wirex_out;
	
		
	
always@(a,b)begin
	check_out = wirex_out & 31'b1;
	
	if(check_out>=1'b0)begin
		out = wirex_out;
	end
	else begin
		out = 31'b0;
	end
end

always@(out)begin
	$display("data: %0h * weight: %0h = mult_res: %0h -- sign: %b -- %m",a, b,out, sign_m);
end



mult8x8 u_mult8_pp1(
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
.y1          ( wire_pp1[0]  ), 
.y2          ( wire_pp1[1]  ), 
.y3          ( wire_pp1[2]  ), 
.y4          ( wire_pp1[3]  ), 
.y5          ( wire_pp1[4]  ), 
.y6          ( wire_pp1[5]  ), 
.y7          ( wire_pp1[6]  ), 
.y8          ( wire_pp1[7]  ), 
.y9          ( wire_pp1[8]  ), 
.y10         ( wire_pp1[9]  ), 
.y11         ( wire_pp1[10] ), 
.y12         ( wire_pp1[11] ), 
.y13         ( wire_pp1[12] ), 
.y14         ( wire_pp1[13] ), 
.y15         ( wire_pp1[14] ), 
.y16         ( wire_pp1[15] ) 
);

mult8x8 u_mult8_pp2(
.x0          ( a_magnitude[7] ),
.x1          ( a_magnitude[6] ),
.x2          ( a_magnitude[5] ),
.x3          ( a_magnitude[4] ),
.x4          ( a_magnitude[3] ),
.x5          ( a_magnitude[2] ),
.x6          ( a_magnitude[1] ),
.x7          ( a_magnitude[0] ),
.x8          ( b_magnitude[15] ),
.x9          ( b_magnitude[14] ),
.x10         ( b_magnitude[13] ),
.x11         ( b_magnitude[12] ),
.x12         ( b_magnitude[11] ),
.x13         ( b_magnitude[10] ),
.x14         ( b_magnitude[9] ),
.x15         ( b_magnitude[8] ),
.y1          ( wire_pp2[0]  ), 
.y2          ( wire_pp2[1]  ), 
.y3          ( wire_pp2[2]  ), 
.y4          ( wire_pp2[3]  ), 
.y5          ( wire_pp2[4]  ), 
.y6          ( wire_pp2[5]  ), 
.y7          ( wire_pp2[6]  ), 
.y8          ( wire_pp2[7]  ), 
.y9          ( wire_pp2[8]  ), 
.y10         ( wire_pp2[9]  ), 
.y11         ( wire_pp2[10] ), 
.y12         ( wire_pp2[11] ), 
.y13         ( wire_pp2[12] ), 
.y14         ( wire_pp2[13] ), 
.y15         ( wire_pp2[14] ), 
.y16         ( wire_pp2[15] ) 
);

mult8x8 u_mult8_pp3(
.x0          ( a_magnitude[15] ),
.x1          ( a_magnitude[14] ),
.x2          ( a_magnitude[13] ),
.x3          ( a_magnitude[12] ),
.x4          ( a_magnitude[11] ),
.x5          ( a_magnitude[10] ),
.x6          ( a_magnitude[9] ),
.x7          ( a_magnitude[8] ),
.x8          ( b_magnitude[7] ),
.x9          ( b_magnitude[6] ),
.x10         ( b_magnitude[5] ),
.x11         ( b_magnitude[4] ),
.x12         ( b_magnitude[3] ),
.x13         ( b_magnitude[2] ),
.x14         ( b_magnitude[1] ),
.x15         ( b_magnitude[0] ),
.y1          ( wire_pp3[0]  ), 
.y2          ( wire_pp3[1]  ), 
.y3          ( wire_pp3[2]  ), 
.y4          ( wire_pp3[3]  ), 
.y5          ( wire_pp3[4]  ), 
.y6          ( wire_pp3[5]  ), 
.y7          ( wire_pp3[6]  ), 
.y8          ( wire_pp3[7]  ), 
.y9          ( wire_pp3[8]  ), 
.y10         ( wire_pp3[9]  ), 
.y11         ( wire_pp3[10] ), 
.y12         ( wire_pp3[11] ), 
.y13         ( wire_pp3[12] ), 
.y14         ( wire_pp3[13] ), 
.y15         ( wire_pp3[14] ), 
.y16         ( wire_pp3[15] ) 
);

mult8x8 u_mult8_pp4(
.x0          ( a_magnitude[15] ),
.x1          ( a_magnitude[14] ),
.x2          ( a_magnitude[13] ),
.x3          ( a_magnitude[12] ),
.x4          ( a_magnitude[11] ),
.x5          ( a_magnitude[10] ),
.x6          ( a_magnitude[9] ),
.x7          ( a_magnitude[8] ),
.x8          ( b_magnitude[15] ),
.x9          ( b_magnitude[14] ),
.x10         ( b_magnitude[13] ),
.x11         ( b_magnitude[12] ),
.x12         ( b_magnitude[11] ),
.x13         ( b_magnitude[10] ),
.x14         ( b_magnitude[9] ),
.x15         ( b_magnitude[8] ),
.y1          ( wire_pp4[0]  ), 
.y2          ( wire_pp4[1]  ), 
.y3          ( wire_pp4[2]  ), 
.y4          ( wire_pp4[3]  ), 
.y5          ( wire_pp4[4]  ), 
.y6          ( wire_pp4[5]  ), 
.y7          ( wire_pp4[6]  ), 
.y8          ( wire_pp4[7]  ), 
.y9          ( wire_pp4[8]  ), 
.y10         ( wire_pp4[9]  ), 
.y11         ( wire_pp4[10] ), 
.y12         ( wire_pp4[11] ), 
.y13         ( wire_pp4[12] ), 
.y14         ( wire_pp4[13] ), 
.y15         ( wire_pp4[14] ), 
.y16         ( wire_pp4[15] ) 
);
endmodule
