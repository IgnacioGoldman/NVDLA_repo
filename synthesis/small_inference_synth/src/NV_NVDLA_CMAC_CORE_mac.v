`define DESIGNWARE_NOEXIST 1
module NV_NVDLA_CMAC_CORE_mac (
   nvdla_core_clk //|< i
  ,nvdla_wg_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cfg_is_wg //|< i
  ,cfg_reg_en //|< i
  ,dat_actv_data //|< i
  ,dat_actv_nz //|< i
  ,dat_actv_pvld //|< i
  ,wt_actv_data //|< i
  ,wt_actv_nz //|< i
  ,wt_actv_pvld //|< i
  ,mac_out_data //|> o
  ,mac_out_pvld //|> o
  );
input nvdla_core_clk;
input nvdla_wg_clk;
input nvdla_core_rstn;
input cfg_is_wg;
input cfg_reg_en;
input [8*8 -1:0] dat_actv_data;
input [8 -1:0] dat_actv_nz;
input [8 -1:0] dat_actv_pvld;
input [8*8 -1:0] wt_actv_data;
input [8 -1:0] wt_actv_nz;
input [8 -1:0] wt_actv_pvld;
output reg [19 -1:0] mac_out_data;
output reg mac_out_pvld;

wire [8-1:0] wt_actv_data0 = wt_actv_data[7:0];
wire [8-1:0] dat_actv_data0 = dat_actv_data[7:0];
wire wt_actv_nz0 = wt_actv_nz[0];
wire dat_actv_nz0 = dat_actv_nz[0];

wire [8-1:0] wt_actv_data1 = wt_actv_data[15:8];
wire [8-1:0] dat_actv_data1 = dat_actv_data[15:8];
wire wt_actv_nz1 = wt_actv_nz[1];
wire dat_actv_nz1 = dat_actv_nz[1];

wire [8-1:0] wt_actv_data2 = wt_actv_data[23:16];
wire [8-1:0] dat_actv_data2 = dat_actv_data[23:16];
wire wt_actv_nz2 = wt_actv_nz[2];
wire dat_actv_nz2 = dat_actv_nz[2];

wire [8-1:0] wt_actv_data3 = wt_actv_data[31:24];
wire [8-1:0] dat_actv_data3 = dat_actv_data[31:24];
wire wt_actv_nz3 = wt_actv_nz[3];
wire dat_actv_nz3 = dat_actv_nz[3];

wire [8-1:0] wt_actv_data4 = wt_actv_data[39:32];
wire [8-1:0] dat_actv_data4 = dat_actv_data[39:32];
wire wt_actv_nz4 = wt_actv_nz[4];
wire dat_actv_nz4 = dat_actv_nz[4];

wire [8-1:0] wt_actv_data5 = wt_actv_data[47:40];
wire [8-1:0] dat_actv_data5 = dat_actv_data[47:40];
wire wt_actv_nz5 = wt_actv_nz[5];
wire dat_actv_nz5 = dat_actv_nz[5];

wire [8-1:0] wt_actv_data6 = wt_actv_data[55:48];
wire [8-1:0] dat_actv_data6 = dat_actv_data[55:48];
wire wt_actv_nz6 = wt_actv_nz[6];
wire dat_actv_nz6 = dat_actv_nz[6];

wire [8-1:0] wt_actv_data7 = wt_actv_data[63:56];
wire [8-1:0] dat_actv_data7 = dat_actv_data[63:56];
wire wt_actv_nz7 = wt_actv_nz[7];
wire dat_actv_nz7 = dat_actv_nz[7];

wire     [15:0] mult_res_00;
wire     [15:0] mult_res_01;
wire     [15:0] mult_res_02;
wire     [15:0] mult_res_03;
wire     [15:0] mult_res_04;
wire     [15:0] mult_res_05;
wire     [15:0] mult_res_06;
wire     [15:0] mult_res_07;

reg     [18:0] sign_ext_mult_res_00;
reg     [18:0] sign_ext_mult_res_01;
reg     [18:0] sign_ext_mult_res_02;
reg     [18:0] sign_ext_mult_res_03;
reg     [18:0] sign_ext_mult_res_04;
reg     [18:0] sign_ext_mult_res_05;
reg     [18:0] sign_ext_mult_res_06;
reg     [18:0] sign_ext_mult_res_07;

reg     [18:0] temp0;
reg     [18:0] temp1;
reg     [18:0] temp2;
reg     [18:0] temp3;

reg     [18:0] tempsec0;
reg     [18:0] tempsec1;

reg     [18:0]	tempter0;
reg     [18:0]	a1;
reg enable;
reg edge_of_pvld;


mult8 u_mul_0 (
  .a                  (wt_actv_data0[7:0])   //|< r
  ,.b                 (dat_actv_data0[7:0])  //|< r
  ,.out               (mult_res_00[15:0])     //|> w
  );
mult8 u_mul_1 (
  .a                  (wt_actv_data1[7:0])   //|< r
  ,.b                 (dat_actv_data1[7:0])  //|< r
  ,.out               (mult_res_01[15:0])     //|> w
  );
mult8 u_mul_2 (
  .a                  (wt_actv_data2[7:0])   //|< r
  ,.b                 (dat_actv_data2[7:0])  //|< r
  ,.out               (mult_res_02[15:0])     //|> w
  );
mult8 u_mul_3 (
  .a                  (wt_actv_data3[7:0])   //|< r
  ,.b                 (dat_actv_data3[7:0])  //|< r
  ,.out               (mult_res_03[15:0])     //|> w
  );
mult8 u_mul_4 (
  .a                  (wt_actv_data4[7:0])   //|< r
  ,.b                 (dat_actv_data4[7:0])  //|< r
  ,.out               (mult_res_04[15:0])     //|> w
  );
mult8 u_mul_5 (
  .a                  (wt_actv_data5[7:0])   //|< r
  ,.b                 (dat_actv_data5[7:0])  //|< r
  ,.out               (mult_res_05[15:0])     //|> w
  );
mult8 u_mul_6 (
  .a                  (wt_actv_data6[7:0])   //|< r
  ,.b                 (dat_actv_data6[7:0])  //|< r
  ,.out               (mult_res_06[15:0])     //|> w
  );
mult8 u_mul_7 (
  .a                  (wt_actv_data7[7:0])   //|< r
  ,.b                 (dat_actv_data7[7:0])  //|< r
  ,.out               (mult_res_07[15:0])     //|> w
  );
always @(posedge nvdla_core_clk) begin
	/*Sign extension, one clk cycle*/
	sign_ext_mult_res_00 = (mult_res_00[15]) ? {3'b111,mult_res_00} : {3'b000,mult_res_00};
	sign_ext_mult_res_01 = (mult_res_01[15]) ? {3'b111,mult_res_01} : {3'b000,mult_res_01};
	sign_ext_mult_res_02 = (mult_res_02[15]) ? {3'b111,mult_res_02} : {3'b000,mult_res_02};
	sign_ext_mult_res_03 = (mult_res_03[15]) ? {3'b111,mult_res_03} : {3'b000,mult_res_03};
	sign_ext_mult_res_04 = (mult_res_04[15]) ? {3'b111,mult_res_04} : {3'b000,mult_res_04};
	sign_ext_mult_res_05 = (mult_res_05[15]) ? {3'b111,mult_res_05} : {3'b000,mult_res_05};
	sign_ext_mult_res_06 = (mult_res_06[15]) ? {3'b111,mult_res_06} : {3'b000,mult_res_06};
	sign_ext_mult_res_07 = (mult_res_07[15]) ? {3'b111,mult_res_07} : {3'b000,mult_res_07};

	/*First sum considering overflow*/
	temp0 = sign_ext_mult_res_00 + sign_ext_mult_res_01;
	temp1 = sign_ext_mult_res_02 + sign_ext_mult_res_03;
	temp2 = sign_ext_mult_res_04 + sign_ext_mult_res_05;
	temp3 = sign_ext_mult_res_06 + sign_ext_mult_res_07;

	tempsec0 = temp0 + temp1;
	tempsec1 = temp2 + temp3;

	tempter0 = tempsec0 + tempsec1;

	/*Pipeline*/
	a1 = tempter0[18:0] & 17'b1;
	//if(a1 >= 1'b0) begin
		mac_out_data <= tempter0[18:0];	
	//end
        if(enable == 1'b1) begin
		mac_out_pvld <= 1'b1;
        end
        if(mac_out_pvld == 1'b1 || cfg_reg_en == 1'b1) begin
		mac_out_pvld <= 1'b0;
        end
end

always @(mac_out_data, mac_out_pvld) begin 
  if(mac_out_pvld == 1'b0 && edge_of_pvld == 1'b0) begin
	enable = 1'b1;
  end 
  else begin
        enable = 1'b0;
  end
end

always @(mac_out_pvld) begin
  if(mac_out_pvld == 1'b1) begin
	edge_of_pvld = 1'b1;
  end 
  else begin
        edge_of_pvld = 1'b0;
  end
end


endmodule // NV_NVDLA_CMAC_CORE_mac
