module mult16 (out, a, b);
	output [31:0] out;
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

        assign sign_a = a[15]; 
        assign sign_b = b[15];
	assign a_magnitude = (sign_a)? ((~a)+1) : a;
	assign b_magnitude = (sign_b)? ((~b)+1) : b;
	assign sign_m = a[15]^b[15];
	assign mult_out = { 8'b0, wire_pp2, 8'b0} + {8'b0, wire_pp3, 8'b0} + {wire_pp4, wire_pp1};
	assign mult_out_2c = (sign_m)? ((~mult_out)+1) : mult_out;
	assign wirex_out = { sign_m , mult_out_2c[30:0]};
	//assign wirex_out = mult_out_2c;
	assign out = wirex_out;



mult8x8 u_mult8_pp1(
.a          ( a_magnitude[7:0] ),
.b          ( b_magnitude[7:0] ),
.out        ( wire_pp1 )
);

mult8x8 u_mult8_pp2(
.a          ( a_magnitude[15:8] ),
.b          ( b_magnitude[7:0] ),
.out        ( wire_pp2 )
);

mult8x8 u_mult8_pp3(
.a          ( a_magnitude[7:0] ),
.b          ( b_magnitude[15:8] ),
.out        ( wire_pp3 )
);

mult8x8 u_mult8_pp4(
.a          ( a_magnitude[15:8] ),
.b          ( b_magnitude[15:8] ),
.out        ( wire_pp4 )
);

always@(a,b,out,sign_m)begin

	//$display("data: %0h * weight: %0h = mult_res: %0h -- sign: %b",a, b,out, sign_m);
	 
end



endmodule
