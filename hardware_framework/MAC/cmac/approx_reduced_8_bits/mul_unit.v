/*Approx reduced int8*/
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
  	wire [7:0] wire_pp1; 
  	wire [7:0] wire_pp2; 
  	wire [7:0] wire_pp3; 
  	wire [7:0] wire_pp4; 

        assign a_magnitude = (a[7])? ((~a)) : a;
	assign b_magnitude = (b[7])? ((~b)) : b;
	assign sign_m = a[7]^b[7];
	assign mult_out = { 4'b0, wire_pp2, 4'b0} + {4'b0, wire_pp3, 4'b0} + {wire_pp4, wire_pp1};
	assign mult_out_2c = (sign_m)? ((~mult_out)) : mult_out;
        assign out = mult_out_2c;

mult4x4 u_mult4_pp1(
.a          ( a_magnitude[3:0] ),
.b          ( b_magnitude[3:0] ),
.out        ( wire_pp1 )
);

mult4x4 u_mult4_pp2(
.a          ( a_magnitude[7:4] ),
.b          ( b_magnitude[3:0] ),
.out        ( wire_pp2 )
);

mult4x4 u_mult4_pp3(
.a          ( a_magnitude[3:0] ),
.b          ( b_magnitude[7:4] ),
.out        ( wire_pp3 )
);

mult4x4 u_mult4_pp4(
.a          ( a_magnitude[7:4] ),
.b          ( b_magnitude[7:4] ),
.out        ( wire_pp4 )
);
endmodule

