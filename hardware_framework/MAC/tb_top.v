`timescale 1ns/1ns
/*TB 8 BITS*/
module tb_top;
 reg nvdla_core_clk;
reg nvdla_wg_clk;
reg nvdla_core_rstn;
reg cfg_is_wg;
reg cfg_reg_en;
reg [8*8 -1:0] dat_actv_data;
reg [8 -1:0] dat_actv_nz;
reg [8 -1:0] dat_actv_pvld;
reg [8*8 -1:0] wt_actv_data;
reg [8 -1:0] wt_actv_nz;
reg [8 -1:0] wt_actv_pvld;
wire [19 -1:0] mac_out_data;
wire mac_out_pvld;


 
 mac_unit UUT(
   .nvdla_core_clk (nvdla_core_clk) 
  ,.nvdla_wg_clk (nvdla_wg_clk) 
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.cfg_is_wg(cfg_is_wg) 
  ,.cfg_reg_en(cfg_reg_en) 
  ,.dat_actv_data(dat_actv_data)
  ,.dat_actv_nz(dat_actv_nz) 
  ,.dat_actv_pvld(dat_actv_pvld)
  ,.wt_actv_data(wt_actv_data) 
  ,.wt_actv_nz(wt_actv_nz) 
  ,.wt_actv_pvld(wt_actv_pvld) 
  ,.mac_out_data(mac_out_data) 
  ,.mac_out_pvld(mac_out_pvld) 
  );

  //Clock    
always begin
   #1 nvdla_core_clk =  ! nvdla_core_clk; 
end

integer outfile0;
integer outfile1;
reg [63:0] A;
reg [63:0] B;
initial begin
    nvdla_core_clk = 1; 
    nvdla_core_rstn = 0;
    #200
    nvdla_core_rstn = 1;
    wt_actv_nz = 8'hff;
    dat_actv_nz = 8'hff;
    wt_actv_pvld = 8'hff;
    dat_actv_pvld = 8'hff;
    #200
    outfile0=$fopen("./input_data/data_file.dat","r");
    outfile1=$fopen("./input_data/weight_file.dat","r"); 
    while (! $feof(outfile0)) begin
	$fscanf(outfile0,"%h\n",A);
	$fscanf(outfile0,"%h\n",B);
	dat_actv_data = A;
	wt_actv_data = B;
	#2;
    end 
    //once reading and writing is finished, close the file.
    $fclose(outfile0);
    $fclose(outfile1);
end

always @(mac_out_data) begin
	$display("data: %0h -- weight: %0h mac_out_data: %0h",dat_actv_data,wt_actv_data,mac_out_data);
end
 
  
endmodule


/*********************************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/


/*TB 16 BITS
module tb_top;
 reg nvdla_core_clk;
reg nvdla_wg_clk;
reg nvdla_core_rstn;
reg cfg_is_wg;
reg cfg_reg_en;
reg [8*16 -1:0] dat_actv_data;
reg [8 -1:0] dat_actv_nz;
reg [8 -1:0] dat_actv_pvld;
reg [8*16 -1:0] wt_actv_data;
reg [8 -1:0] wt_actv_nz;
reg [8 -1:0] wt_actv_pvld;
wire [34:0] mac_out_data;
wire mac_out_pvld;


 
 mac_unit UUT(
   .nvdla_core_clk (nvdla_core_clk) 
  ,.nvdla_wg_clk (nvdla_wg_clk) 
  ,.nvdla_core_rstn(nvdla_core_rstn)
  ,.cfg_is_wg(cfg_is_wg) 
  ,.cfg_reg_en(cfg_reg_en) 
  ,.dat_actv_data(dat_actv_data)
  ,.dat_actv_nz(dat_actv_nz) 
  ,.dat_actv_pvld(dat_actv_pvld)
  ,.wt_actv_data(wt_actv_data) 
  ,.wt_actv_nz(wt_actv_nz) 
  ,.wt_actv_pvld(wt_actv_pvld) 
  ,.mac_out_data(mac_out_data) 
  ,.mac_out_pvld(mac_out_pvld) 
  );

  //Clock    
always begin
   #1 nvdla_core_clk =  ! nvdla_core_clk; 
end

integer outfile0;
integer outfile1;
reg [128:0] A;
reg [128:0] B;
initial begin
    nvdla_core_clk = 1; 
    nvdla_core_rstn = 0;
    #200
    nvdla_core_rstn = 1;
    wt_actv_nz = 8'hff;
    dat_actv_nz = 8'hff;
    wt_actv_pvld = 8'hff;
    dat_actv_pvld = 8'hff;
    #200
    outfile0=$fopen("./input_data/data_file.dat","r");
    outfile1=$fopen("./input_data/weight_file.dat","r"); 
    while (! $feof(outfile0)) begin
	$fscanf(outfile0,"%h\n",A);
	$fscanf(outfile0,"%h\n",B);
	dat_actv_data = A;
	wt_actv_data = B;
	#2;
    end 
    //once reading and writing is finished, close the file.
    $fclose(outfile0);
    $fclose(outfile1);
end

always @(mac_out_data) begin
	$display("data: %0h -- weight: %0h mac_out_data: %0h",dat_actv_data,wt_actv_data,mac_out_data);
end
 
  
endmodule*/

