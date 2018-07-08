module mult2x2 (
  x1, x0, y1, y0,
  p3, p2, p1, p0
);
input x1, x0, y1, y0;
output p3, p2, p1, p0;

assign p3 = 0;
assign p2 = (x1 & y1);
assign p1 = (x1 & y0) | (x0 & y1);
assign p0 = (x0 & y0);
endmodule
