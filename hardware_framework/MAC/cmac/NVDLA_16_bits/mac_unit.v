`define DESIGNWARE_NOEXIST 1

/*MAC NVDLA INT16*/
module mac_unit (
   nvdla_core_clk
  ,nvdla_wg_clk 
  ,nvdla_core_rstn
  ,cfg_is_wg 
  ,cfg_reg_en 
  ,dat_actv_data
  ,dat_actv_nz 
  ,dat_actv_pvld
  ,wt_actv_data 
  ,wt_actv_nz 
  ,wt_actv_pvld 
  ,mac_out_data 
  ,mac_out_pvld 
  );
input nvdla_core_clk;
input nvdla_wg_clk;
input nvdla_core_rstn;
input cfg_is_wg;
input cfg_reg_en;
input [8*16 -1:0] dat_actv_data;
input [8 -1:0] dat_actv_nz;
input [8 -1:0] dat_actv_pvld;
input [8*16 -1:0] wt_actv_data;
input [8 -1:0] wt_actv_nz;
input [8 -1:0] wt_actv_pvld;
output [35:0] mac_out_data;
output mac_out_pvld;

wire [15:0] wt_actv_data0 = wt_actv_data[15:0];
wire [15:0] dat_actv_data0 = dat_actv_data[15:0];
wire wt_actv_nz0 = wt_actv_nz[0];
wire dat_actv_nz0 = dat_actv_nz[0];

wire [15:0] wt_actv_data1 = wt_actv_data[31:16];
wire [15:0] dat_actv_data1 = dat_actv_data[31:16];
wire wt_actv_nz1 = wt_actv_nz[1];
wire dat_actv_nz1 = dat_actv_nz[1];

wire [15:0] wt_actv_data2 = wt_actv_data[47:32];
wire [15:0] dat_actv_data2 = dat_actv_data[47:32];
wire wt_actv_nz2 = wt_actv_nz[2];
wire dat_actv_nz2 = dat_actv_nz[2];

wire [15:0] wt_actv_data3 = wt_actv_data[63:48];
wire [15:0] dat_actv_data3 = dat_actv_data[63:48];
wire wt_actv_nz3 = wt_actv_nz[3];
wire dat_actv_nz3 = dat_actv_nz[3];

wire [15:0] wt_actv_data4 = wt_actv_data[79:64];
wire [15:0] dat_actv_data4 = dat_actv_data[79:64];
wire wt_actv_nz4 = wt_actv_nz[4];
wire dat_actv_nz4 = dat_actv_nz[4];

wire [15:0] wt_actv_data5 = wt_actv_data[95:80];
wire [15:0] dat_actv_data5 = dat_actv_data[95:80];
wire wt_actv_nz5 = wt_actv_nz[5];
wire dat_actv_nz5 = dat_actv_nz[5];

wire [15:0] wt_actv_data6 = wt_actv_data[111:96];
wire [15:0] dat_actv_data6 = dat_actv_data[111:96];
wire wt_actv_nz6 = wt_actv_nz[6];
wire dat_actv_nz6 = dat_actv_nz[6];

wire [15:0] wt_actv_data7 = wt_actv_data[127:112];
wire [15:0] dat_actv_data7 = dat_actv_data[127:112];
wire wt_actv_nz7 = wt_actv_nz[7];
wire dat_actv_nz7 = dat_actv_nz[7];


`ifdef DESIGNWARE_NOEXIST
wire signed [35:0] sum_out;
wire [8 -1:0] op_out_pvld;

assign op_out_pvld[0] = wt_actv_pvld[0] & dat_actv_pvld[0] & wt_actv_nz0 & dat_actv_nz0;
wire signed [35:0] mout_0 = ($signed(wt_actv_data0) * $signed(dat_actv_data0)) & $signed({18{op_out_pvld[0]}});
assign op_out_pvld[1] = wt_actv_pvld[1] & dat_actv_pvld[1] & wt_actv_nz1 & dat_actv_nz1;
wire signed [35:0] mout_1 = ($signed(wt_actv_data1) * $signed(dat_actv_data1)) & $signed({18{op_out_pvld[1]}});
assign op_out_pvld[2] = wt_actv_pvld[2] & dat_actv_pvld[2] & wt_actv_nz2 & dat_actv_nz2;
wire signed [35:0] mout_2 = ($signed(wt_actv_data2) * $signed(dat_actv_data2)) & $signed({18{op_out_pvld[2]}});
assign op_out_pvld[3] = wt_actv_pvld[3] & dat_actv_pvld[3] & wt_actv_nz3 & dat_actv_nz3;
wire signed [35:0] mout_3 = ($signed(wt_actv_data3) * $signed(dat_actv_data3)) & $signed({18{op_out_pvld[3]}});
assign op_out_pvld[4] = wt_actv_pvld[4] & dat_actv_pvld[4] & wt_actv_nz4 & dat_actv_nz4;
wire signed [35:0] mout_4 = ($signed(wt_actv_data4) * $signed(dat_actv_data4)) & $signed({18{op_out_pvld[4]}});
assign op_out_pvld[5] = wt_actv_pvld[5] & dat_actv_pvld[5] & wt_actv_nz5 & dat_actv_nz5;
wire signed [35:0] mout_5 = ($signed(wt_actv_data5) * $signed(dat_actv_data5)) & $signed({18{op_out_pvld[5]}});
assign op_out_pvld[6] = wt_actv_pvld[6] & dat_actv_pvld[6] & wt_actv_nz6 & dat_actv_nz6;
wire signed [35:0] mout_6 = ($signed(wt_actv_data6) * $signed(dat_actv_data6)) & $signed({18{op_out_pvld[6]}});
assign op_out_pvld[7] = wt_actv_pvld[7] & dat_actv_pvld[7] & wt_actv_nz7 & dat_actv_nz7;
wire signed [35:0] mout_7 = ($signed(wt_actv_data7) * $signed(dat_actv_data7)) & $signed({18{op_out_pvld[7]}});
assign sum_out = 
    mout_0
    + mout_1
    + mout_2
    + mout_3
    + mout_4
    + mout_5
    + mout_6
    + mout_7
; 
`endif

wire pp_pvld_d0 = (dat_actv_pvld[0] & wt_actv_pvld[0]);
wire [35:0] sum_out_d0 = sum_out;
reg [35:0] sum_out_d0_d1;
always @(posedge nvdla_core_clk) begin
    if ((pp_pvld_d0)) begin
        sum_out_d0_d1[35:0] <= sum_out_d0[35:0];
    end
end

reg pp_pvld_d0_d1;
always @(posedge nvdla_core_clk) begin
    pp_pvld_d0_d1 <= pp_pvld_d0;
end

reg [35:0] sum_out_d0_d2;
always @(posedge nvdla_core_clk) begin
    if ((pp_pvld_d0_d1)) begin
        sum_out_d0_d2[35:0] <= sum_out_d0_d1[35:0];
    end
end

reg pp_pvld_d0_d2;
always @(posedge nvdla_core_clk) begin
    pp_pvld_d0_d2 <= pp_pvld_d0_d1;
end

reg [35:0] sum_out_d0_d3;
always @(posedge nvdla_core_clk) begin
    if ((pp_pvld_d0_d2)) begin
        sum_out_d0_d3[35:0] <= sum_out_d0_d2[35:0];
    end
end

reg pp_pvld_d0_d3;
always @(posedge nvdla_core_clk) begin
    pp_pvld_d0_d3 <= pp_pvld_d0_d2;
end

wire [35:0] sum_out_dd;
assign sum_out_dd = sum_out_d0_d3;

wire pp_pvld_dd;
assign pp_pvld_dd = pp_pvld_d0_d3;

assign mac_out_pvld=pp_pvld_dd;
assign mac_out_data=sum_out_dd;
endmodule


