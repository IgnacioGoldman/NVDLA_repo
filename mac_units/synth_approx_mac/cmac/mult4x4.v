module mult4x4 (out, a, b);
	output [7:0] out;
        input [3:0] a;
        input [3:0] b;

 	wire  [7:0] wirex_out; 
  	wire  [3:0] wire_pp1; 
  	wire  [3:0] wire_pp2; 
  	wire  [3:0] wire_pp3; 
  	wire  [3:0] wire_pp4; 

	assign wirex_out = { 2'b0, wire_pp2, 2'b0} + {2'b0, wire_pp3, 2'b0} + {wire_pp4, wire_pp1};
	assign out = wirex_out;

mult2x2 u_mult_pp1(
.x1         ( a[1] ),
.x0         ( a[0] ),
.y1         ( b[1] ),
.y0         ( b[0] ),
.p0         ( wire_pp1[0] ),
.p1         ( wire_pp1[1] ),
.p2         ( wire_pp1[2] ),
.p3         ( wire_pp1[3] )
);

mult2x2 u_mult_pp2(
.x1         ( a[3] ),
.x0         ( a[2] ),
.y1         ( b[1] ),
.y0         ( b[0] ),
.p0         ( wire_pp2[0] ),
.p1         ( wire_pp2[1] ),
.p2         ( wire_pp2[2] ),
.p3         ( wire_pp2[3] )
);

mult2x2 u_mult_pp3(
.x1         ( a[1] ),
.x0         ( a[0] ),
.y1         ( b[3] ),
.y0         ( b[2] ),
.p0         ( wire_pp3[0] ),
.p1         ( wire_pp3[1] ),
.p2         ( wire_pp3[2] ),
.p3         ( wire_pp3[3] )
);

mult2x2 u_mult_pp4(
.x1         ( a[3] ),
.x0         ( a[2] ),
.y1         ( b[3] ),
.y0         ( b[2] ),
.p0         ( wire_pp4[0] ),
.p1         ( wire_pp4[1] ),
.p2         ( wire_pp4[2] ),
.p3         ( wire_pp4[3] )
);

endmodule
