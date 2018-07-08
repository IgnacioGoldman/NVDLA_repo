module mult8x8 (out, a, b);
	output [15:0] out;
        input [7:0] a;
        input [7:0] b;

 	wire  [15:0] wirex_out; 
  	wire  [7:0] wire_pp1; 
  	wire  [7:0] wire_pp2; 
  	wire  [7:0] wire_pp3; 
  	wire  [7:0] wire_pp4; 

	assign wirex_out = { 4'b0, wire_pp2, 4'b0} + {4'b0, wire_pp3, 4'b0} + {wire_pp4, wire_pp1};
	assign out = wirex_out;



mult4x4 u_mult4_pp1(
.a          ( a[3:0] ),
.b          ( b[3:0] ),
.out        ( wire_pp1 )
);

mult4x4 u_mult4_pp2(
.a          ( a[7:4] ),
.b          ( b[3:0] ),
.out        ( wire_pp2 )
);

mult4x4 u_mult4_pp3(
.a          ( a[3:0] ),
.b          ( b[7:4] ),
.out        ( wire_pp3 )
);

mult4x4 u_mult4_pp4(
.a          ( a[7:4] ),
.b          ( b[7:4] ),
.out        ( wire_pp4 )
);

endmodule
