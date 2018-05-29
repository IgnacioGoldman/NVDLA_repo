// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_nvdla.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_define.h
///////////////////////////////////////////////////
//
`include "NV_HWACC_NVDLA_tick_defines.vh"
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CSC.h
    //entry bits
    //atomC
    //in bytes, entry/8
    //CSC_ENTRY_HEX/2
    //CSC_ENTRY_HEX/4
    //CSC_ENTRY_HEX-1
    //atomK
    //atomK
    //atomK*2
    `define CC_ATOMC_DIV_ATOMK_EQUAL_2
//image stripe keep 2*atomK
//batch keep 1
`define CBUF_WEIGHT_COMPRESSED //whether need read WMB
module NV_nvdla (
   dla_core_clk //|< i
  ,dla_csb_clk //|< i
  ,global_clk_ovr_on //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,dla_reset_rstn //|< i
  ,direct_reset_ //|< i
  ,test_mode //|< i
  ,csb2nvdla_valid //|< i
  ,csb2nvdla_ready //|> o
  ,csb2nvdla_addr //|< i
  ,csb2nvdla_wdat //|< i
  ,csb2nvdla_write //|< i
  ,csb2nvdla_nposted //|< i
  ,nvdla2csb_valid //|> o
  ,nvdla2csb_data //|> o
  ,nvdla2csb_wr_complete //|> o
  ,nvdla_core2dbb_aw_awvalid //|> o
  ,nvdla_core2dbb_aw_awready //|< i
  ,nvdla_core2dbb_aw_awid //|> o
  ,nvdla_core2dbb_aw_awlen //|> o
  ,nvdla_core2dbb_aw_awaddr //|> o
  ,nvdla_core2dbb_w_wvalid //|> o
  ,nvdla_core2dbb_w_wready //|< i
  ,nvdla_core2dbb_w_wdata //|> o
  ,nvdla_core2dbb_w_wstrb //|> o
  ,nvdla_core2dbb_w_wlast //|> o
  ,nvdla_core2dbb_b_bvalid //|< i
  ,nvdla_core2dbb_b_bready //|> o
  ,nvdla_core2dbb_b_bid //|< i
  ,nvdla_core2dbb_ar_arvalid //|> o
  ,nvdla_core2dbb_ar_arready //|< i
  ,nvdla_core2dbb_ar_arid //|> o
  ,nvdla_core2dbb_ar_arlen //|> o
  ,nvdla_core2dbb_ar_araddr //|> o
  ,nvdla_core2dbb_r_rvalid //|< i
  ,nvdla_core2dbb_r_rready //|> o
  ,nvdla_core2dbb_r_rid //|< i
  ,nvdla_core2dbb_r_rlast //|< i
  ,nvdla_core2dbb_r_rdata //|< i
  ,nvdla_core2cvsram_aw_awvalid //|> o
  ,nvdla_core2cvsram_aw_awready //|< i
  ,nvdla_core2cvsram_aw_awid //|> o
  ,nvdla_core2cvsram_aw_awlen //|> o
  ,nvdla_core2cvsram_aw_awaddr //|> o
  ,nvdla_core2cvsram_w_wvalid //|> o
  ,nvdla_core2cvsram_w_wready //|< i
  ,nvdla_core2cvsram_w_wdata //|> o
  ,nvdla_core2cvsram_w_wstrb //|> o
  ,nvdla_core2cvsram_w_wlast //|> o
  ,nvdla_core2cvsram_b_bvalid //|< i
  ,nvdla_core2cvsram_b_bready //|> o
  ,nvdla_core2cvsram_b_bid //|< i
  ,nvdla_core2cvsram_ar_arvalid //|> o
  ,nvdla_core2cvsram_ar_arready //|< i
  ,nvdla_core2cvsram_ar_arid //|> o
  ,nvdla_core2cvsram_ar_arlen //|> o
  ,nvdla_core2cvsram_ar_araddr //|> o
  ,nvdla_core2cvsram_r_rvalid //|< i
  ,nvdla_core2cvsram_r_rready //|> o
  ,nvdla_core2cvsram_r_rid //|< i
  ,nvdla_core2cvsram_r_rlast //|< i
  ,nvdla_core2cvsram_r_rdata //|< i
  ,dla_intr //|> o
  ,nvdla_pwrbus_ram_c_pd //|< i
  ,nvdla_pwrbus_ram_ma_pd //|< i *
  ,nvdla_pwrbus_ram_mb_pd //|< i *
  ,nvdla_pwrbus_ram_p_pd //|< i
  ,nvdla_pwrbus_ram_o_pd //|< i
  ,nvdla_pwrbus_ram_a_pd //|< i
  );
////////////////////////////////////////////////////////////////////////////////
input dla_core_clk;
input dla_csb_clk;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
input dla_reset_rstn;
input direct_reset_;
input test_mode;
//csb
input csb2nvdla_valid;
output csb2nvdla_ready;
input [15:0] csb2nvdla_addr;
input [31:0] csb2nvdla_wdat;
input csb2nvdla_write;
input csb2nvdla_nposted;
output nvdla2csb_valid;
output [31:0] nvdla2csb_data;
output nvdla2csb_wr_complete;
///////////////
output nvdla_core2dbb_aw_awvalid;
input nvdla_core2dbb_aw_awready;
output [7:0] nvdla_core2dbb_aw_awid;
output [3:0] nvdla_core2dbb_aw_awlen;
output [64 -1:0] nvdla_core2dbb_aw_awaddr;
output nvdla_core2dbb_w_wvalid;
input nvdla_core2dbb_w_wready;
output [512 -1:0] nvdla_core2dbb_w_wdata;
output [512/8-1:0] nvdla_core2dbb_w_wstrb;
output nvdla_core2dbb_w_wlast;
output nvdla_core2dbb_ar_arvalid;
input nvdla_core2dbb_ar_arready;
output [7:0] nvdla_core2dbb_ar_arid;
output [3:0] nvdla_core2dbb_ar_arlen;
output [64 -1:0] nvdla_core2dbb_ar_araddr;
input nvdla_core2dbb_b_bvalid;
output nvdla_core2dbb_b_bready;
input [7:0] nvdla_core2dbb_b_bid;
input nvdla_core2dbb_r_rvalid;
output nvdla_core2dbb_r_rready;
input [7:0] nvdla_core2dbb_r_rid;
input nvdla_core2dbb_r_rlast;
input [512 -1:0] nvdla_core2dbb_r_rdata;
output nvdla_core2cvsram_aw_awvalid;
input nvdla_core2cvsram_aw_awready;
output [7:0] nvdla_core2cvsram_aw_awid;
output [3:0] nvdla_core2cvsram_aw_awlen;
output [64 -1:0] nvdla_core2cvsram_aw_awaddr;
output nvdla_core2cvsram_w_wvalid;
input nvdla_core2cvsram_w_wready;
output [512 -1:0] nvdla_core2cvsram_w_wdata;
output [512/8-1:0] nvdla_core2cvsram_w_wstrb;
output nvdla_core2cvsram_w_wlast;
input nvdla_core2cvsram_b_bvalid;
output nvdla_core2cvsram_b_bready;
input [7:0] nvdla_core2cvsram_b_bid;
output nvdla_core2cvsram_ar_arvalid;
input nvdla_core2cvsram_ar_arready;
output [7:0] nvdla_core2cvsram_ar_arid;
output [3:0] nvdla_core2cvsram_ar_arlen;
output [64 -1:0] nvdla_core2cvsram_ar_araddr;
input nvdla_core2cvsram_r_rvalid;
output nvdla_core2cvsram_r_rready;
input [7:0] nvdla_core2cvsram_r_rid;
input nvdla_core2cvsram_r_rlast;
input [512 -1:0] nvdla_core2cvsram_r_rdata;
output dla_intr;
input [31:0] nvdla_pwrbus_ram_c_pd;
input [31:0] nvdla_pwrbus_ram_ma_pd;
input [31:0] nvdla_pwrbus_ram_mb_pd;
input [31:0] nvdla_pwrbus_ram_p_pd;
input [31:0] nvdla_pwrbus_ram_o_pd;
input [31:0] nvdla_pwrbus_ram_a_pd;
////////////////////////////////////////////////////////////////////////////////
wire [2:0] accu2sc_credit_size;
wire accu2sc_credit_vld;
wire [33:0] cacc2csb_resp_dst_pd;
wire cacc2csb_resp_dst_valid;
wire [33:0] cacc2csb_resp_src_pd;
wire cacc2csb_resp_src_valid;
wire [1:0] cacc2glb_done_intr_dst_pd;
wire [1:0] cacc2glb_done_intr_src_pd;
wire [16*32+2-1:0] cacc2sdp_pd;
wire cacc2sdp_ready;
wire cacc2sdp_valid;
wire [33:0] cdma2csb_resp_pd;
wire cdma2csb_resp_valid;
wire [1:0] cdma_dat2glb_done_intr_pd;
wire [1:0] cdma_wt2glb_done_intr_pd;
wire [33:0] cmac_a2csb_resp_src_pd;
wire cmac_a2csb_resp_src_valid;
wire [33:0] cmac_b2csb_resp_dst_pd;
wire cmac_b2csb_resp_dst_valid;
wire [33:0] cmac_b2csb_resp_src_pd;
wire cmac_b2csb_resp_src_valid;
wire [62:0] csb2cdma_req_pd;
wire csb2cdma_req_prdy;
wire csb2cdma_req_pvld;
wire [62:0] csb2cacc_req_dst_pd;
wire csb2cacc_req_dst_prdy;
wire csb2cacc_req_dst_pvld;
wire [62:0] csb2cacc_req_src_pd;
wire csb2cacc_req_src_prdy;
wire csb2cacc_req_src_pvld;
wire [62:0] csb2cmac_a_req_dst_pd;
wire csb2cmac_a_req_dst_prdy;
wire csb2cmac_a_req_dst_pvld;
wire [62:0] csb2cmac_b_req_dst_pd;
wire csb2cmac_b_req_dst_prdy;
wire csb2cmac_b_req_dst_pvld;
wire [62:0] csb2cmac_b_req_src_pd;
wire csb2cmac_b_req_src_prdy;
wire csb2cmac_b_req_src_pvld;
wire [62:0] csb2csc_req_pd;
wire csb2csc_req_prdy;
wire csb2csc_req_pvld;
wire [62:0] csb2sdp_rdma_req_pd;
wire csb2sdp_rdma_req_prdy;
wire csb2sdp_rdma_req_pvld;
wire [62:0] csb2sdp_req_pd;
wire csb2sdp_req_prdy;
wire csb2sdp_req_pvld;
wire [33:0] csc2csb_resp_pd;
wire csc2csb_resp_valid;
//: for(my $i=0; $i<32/2; $i++){
//: print qq(
//: wire [22 -1:0] mac_a2accu_dst_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [22 -1:0] mac_a2accu_dst_data0; 
wire [22 -1:0] mac_a2accu_dst_data1; 
wire [22 -1:0] mac_a2accu_dst_data2; 
wire [22 -1:0] mac_a2accu_dst_data3; 
wire [22 -1:0] mac_a2accu_dst_data4; 
wire [22 -1:0] mac_a2accu_dst_data5; 
wire [22 -1:0] mac_a2accu_dst_data6; 
wire [22 -1:0] mac_a2accu_dst_data7; 
wire [22 -1:0] mac_a2accu_dst_data8; 
wire [22 -1:0] mac_a2accu_dst_data9; 
wire [22 -1:0] mac_a2accu_dst_data10; 
wire [22 -1:0] mac_a2accu_dst_data11; 
wire [22 -1:0] mac_a2accu_dst_data12; 
wire [22 -1:0] mac_a2accu_dst_data13; 
wire [22 -1:0] mac_a2accu_dst_data14; 
wire [22 -1:0] mac_a2accu_dst_data15; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32/2-1:0] mac_a2accu_dst_mask;
wire mac_a2accu_dst_mode;
wire [8:0] mac_a2accu_dst_pd;
wire mac_a2accu_dst_pvld;
//: for(my $i=0; $i<32/2; $i++){
//: print qq(
//: wire [22 -1:0] mac_a2accu_src_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [22 -1:0] mac_a2accu_src_data0; 
wire [22 -1:0] mac_a2accu_src_data1; 
wire [22 -1:0] mac_a2accu_src_data2; 
wire [22 -1:0] mac_a2accu_src_data3; 
wire [22 -1:0] mac_a2accu_src_data4; 
wire [22 -1:0] mac_a2accu_src_data5; 
wire [22 -1:0] mac_a2accu_src_data6; 
wire [22 -1:0] mac_a2accu_src_data7; 
wire [22 -1:0] mac_a2accu_src_data8; 
wire [22 -1:0] mac_a2accu_src_data9; 
wire [22 -1:0] mac_a2accu_src_data10; 
wire [22 -1:0] mac_a2accu_src_data11; 
wire [22 -1:0] mac_a2accu_src_data12; 
wire [22 -1:0] mac_a2accu_src_data13; 
wire [22 -1:0] mac_a2accu_src_data14; 
wire [22 -1:0] mac_a2accu_src_data15; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32/2-1:0] mac_a2accu_src_mask;
wire mac_a2accu_src_mode;
wire [8:0] mac_a2accu_src_pd;
wire mac_a2accu_src_pvld;
//: for(my $i=0; $i<32/2; $i++){
//: print qq(
//: wire [22 -1:0] mac_b2accu_src_data${i}; )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [22 -1:0] mac_b2accu_src_data0; 
wire [22 -1:0] mac_b2accu_src_data1; 
wire [22 -1:0] mac_b2accu_src_data2; 
wire [22 -1:0] mac_b2accu_src_data3; 
wire [22 -1:0] mac_b2accu_src_data4; 
wire [22 -1:0] mac_b2accu_src_data5; 
wire [22 -1:0] mac_b2accu_src_data6; 
wire [22 -1:0] mac_b2accu_src_data7; 
wire [22 -1:0] mac_b2accu_src_data8; 
wire [22 -1:0] mac_b2accu_src_data9; 
wire [22 -1:0] mac_b2accu_src_data10; 
wire [22 -1:0] mac_b2accu_src_data11; 
wire [22 -1:0] mac_b2accu_src_data12; 
wire [22 -1:0] mac_b2accu_src_data13; 
wire [22 -1:0] mac_b2accu_src_data14; 
wire [22 -1:0] mac_b2accu_src_data15; 
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32/2-1:0] mac_b2accu_src_mask;
wire mac_b2accu_src_mode;
wire [8:0] mac_b2accu_src_pd;
wire mac_b2accu_src_pvld;
wire [64 +14:0] cdma_dat2cvif_rd_req_pd;
wire cdma_dat2cvif_rd_req_ready;
wire cdma_dat2cvif_rd_req_valid;
wire [64 +14:0] cdma_wt2cvif_rd_req_pd;
wire cdma_wt2cvif_rd_req_ready;
wire cdma_wt2cvif_rd_req_valid;
wire [512 +(512/8/32)-1:0] cvif2cdma_dat_rd_rsp_pd;
wire cvif2cdma_dat_rd_rsp_ready;
wire cvif2cdma_dat_rd_rsp_valid;
wire [512 +(512/8/32)-1:0] cvif2cdma_wt_rd_rsp_pd;
wire cvif2cdma_wt_rd_rsp_ready;
wire cvif2cdma_wt_rd_rsp_valid;
wire [512 +(512/8/32)-1:0] cvif2sdp_rd_rsp_pd;
wire cvif2sdp_rd_rsp_ready;
wire cvif2sdp_rd_rsp_valid;
wire cvif2sdp_wr_rsp_complete;
wire sdp2cvif_rd_cdt_lat_fifo_pop;
wire [64 +14:0] sdp2cvif_rd_req_pd;
wire sdp2cvif_rd_req_ready;
wire sdp2cvif_rd_req_valid;
wire [512 +(512/8/32):0] sdp2cvif_wr_req_pd;
wire sdp2cvif_wr_req_ready;
wire sdp2cvif_wr_req_valid;
wire [512 +(512/8/32)-1:0] cvif2sdp_b_rd_rsp_pd;
wire cvif2sdp_b_rd_rsp_ready;
wire cvif2sdp_b_rd_rsp_valid;
wire sdp_b2cvif_rd_cdt_lat_fifo_pop;
wire [64 +14:0] sdp_b2cvif_rd_req_pd;
wire sdp_b2cvif_rd_req_ready;
wire sdp_b2cvif_rd_req_valid;
wire [512 +(512/8/32)-1:0] cvif2sdp_e_rd_rsp_pd;
wire cvif2sdp_e_rd_rsp_ready;
wire cvif2sdp_e_rd_rsp_valid;
wire sdp_e2cvif_rd_cdt_lat_fifo_pop;
wire [64 +14:0] sdp_e2cvif_rd_req_pd;
wire sdp_e2cvif_rd_req_ready;
wire sdp_e2cvif_rd_req_valid;
wire [512 +(512/8/32)-1:0] cvif2sdp_n_rd_rsp_pd;
wire cvif2sdp_n_rd_rsp_ready;
wire cvif2sdp_n_rd_rsp_valid;
wire sdp_n2cvif_rd_cdt_lat_fifo_pop;
wire [64 +14:0] sdp_n2cvif_rd_req_pd;
wire sdp_n2cvif_rd_req_ready;
wire sdp_n2cvif_rd_req_valid;
wire [64 +14:0] cdma_dat2mcif_rd_req_pd;
wire cdma_dat2mcif_rd_req_ready;
wire cdma_dat2mcif_rd_req_valid;
wire [64 +14:0] cdma_wt2mcif_rd_req_pd;
wire cdma_wt2mcif_rd_req_ready;
wire cdma_wt2mcif_rd_req_valid;
wire [512 +(512/8/32)-1:0] mcif2cdma_dat_rd_rsp_pd;
wire mcif2cdma_dat_rd_rsp_ready;
wire mcif2cdma_dat_rd_rsp_valid;
wire [512 +(512/8/32)-1:0] mcif2cdma_wt_rd_rsp_pd;
wire mcif2cdma_wt_rd_rsp_ready;
wire mcif2cdma_wt_rd_rsp_valid;
  wire [512 +(512/8/32)-1:0] mcif2sdp_b_rd_rsp_pd;
  wire mcif2sdp_b_rd_rsp_ready;
  wire mcif2sdp_b_rd_rsp_valid;
  wire sdp_b2mcif_rd_cdt_lat_fifo_pop;
  wire [64 +14:0] sdp_b2mcif_rd_req_pd;
  wire sdp_b2mcif_rd_req_ready;
  wire sdp_b2mcif_rd_req_valid;
  wire [512 +(512/8/32)-1:0] mcif2sdp_e_rd_rsp_pd;
  wire mcif2sdp_e_rd_rsp_ready;
  wire mcif2sdp_e_rd_rsp_valid;
  wire sdp_e2mcif_rd_cdt_lat_fifo_pop;
  wire [64 +14:0] sdp_e2mcif_rd_req_pd;
  wire sdp_e2mcif_rd_req_ready;
  wire sdp_e2mcif_rd_req_valid;
  wire [512 +(512/8/32)-1:0] mcif2sdp_n_rd_rsp_pd;
  wire mcif2sdp_n_rd_rsp_ready;
  wire mcif2sdp_n_rd_rsp_valid;
  wire sdp_n2mcif_rd_cdt_lat_fifo_pop;
  wire [64 +14:0] sdp_n2mcif_rd_req_pd;
  wire sdp_n2mcif_rd_req_ready;
  wire sdp_n2mcif_rd_req_valid;
wire [512 +(512/8/32)-1:0] mcif2sdp_rd_rsp_pd;
wire mcif2sdp_rd_rsp_ready;
wire mcif2sdp_rd_rsp_valid;
wire mcif2sdp_wr_rsp_complete;
wire sdp2mcif_rd_cdt_lat_fifo_pop;
wire [64 +14:0] sdp2mcif_rd_req_pd;
wire sdp2mcif_rd_req_ready;
wire sdp2mcif_rd_req_valid;
wire [512 +(512/8/32):0] sdp2mcif_wr_req_pd;
wire sdp2mcif_wr_req_ready;
wire sdp2mcif_wr_req_valid;
wire [33:0] sdp2csb_resp_pd;
wire sdp2csb_resp_valid;
wire [1:0] sdp2glb_done_intr_pd;
wire [16*8 -1:0] sdp2pdp_pd;
wire sdp2pdp_ready;
wire sdp2pdp_valid;
wire [33:0] sdp_rdma2csb_resp_pd;
wire sdp_rdma2csb_resp_valid;
wire nvdla_clk_ovr_on;
wire nvdla_core_rstn;
//: my $kk=64 -1;
//: foreach my $i (0..${kk}) {
//: print qq(
//: wire [7:0] sc2mac_dat_a_dst_data${i};
//: wire [7:0] sc2mac_dat_a_src_data${i};
//: wire [7:0] sc2mac_dat_b_dst_data${i};
//: wire [7:0] sc2mac_wt_a_dst_data${i};
//: wire [7:0] sc2mac_wt_a_src_data${i};
//: wire [7:0] sc2mac_wt_b_dst_data${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [7:0] sc2mac_dat_a_dst_data0;
wire [7:0] sc2mac_dat_a_src_data0;
wire [7:0] sc2mac_dat_b_dst_data0;
wire [7:0] sc2mac_wt_a_dst_data0;
wire [7:0] sc2mac_wt_a_src_data0;
wire [7:0] sc2mac_wt_b_dst_data0;

wire [7:0] sc2mac_dat_a_dst_data1;
wire [7:0] sc2mac_dat_a_src_data1;
wire [7:0] sc2mac_dat_b_dst_data1;
wire [7:0] sc2mac_wt_a_dst_data1;
wire [7:0] sc2mac_wt_a_src_data1;
wire [7:0] sc2mac_wt_b_dst_data1;

wire [7:0] sc2mac_dat_a_dst_data2;
wire [7:0] sc2mac_dat_a_src_data2;
wire [7:0] sc2mac_dat_b_dst_data2;
wire [7:0] sc2mac_wt_a_dst_data2;
wire [7:0] sc2mac_wt_a_src_data2;
wire [7:0] sc2mac_wt_b_dst_data2;

wire [7:0] sc2mac_dat_a_dst_data3;
wire [7:0] sc2mac_dat_a_src_data3;
wire [7:0] sc2mac_dat_b_dst_data3;
wire [7:0] sc2mac_wt_a_dst_data3;
wire [7:0] sc2mac_wt_a_src_data3;
wire [7:0] sc2mac_wt_b_dst_data3;

wire [7:0] sc2mac_dat_a_dst_data4;
wire [7:0] sc2mac_dat_a_src_data4;
wire [7:0] sc2mac_dat_b_dst_data4;
wire [7:0] sc2mac_wt_a_dst_data4;
wire [7:0] sc2mac_wt_a_src_data4;
wire [7:0] sc2mac_wt_b_dst_data4;

wire [7:0] sc2mac_dat_a_dst_data5;
wire [7:0] sc2mac_dat_a_src_data5;
wire [7:0] sc2mac_dat_b_dst_data5;
wire [7:0] sc2mac_wt_a_dst_data5;
wire [7:0] sc2mac_wt_a_src_data5;
wire [7:0] sc2mac_wt_b_dst_data5;

wire [7:0] sc2mac_dat_a_dst_data6;
wire [7:0] sc2mac_dat_a_src_data6;
wire [7:0] sc2mac_dat_b_dst_data6;
wire [7:0] sc2mac_wt_a_dst_data6;
wire [7:0] sc2mac_wt_a_src_data6;
wire [7:0] sc2mac_wt_b_dst_data6;

wire [7:0] sc2mac_dat_a_dst_data7;
wire [7:0] sc2mac_dat_a_src_data7;
wire [7:0] sc2mac_dat_b_dst_data7;
wire [7:0] sc2mac_wt_a_dst_data7;
wire [7:0] sc2mac_wt_a_src_data7;
wire [7:0] sc2mac_wt_b_dst_data7;

wire [7:0] sc2mac_dat_a_dst_data8;
wire [7:0] sc2mac_dat_a_src_data8;
wire [7:0] sc2mac_dat_b_dst_data8;
wire [7:0] sc2mac_wt_a_dst_data8;
wire [7:0] sc2mac_wt_a_src_data8;
wire [7:0] sc2mac_wt_b_dst_data8;

wire [7:0] sc2mac_dat_a_dst_data9;
wire [7:0] sc2mac_dat_a_src_data9;
wire [7:0] sc2mac_dat_b_dst_data9;
wire [7:0] sc2mac_wt_a_dst_data9;
wire [7:0] sc2mac_wt_a_src_data9;
wire [7:0] sc2mac_wt_b_dst_data9;

wire [7:0] sc2mac_dat_a_dst_data10;
wire [7:0] sc2mac_dat_a_src_data10;
wire [7:0] sc2mac_dat_b_dst_data10;
wire [7:0] sc2mac_wt_a_dst_data10;
wire [7:0] sc2mac_wt_a_src_data10;
wire [7:0] sc2mac_wt_b_dst_data10;

wire [7:0] sc2mac_dat_a_dst_data11;
wire [7:0] sc2mac_dat_a_src_data11;
wire [7:0] sc2mac_dat_b_dst_data11;
wire [7:0] sc2mac_wt_a_dst_data11;
wire [7:0] sc2mac_wt_a_src_data11;
wire [7:0] sc2mac_wt_b_dst_data11;

wire [7:0] sc2mac_dat_a_dst_data12;
wire [7:0] sc2mac_dat_a_src_data12;
wire [7:0] sc2mac_dat_b_dst_data12;
wire [7:0] sc2mac_wt_a_dst_data12;
wire [7:0] sc2mac_wt_a_src_data12;
wire [7:0] sc2mac_wt_b_dst_data12;

wire [7:0] sc2mac_dat_a_dst_data13;
wire [7:0] sc2mac_dat_a_src_data13;
wire [7:0] sc2mac_dat_b_dst_data13;
wire [7:0] sc2mac_wt_a_dst_data13;
wire [7:0] sc2mac_wt_a_src_data13;
wire [7:0] sc2mac_wt_b_dst_data13;

wire [7:0] sc2mac_dat_a_dst_data14;
wire [7:0] sc2mac_dat_a_src_data14;
wire [7:0] sc2mac_dat_b_dst_data14;
wire [7:0] sc2mac_wt_a_dst_data14;
wire [7:0] sc2mac_wt_a_src_data14;
wire [7:0] sc2mac_wt_b_dst_data14;

wire [7:0] sc2mac_dat_a_dst_data15;
wire [7:0] sc2mac_dat_a_src_data15;
wire [7:0] sc2mac_dat_b_dst_data15;
wire [7:0] sc2mac_wt_a_dst_data15;
wire [7:0] sc2mac_wt_a_src_data15;
wire [7:0] sc2mac_wt_b_dst_data15;

wire [7:0] sc2mac_dat_a_dst_data16;
wire [7:0] sc2mac_dat_a_src_data16;
wire [7:0] sc2mac_dat_b_dst_data16;
wire [7:0] sc2mac_wt_a_dst_data16;
wire [7:0] sc2mac_wt_a_src_data16;
wire [7:0] sc2mac_wt_b_dst_data16;

wire [7:0] sc2mac_dat_a_dst_data17;
wire [7:0] sc2mac_dat_a_src_data17;
wire [7:0] sc2mac_dat_b_dst_data17;
wire [7:0] sc2mac_wt_a_dst_data17;
wire [7:0] sc2mac_wt_a_src_data17;
wire [7:0] sc2mac_wt_b_dst_data17;

wire [7:0] sc2mac_dat_a_dst_data18;
wire [7:0] sc2mac_dat_a_src_data18;
wire [7:0] sc2mac_dat_b_dst_data18;
wire [7:0] sc2mac_wt_a_dst_data18;
wire [7:0] sc2mac_wt_a_src_data18;
wire [7:0] sc2mac_wt_b_dst_data18;

wire [7:0] sc2mac_dat_a_dst_data19;
wire [7:0] sc2mac_dat_a_src_data19;
wire [7:0] sc2mac_dat_b_dst_data19;
wire [7:0] sc2mac_wt_a_dst_data19;
wire [7:0] sc2mac_wt_a_src_data19;
wire [7:0] sc2mac_wt_b_dst_data19;

wire [7:0] sc2mac_dat_a_dst_data20;
wire [7:0] sc2mac_dat_a_src_data20;
wire [7:0] sc2mac_dat_b_dst_data20;
wire [7:0] sc2mac_wt_a_dst_data20;
wire [7:0] sc2mac_wt_a_src_data20;
wire [7:0] sc2mac_wt_b_dst_data20;

wire [7:0] sc2mac_dat_a_dst_data21;
wire [7:0] sc2mac_dat_a_src_data21;
wire [7:0] sc2mac_dat_b_dst_data21;
wire [7:0] sc2mac_wt_a_dst_data21;
wire [7:0] sc2mac_wt_a_src_data21;
wire [7:0] sc2mac_wt_b_dst_data21;

wire [7:0] sc2mac_dat_a_dst_data22;
wire [7:0] sc2mac_dat_a_src_data22;
wire [7:0] sc2mac_dat_b_dst_data22;
wire [7:0] sc2mac_wt_a_dst_data22;
wire [7:0] sc2mac_wt_a_src_data22;
wire [7:0] sc2mac_wt_b_dst_data22;

wire [7:0] sc2mac_dat_a_dst_data23;
wire [7:0] sc2mac_dat_a_src_data23;
wire [7:0] sc2mac_dat_b_dst_data23;
wire [7:0] sc2mac_wt_a_dst_data23;
wire [7:0] sc2mac_wt_a_src_data23;
wire [7:0] sc2mac_wt_b_dst_data23;

wire [7:0] sc2mac_dat_a_dst_data24;
wire [7:0] sc2mac_dat_a_src_data24;
wire [7:0] sc2mac_dat_b_dst_data24;
wire [7:0] sc2mac_wt_a_dst_data24;
wire [7:0] sc2mac_wt_a_src_data24;
wire [7:0] sc2mac_wt_b_dst_data24;

wire [7:0] sc2mac_dat_a_dst_data25;
wire [7:0] sc2mac_dat_a_src_data25;
wire [7:0] sc2mac_dat_b_dst_data25;
wire [7:0] sc2mac_wt_a_dst_data25;
wire [7:0] sc2mac_wt_a_src_data25;
wire [7:0] sc2mac_wt_b_dst_data25;

wire [7:0] sc2mac_dat_a_dst_data26;
wire [7:0] sc2mac_dat_a_src_data26;
wire [7:0] sc2mac_dat_b_dst_data26;
wire [7:0] sc2mac_wt_a_dst_data26;
wire [7:0] sc2mac_wt_a_src_data26;
wire [7:0] sc2mac_wt_b_dst_data26;

wire [7:0] sc2mac_dat_a_dst_data27;
wire [7:0] sc2mac_dat_a_src_data27;
wire [7:0] sc2mac_dat_b_dst_data27;
wire [7:0] sc2mac_wt_a_dst_data27;
wire [7:0] sc2mac_wt_a_src_data27;
wire [7:0] sc2mac_wt_b_dst_data27;

wire [7:0] sc2mac_dat_a_dst_data28;
wire [7:0] sc2mac_dat_a_src_data28;
wire [7:0] sc2mac_dat_b_dst_data28;
wire [7:0] sc2mac_wt_a_dst_data28;
wire [7:0] sc2mac_wt_a_src_data28;
wire [7:0] sc2mac_wt_b_dst_data28;

wire [7:0] sc2mac_dat_a_dst_data29;
wire [7:0] sc2mac_dat_a_src_data29;
wire [7:0] sc2mac_dat_b_dst_data29;
wire [7:0] sc2mac_wt_a_dst_data29;
wire [7:0] sc2mac_wt_a_src_data29;
wire [7:0] sc2mac_wt_b_dst_data29;

wire [7:0] sc2mac_dat_a_dst_data30;
wire [7:0] sc2mac_dat_a_src_data30;
wire [7:0] sc2mac_dat_b_dst_data30;
wire [7:0] sc2mac_wt_a_dst_data30;
wire [7:0] sc2mac_wt_a_src_data30;
wire [7:0] sc2mac_wt_b_dst_data30;

wire [7:0] sc2mac_dat_a_dst_data31;
wire [7:0] sc2mac_dat_a_src_data31;
wire [7:0] sc2mac_dat_b_dst_data31;
wire [7:0] sc2mac_wt_a_dst_data31;
wire [7:0] sc2mac_wt_a_src_data31;
wire [7:0] sc2mac_wt_b_dst_data31;

wire [7:0] sc2mac_dat_a_dst_data32;
wire [7:0] sc2mac_dat_a_src_data32;
wire [7:0] sc2mac_dat_b_dst_data32;
wire [7:0] sc2mac_wt_a_dst_data32;
wire [7:0] sc2mac_wt_a_src_data32;
wire [7:0] sc2mac_wt_b_dst_data32;

wire [7:0] sc2mac_dat_a_dst_data33;
wire [7:0] sc2mac_dat_a_src_data33;
wire [7:0] sc2mac_dat_b_dst_data33;
wire [7:0] sc2mac_wt_a_dst_data33;
wire [7:0] sc2mac_wt_a_src_data33;
wire [7:0] sc2mac_wt_b_dst_data33;

wire [7:0] sc2mac_dat_a_dst_data34;
wire [7:0] sc2mac_dat_a_src_data34;
wire [7:0] sc2mac_dat_b_dst_data34;
wire [7:0] sc2mac_wt_a_dst_data34;
wire [7:0] sc2mac_wt_a_src_data34;
wire [7:0] sc2mac_wt_b_dst_data34;

wire [7:0] sc2mac_dat_a_dst_data35;
wire [7:0] sc2mac_dat_a_src_data35;
wire [7:0] sc2mac_dat_b_dst_data35;
wire [7:0] sc2mac_wt_a_dst_data35;
wire [7:0] sc2mac_wt_a_src_data35;
wire [7:0] sc2mac_wt_b_dst_data35;

wire [7:0] sc2mac_dat_a_dst_data36;
wire [7:0] sc2mac_dat_a_src_data36;
wire [7:0] sc2mac_dat_b_dst_data36;
wire [7:0] sc2mac_wt_a_dst_data36;
wire [7:0] sc2mac_wt_a_src_data36;
wire [7:0] sc2mac_wt_b_dst_data36;

wire [7:0] sc2mac_dat_a_dst_data37;
wire [7:0] sc2mac_dat_a_src_data37;
wire [7:0] sc2mac_dat_b_dst_data37;
wire [7:0] sc2mac_wt_a_dst_data37;
wire [7:0] sc2mac_wt_a_src_data37;
wire [7:0] sc2mac_wt_b_dst_data37;

wire [7:0] sc2mac_dat_a_dst_data38;
wire [7:0] sc2mac_dat_a_src_data38;
wire [7:0] sc2mac_dat_b_dst_data38;
wire [7:0] sc2mac_wt_a_dst_data38;
wire [7:0] sc2mac_wt_a_src_data38;
wire [7:0] sc2mac_wt_b_dst_data38;

wire [7:0] sc2mac_dat_a_dst_data39;
wire [7:0] sc2mac_dat_a_src_data39;
wire [7:0] sc2mac_dat_b_dst_data39;
wire [7:0] sc2mac_wt_a_dst_data39;
wire [7:0] sc2mac_wt_a_src_data39;
wire [7:0] sc2mac_wt_b_dst_data39;

wire [7:0] sc2mac_dat_a_dst_data40;
wire [7:0] sc2mac_dat_a_src_data40;
wire [7:0] sc2mac_dat_b_dst_data40;
wire [7:0] sc2mac_wt_a_dst_data40;
wire [7:0] sc2mac_wt_a_src_data40;
wire [7:0] sc2mac_wt_b_dst_data40;

wire [7:0] sc2mac_dat_a_dst_data41;
wire [7:0] sc2mac_dat_a_src_data41;
wire [7:0] sc2mac_dat_b_dst_data41;
wire [7:0] sc2mac_wt_a_dst_data41;
wire [7:0] sc2mac_wt_a_src_data41;
wire [7:0] sc2mac_wt_b_dst_data41;

wire [7:0] sc2mac_dat_a_dst_data42;
wire [7:0] sc2mac_dat_a_src_data42;
wire [7:0] sc2mac_dat_b_dst_data42;
wire [7:0] sc2mac_wt_a_dst_data42;
wire [7:0] sc2mac_wt_a_src_data42;
wire [7:0] sc2mac_wt_b_dst_data42;

wire [7:0] sc2mac_dat_a_dst_data43;
wire [7:0] sc2mac_dat_a_src_data43;
wire [7:0] sc2mac_dat_b_dst_data43;
wire [7:0] sc2mac_wt_a_dst_data43;
wire [7:0] sc2mac_wt_a_src_data43;
wire [7:0] sc2mac_wt_b_dst_data43;

wire [7:0] sc2mac_dat_a_dst_data44;
wire [7:0] sc2mac_dat_a_src_data44;
wire [7:0] sc2mac_dat_b_dst_data44;
wire [7:0] sc2mac_wt_a_dst_data44;
wire [7:0] sc2mac_wt_a_src_data44;
wire [7:0] sc2mac_wt_b_dst_data44;

wire [7:0] sc2mac_dat_a_dst_data45;
wire [7:0] sc2mac_dat_a_src_data45;
wire [7:0] sc2mac_dat_b_dst_data45;
wire [7:0] sc2mac_wt_a_dst_data45;
wire [7:0] sc2mac_wt_a_src_data45;
wire [7:0] sc2mac_wt_b_dst_data45;

wire [7:0] sc2mac_dat_a_dst_data46;
wire [7:0] sc2mac_dat_a_src_data46;
wire [7:0] sc2mac_dat_b_dst_data46;
wire [7:0] sc2mac_wt_a_dst_data46;
wire [7:0] sc2mac_wt_a_src_data46;
wire [7:0] sc2mac_wt_b_dst_data46;

wire [7:0] sc2mac_dat_a_dst_data47;
wire [7:0] sc2mac_dat_a_src_data47;
wire [7:0] sc2mac_dat_b_dst_data47;
wire [7:0] sc2mac_wt_a_dst_data47;
wire [7:0] sc2mac_wt_a_src_data47;
wire [7:0] sc2mac_wt_b_dst_data47;

wire [7:0] sc2mac_dat_a_dst_data48;
wire [7:0] sc2mac_dat_a_src_data48;
wire [7:0] sc2mac_dat_b_dst_data48;
wire [7:0] sc2mac_wt_a_dst_data48;
wire [7:0] sc2mac_wt_a_src_data48;
wire [7:0] sc2mac_wt_b_dst_data48;

wire [7:0] sc2mac_dat_a_dst_data49;
wire [7:0] sc2mac_dat_a_src_data49;
wire [7:0] sc2mac_dat_b_dst_data49;
wire [7:0] sc2mac_wt_a_dst_data49;
wire [7:0] sc2mac_wt_a_src_data49;
wire [7:0] sc2mac_wt_b_dst_data49;

wire [7:0] sc2mac_dat_a_dst_data50;
wire [7:0] sc2mac_dat_a_src_data50;
wire [7:0] sc2mac_dat_b_dst_data50;
wire [7:0] sc2mac_wt_a_dst_data50;
wire [7:0] sc2mac_wt_a_src_data50;
wire [7:0] sc2mac_wt_b_dst_data50;

wire [7:0] sc2mac_dat_a_dst_data51;
wire [7:0] sc2mac_dat_a_src_data51;
wire [7:0] sc2mac_dat_b_dst_data51;
wire [7:0] sc2mac_wt_a_dst_data51;
wire [7:0] sc2mac_wt_a_src_data51;
wire [7:0] sc2mac_wt_b_dst_data51;

wire [7:0] sc2mac_dat_a_dst_data52;
wire [7:0] sc2mac_dat_a_src_data52;
wire [7:0] sc2mac_dat_b_dst_data52;
wire [7:0] sc2mac_wt_a_dst_data52;
wire [7:0] sc2mac_wt_a_src_data52;
wire [7:0] sc2mac_wt_b_dst_data52;

wire [7:0] sc2mac_dat_a_dst_data53;
wire [7:0] sc2mac_dat_a_src_data53;
wire [7:0] sc2mac_dat_b_dst_data53;
wire [7:0] sc2mac_wt_a_dst_data53;
wire [7:0] sc2mac_wt_a_src_data53;
wire [7:0] sc2mac_wt_b_dst_data53;

wire [7:0] sc2mac_dat_a_dst_data54;
wire [7:0] sc2mac_dat_a_src_data54;
wire [7:0] sc2mac_dat_b_dst_data54;
wire [7:0] sc2mac_wt_a_dst_data54;
wire [7:0] sc2mac_wt_a_src_data54;
wire [7:0] sc2mac_wt_b_dst_data54;

wire [7:0] sc2mac_dat_a_dst_data55;
wire [7:0] sc2mac_dat_a_src_data55;
wire [7:0] sc2mac_dat_b_dst_data55;
wire [7:0] sc2mac_wt_a_dst_data55;
wire [7:0] sc2mac_wt_a_src_data55;
wire [7:0] sc2mac_wt_b_dst_data55;

wire [7:0] sc2mac_dat_a_dst_data56;
wire [7:0] sc2mac_dat_a_src_data56;
wire [7:0] sc2mac_dat_b_dst_data56;
wire [7:0] sc2mac_wt_a_dst_data56;
wire [7:0] sc2mac_wt_a_src_data56;
wire [7:0] sc2mac_wt_b_dst_data56;

wire [7:0] sc2mac_dat_a_dst_data57;
wire [7:0] sc2mac_dat_a_src_data57;
wire [7:0] sc2mac_dat_b_dst_data57;
wire [7:0] sc2mac_wt_a_dst_data57;
wire [7:0] sc2mac_wt_a_src_data57;
wire [7:0] sc2mac_wt_b_dst_data57;

wire [7:0] sc2mac_dat_a_dst_data58;
wire [7:0] sc2mac_dat_a_src_data58;
wire [7:0] sc2mac_dat_b_dst_data58;
wire [7:0] sc2mac_wt_a_dst_data58;
wire [7:0] sc2mac_wt_a_src_data58;
wire [7:0] sc2mac_wt_b_dst_data58;

wire [7:0] sc2mac_dat_a_dst_data59;
wire [7:0] sc2mac_dat_a_src_data59;
wire [7:0] sc2mac_dat_b_dst_data59;
wire [7:0] sc2mac_wt_a_dst_data59;
wire [7:0] sc2mac_wt_a_src_data59;
wire [7:0] sc2mac_wt_b_dst_data59;

wire [7:0] sc2mac_dat_a_dst_data60;
wire [7:0] sc2mac_dat_a_src_data60;
wire [7:0] sc2mac_dat_b_dst_data60;
wire [7:0] sc2mac_wt_a_dst_data60;
wire [7:0] sc2mac_wt_a_src_data60;
wire [7:0] sc2mac_wt_b_dst_data60;

wire [7:0] sc2mac_dat_a_dst_data61;
wire [7:0] sc2mac_dat_a_src_data61;
wire [7:0] sc2mac_dat_b_dst_data61;
wire [7:0] sc2mac_wt_a_dst_data61;
wire [7:0] sc2mac_wt_a_src_data61;
wire [7:0] sc2mac_wt_b_dst_data61;

wire [7:0] sc2mac_dat_a_dst_data62;
wire [7:0] sc2mac_dat_a_src_data62;
wire [7:0] sc2mac_dat_b_dst_data62;
wire [7:0] sc2mac_wt_a_dst_data62;
wire [7:0] sc2mac_wt_a_src_data62;
wire [7:0] sc2mac_wt_b_dst_data62;

wire [7:0] sc2mac_dat_a_dst_data63;
wire [7:0] sc2mac_dat_a_src_data63;
wire [7:0] sc2mac_dat_b_dst_data63;
wire [7:0] sc2mac_wt_a_dst_data63;
wire [7:0] sc2mac_wt_a_src_data63;
wire [7:0] sc2mac_wt_b_dst_data63;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [64 -1:0] sc2mac_dat_a_dst_mask;
wire [8:0] sc2mac_dat_a_dst_pd;
wire sc2mac_dat_a_dst_pvld;
wire [64 -1:0] sc2mac_dat_a_src_mask;
wire [8:0] sc2mac_dat_a_src_pd;
wire sc2mac_dat_a_src_pvld;
wire [64 -1:0] sc2mac_dat_b_dst_mask;
wire [8:0] sc2mac_dat_b_dst_pd;
wire sc2mac_dat_b_dst_pvld;
wire [64 -1:0] sc2mac_wt_a_dst_mask;
wire sc2mac_wt_a_dst_pvld;
wire [32/2-1:0] sc2mac_wt_a_dst_sel;
wire [64 -1:0] sc2mac_wt_a_src_mask;
wire sc2mac_wt_a_src_pvld;
wire [32/2-1:0] sc2mac_wt_a_src_sel;
wire [64 -1:0] sc2mac_wt_b_dst_mask;
wire sc2mac_wt_b_dst_pvld;
wire [32/2-1:0] sc2mac_wt_b_dst_sel;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_partition_o u_partition_o (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2csb_resp_dst_valid (cacc2csb_resp_dst_valid)
  ,.cacc2csb_resp_dst_pd (cacc2csb_resp_dst_pd[33:0])
  ,.cacc2glb_done_intr_dst_pd (cacc2glb_done_intr_dst_pd[1:0])
  ,.csb2cacc_req_src_pvld (csb2cacc_req_src_pvld)
  ,.csb2cacc_req_src_prdy (csb2cacc_req_src_prdy)
  ,.csb2cacc_req_src_pd (csb2cacc_req_src_pd[62:0])
  ,.cmac_a2csb_resp_src_valid (cmac_a2csb_resp_src_valid)
  ,.cmac_a2csb_resp_src_pd (cmac_a2csb_resp_src_pd[33:0])
  ,.cmac_b2csb_resp_dst_valid (cmac_b2csb_resp_dst_valid)
  ,.cmac_b2csb_resp_dst_pd (cmac_b2csb_resp_dst_pd[33:0])
  ,.csb2cmac_a_req_dst_pvld (csb2cmac_a_req_dst_pvld)
  ,.csb2cmac_a_req_dst_prdy (csb2cmac_a_req_dst_prdy)
  ,.csb2cmac_a_req_dst_pd (csb2cmac_a_req_dst_pd[62:0])
  ,.csb2cmac_b_req_src_pvld (csb2cmac_b_req_src_pvld)
  ,.csb2cmac_b_req_src_prdy (csb2cmac_b_req_src_prdy)
  ,.csb2cmac_b_req_src_pd (csb2cmac_b_req_src_pd[62:0])
  ,.cdma2csb_resp_valid (cdma2csb_resp_valid)
  ,.cdma2csb_resp_pd (cdma2csb_resp_pd[33:0])
  ,.cdma_dat2glb_done_intr_pd (cdma_dat2glb_done_intr_pd[1:0])
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid)
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready)
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd)
  ,.cdma_wt2glb_done_intr_pd (cdma_wt2glb_done_intr_pd[1:0])
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid)
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready)
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd)
  ,.csb2cdma_req_pvld (csb2cdma_req_pvld)
  ,.csb2cdma_req_prdy (csb2cdma_req_prdy)
  ,.csb2cdma_req_pd (csb2cdma_req_pd[62:0])
  ,.csb2csc_req_pvld (csb2csc_req_pvld)
  ,.csb2csc_req_prdy (csb2csc_req_prdy)
  ,.csb2csc_req_pd (csb2csc_req_pd[62:0])
  ,.csb2nvdla_valid (csb2nvdla_valid)
  ,.csb2nvdla_ready (csb2nvdla_ready)
  ,.csb2nvdla_addr (csb2nvdla_addr[15:0])
  ,.csb2nvdla_wdat (csb2nvdla_wdat[31:0])
  ,.csb2nvdla_write (csb2nvdla_write)
  ,.csb2nvdla_nposted (csb2nvdla_nposted)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd[62:0])
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd[62:0])
  ,.csc2csb_resp_valid (csc2csb_resp_valid)
  ,.csc2csb_resp_pd (csc2csb_resp_pd[33:0])
  ,.cvif2noc_axi_ar_arvalid (nvdla_core2cvsram_ar_arvalid)
  ,.cvif2noc_axi_ar_arready (nvdla_core2cvsram_ar_arready)
  ,.cvif2noc_axi_ar_arid (nvdla_core2cvsram_ar_arid[7:0])
  ,.cvif2noc_axi_ar_arlen (nvdla_core2cvsram_ar_arlen[3:0])
  ,.cvif2noc_axi_ar_araddr (nvdla_core2cvsram_ar_araddr)
  ,.cvif2noc_axi_aw_awvalid (nvdla_core2cvsram_aw_awvalid)
  ,.cvif2noc_axi_aw_awready (nvdla_core2cvsram_aw_awready)
  ,.cvif2noc_axi_aw_awid (nvdla_core2cvsram_aw_awid[7:0])
  ,.cvif2noc_axi_aw_awlen (nvdla_core2cvsram_aw_awlen[3:0])
  ,.cvif2noc_axi_aw_awaddr (nvdla_core2cvsram_aw_awaddr)
  ,.cvif2noc_axi_w_wvalid (nvdla_core2cvsram_w_wvalid)
  ,.cvif2noc_axi_w_wready (nvdla_core2cvsram_w_wready)
  ,.cvif2noc_axi_w_wdata (nvdla_core2cvsram_w_wdata)
  ,.cvif2noc_axi_w_wstrb (nvdla_core2cvsram_w_wstrb)
  ,.cvif2noc_axi_w_wlast (nvdla_core2cvsram_w_wlast)
  ,.noc2cvif_axi_b_bvalid (nvdla_core2cvsram_b_bvalid)
  ,.noc2cvif_axi_b_bready (nvdla_core2cvsram_b_bready)
  ,.noc2cvif_axi_b_bid (nvdla_core2cvsram_b_bid[7:0])
  ,.noc2cvif_axi_r_rvalid (nvdla_core2cvsram_r_rvalid)
  ,.noc2cvif_axi_r_rready (nvdla_core2cvsram_r_rready)
  ,.noc2cvif_axi_r_rid (nvdla_core2cvsram_r_rid[7:0])
  ,.noc2cvif_axi_r_rlast (nvdla_core2cvsram_r_rlast)
  ,.noc2cvif_axi_r_rdata (nvdla_core2cvsram_r_rdata)
  ,.cdma_dat2cvif_rd_req_valid (cdma_dat2cvif_rd_req_valid)
  ,.cdma_dat2cvif_rd_req_ready (cdma_dat2cvif_rd_req_ready)
  ,.cdma_dat2cvif_rd_req_pd (cdma_dat2cvif_rd_req_pd)
  ,.cdma_wt2cvif_rd_req_valid (cdma_wt2cvif_rd_req_valid)
  ,.cdma_wt2cvif_rd_req_ready (cdma_wt2cvif_rd_req_ready)
  ,.cdma_wt2cvif_rd_req_pd (cdma_wt2cvif_rd_req_pd)
  ,.cvif2cdma_dat_rd_rsp_valid (cvif2cdma_dat_rd_rsp_valid)
  ,.cvif2cdma_dat_rd_rsp_ready (cvif2cdma_dat_rd_rsp_ready)
  ,.cvif2cdma_dat_rd_rsp_pd (cvif2cdma_dat_rd_rsp_pd)
  ,.cvif2cdma_wt_rd_rsp_valid (cvif2cdma_wt_rd_rsp_valid)
  ,.cvif2cdma_wt_rd_rsp_ready (cvif2cdma_wt_rd_rsp_ready)
  ,.cvif2cdma_wt_rd_rsp_pd (cvif2cdma_wt_rd_rsp_pd)
  ,.sdp_b2cvif_rd_cdt_lat_fifo_pop (sdp_b2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2cvif_rd_req_valid (sdp_b2cvif_rd_req_valid)
  ,.sdp_b2cvif_rd_req_ready (sdp_b2cvif_rd_req_ready)
  ,.sdp_b2cvif_rd_req_pd (sdp_b2cvif_rd_req_pd)
  ,.cvif2sdp_b_rd_rsp_valid (cvif2sdp_b_rd_rsp_valid)
  ,.cvif2sdp_b_rd_rsp_ready (cvif2sdp_b_rd_rsp_ready)
  ,.cvif2sdp_b_rd_rsp_pd (cvif2sdp_b_rd_rsp_pd)
  ,.sdp_e2cvif_rd_cdt_lat_fifo_pop (sdp_e2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2cvif_rd_req_valid (sdp_e2cvif_rd_req_valid)
  ,.sdp_e2cvif_rd_req_ready (sdp_e2cvif_rd_req_ready)
  ,.sdp_e2cvif_rd_req_pd (sdp_e2cvif_rd_req_pd)
  ,.cvif2sdp_e_rd_rsp_valid (cvif2sdp_e_rd_rsp_valid)
  ,.cvif2sdp_e_rd_rsp_ready (cvif2sdp_e_rd_rsp_ready)
  ,.cvif2sdp_e_rd_rsp_pd (cvif2sdp_e_rd_rsp_pd)
  ,.sdp_n2cvif_rd_cdt_lat_fifo_pop (sdp_n2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2cvif_rd_req_valid (sdp_n2cvif_rd_req_valid)
  ,.sdp_n2cvif_rd_req_ready (sdp_n2cvif_rd_req_ready)
  ,.sdp_n2cvif_rd_req_pd (sdp_n2cvif_rd_req_pd)
  ,.cvif2sdp_n_rd_rsp_valid (cvif2sdp_n_rd_rsp_valid)
  ,.cvif2sdp_n_rd_rsp_ready (cvif2sdp_n_rd_rsp_ready)
  ,.cvif2sdp_n_rd_rsp_pd (cvif2sdp_n_rd_rsp_pd)
  ,.sdp2cvif_rd_cdt_lat_fifo_pop (sdp2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp2cvif_rd_req_valid (sdp2cvif_rd_req_valid)
  ,.sdp2cvif_rd_req_ready (sdp2cvif_rd_req_ready)
  ,.sdp2cvif_rd_req_pd (sdp2cvif_rd_req_pd)
  ,.sdp2cvif_wr_req_valid (sdp2cvif_wr_req_valid)
  ,.sdp2cvif_wr_req_ready (sdp2cvif_wr_req_ready)
  ,.sdp2cvif_wr_req_pd (sdp2cvif_wr_req_pd)
  ,.cvif2sdp_rd_rsp_valid (cvif2sdp_rd_rsp_valid)
  ,.cvif2sdp_rd_rsp_ready (cvif2sdp_rd_rsp_ready)
  ,.cvif2sdp_rd_rsp_pd (cvif2sdp_rd_rsp_pd)
  ,.cvif2sdp_wr_rsp_complete (cvif2sdp_wr_rsp_complete)
  ,.mcif2noc_axi_ar_arvalid (nvdla_core2dbb_ar_arvalid)
  ,.mcif2noc_axi_ar_arready (nvdla_core2dbb_ar_arready)
  ,.mcif2noc_axi_ar_arid (nvdla_core2dbb_ar_arid[7:0])
  ,.mcif2noc_axi_ar_arlen (nvdla_core2dbb_ar_arlen[3:0])
  ,.mcif2noc_axi_ar_araddr (nvdla_core2dbb_ar_araddr)
  ,.mcif2noc_axi_aw_awvalid (nvdla_core2dbb_aw_awvalid)
  ,.mcif2noc_axi_aw_awready (nvdla_core2dbb_aw_awready)
  ,.mcif2noc_axi_aw_awid (nvdla_core2dbb_aw_awid[7:0])
  ,.mcif2noc_axi_aw_awlen (nvdla_core2dbb_aw_awlen[3:0])
  ,.mcif2noc_axi_aw_awaddr (nvdla_core2dbb_aw_awaddr)
  ,.mcif2noc_axi_w_wvalid (nvdla_core2dbb_w_wvalid)
  ,.mcif2noc_axi_w_wready (nvdla_core2dbb_w_wready)
  ,.mcif2noc_axi_w_wdata (nvdla_core2dbb_w_wdata)
  ,.mcif2noc_axi_w_wstrb (nvdla_core2dbb_w_wstrb)
  ,.mcif2noc_axi_w_wlast (nvdla_core2dbb_w_wlast)
  ,.noc2mcif_axi_b_bvalid (nvdla_core2dbb_b_bvalid)
  ,.noc2mcif_axi_b_bready (nvdla_core2dbb_b_bready)
  ,.noc2mcif_axi_b_bid (nvdla_core2dbb_b_bid[7:0])
  ,.noc2mcif_axi_r_rvalid (nvdla_core2dbb_r_rvalid)
  ,.noc2mcif_axi_r_rready (nvdla_core2dbb_r_rready)
  ,.noc2mcif_axi_r_rid (nvdla_core2dbb_r_rid[7:0])
  ,.noc2mcif_axi_r_rlast (nvdla_core2dbb_r_rlast)
  ,.noc2mcif_axi_r_rdata (nvdla_core2dbb_r_rdata)
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid)
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready)
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd)
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid)
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready)
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd)
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd)
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd)
  ,.mcif2sdp_e_rd_rsp_valid (mcif2sdp_e_rd_rsp_valid)
  ,.mcif2sdp_e_rd_rsp_ready (mcif2sdp_e_rd_rsp_ready)
  ,.mcif2sdp_e_rd_rsp_pd (mcif2sdp_e_rd_rsp_pd)
  ,.sdp_e2mcif_rd_cdt_lat_fifo_pop (sdp_e2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2mcif_rd_req_valid (sdp_e2mcif_rd_req_valid)
  ,.sdp_e2mcif_rd_req_ready (sdp_e2mcif_rd_req_ready)
  ,.sdp_e2mcif_rd_req_pd (sdp_e2mcif_rd_req_pd)
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd)
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd)
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd)
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd)
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd)
  ,.nvdla2csb_valid (nvdla2csb_valid)
  ,.nvdla2csb_data (nvdla2csb_data[31:0])
  ,.nvdla2csb_wr_complete (nvdla2csb_wr_complete)
  ,.core_intr (dla_intr)
  ,.pwrbus_ram_pd (nvdla_pwrbus_ram_o_pd[31:0])
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd[33:0])
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0])
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd)
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd[33:0])
  ,.nvdla_core_clk (dla_core_clk)
  ,.dla_reset_rstn (dla_reset_rstn)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.nvdla_falcon_clk (dla_csb_clk)
  ,.nvdla_clk_ovr_on (nvdla_clk_ovr_on)
  ,.sc2mac_dat_a_dst_pvld (sc2mac_dat_a_dst_pvld)
  ,.sc2mac_dat_a_dst_mask (sc2mac_dat_a_dst_mask[64 -1:0])
  ,.sc2mac_dat_a_dst_pd (sc2mac_dat_a_dst_pd[8:0])
  ,.sc2mac_dat_a_src_pvld (sc2mac_dat_a_src_pvld)
  ,.sc2mac_dat_a_src_mask (sc2mac_dat_a_src_mask[64 -1:0])
  ,.sc2mac_dat_a_src_pd (sc2mac_dat_a_src_pd[8:0])
  ,.sc2mac_wt_a_dst_pvld (sc2mac_wt_a_dst_pvld)
  ,.sc2mac_wt_a_dst_mask (sc2mac_wt_a_dst_mask[64 -1:0])
  ,.sc2mac_wt_a_dst_sel (sc2mac_wt_a_dst_sel[32/2-1:0])
  ,.sc2mac_wt_a_src_pvld (sc2mac_wt_a_src_pvld)
  ,.sc2mac_wt_a_src_mask (sc2mac_wt_a_src_mask[64 -1:0])
//: my $kk=64 -1;
//: foreach my $i (0..${kk}){
//: print qq(
//: ,.sc2mac_dat_a_dst_data${i} (sc2mac_dat_a_dst_data${i})
//: ,.sc2mac_dat_a_src_data${i} (sc2mac_dat_a_src_data${i})
//: ,.sc2mac_wt_a_dst_data${i} (sc2mac_wt_a_dst_data${i})
//: ,.sc2mac_wt_a_src_data${i} (sc2mac_wt_a_src_data${i})
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_a_dst_data0 (sc2mac_dat_a_dst_data0)
,.sc2mac_dat_a_src_data0 (sc2mac_dat_a_src_data0)
,.sc2mac_wt_a_dst_data0 (sc2mac_wt_a_dst_data0)
,.sc2mac_wt_a_src_data0 (sc2mac_wt_a_src_data0)

,.sc2mac_dat_a_dst_data1 (sc2mac_dat_a_dst_data1)
,.sc2mac_dat_a_src_data1 (sc2mac_dat_a_src_data1)
,.sc2mac_wt_a_dst_data1 (sc2mac_wt_a_dst_data1)
,.sc2mac_wt_a_src_data1 (sc2mac_wt_a_src_data1)

,.sc2mac_dat_a_dst_data2 (sc2mac_dat_a_dst_data2)
,.sc2mac_dat_a_src_data2 (sc2mac_dat_a_src_data2)
,.sc2mac_wt_a_dst_data2 (sc2mac_wt_a_dst_data2)
,.sc2mac_wt_a_src_data2 (sc2mac_wt_a_src_data2)

,.sc2mac_dat_a_dst_data3 (sc2mac_dat_a_dst_data3)
,.sc2mac_dat_a_src_data3 (sc2mac_dat_a_src_data3)
,.sc2mac_wt_a_dst_data3 (sc2mac_wt_a_dst_data3)
,.sc2mac_wt_a_src_data3 (sc2mac_wt_a_src_data3)

,.sc2mac_dat_a_dst_data4 (sc2mac_dat_a_dst_data4)
,.sc2mac_dat_a_src_data4 (sc2mac_dat_a_src_data4)
,.sc2mac_wt_a_dst_data4 (sc2mac_wt_a_dst_data4)
,.sc2mac_wt_a_src_data4 (sc2mac_wt_a_src_data4)

,.sc2mac_dat_a_dst_data5 (sc2mac_dat_a_dst_data5)
,.sc2mac_dat_a_src_data5 (sc2mac_dat_a_src_data5)
,.sc2mac_wt_a_dst_data5 (sc2mac_wt_a_dst_data5)
,.sc2mac_wt_a_src_data5 (sc2mac_wt_a_src_data5)

,.sc2mac_dat_a_dst_data6 (sc2mac_dat_a_dst_data6)
,.sc2mac_dat_a_src_data6 (sc2mac_dat_a_src_data6)
,.sc2mac_wt_a_dst_data6 (sc2mac_wt_a_dst_data6)
,.sc2mac_wt_a_src_data6 (sc2mac_wt_a_src_data6)

,.sc2mac_dat_a_dst_data7 (sc2mac_dat_a_dst_data7)
,.sc2mac_dat_a_src_data7 (sc2mac_dat_a_src_data7)
,.sc2mac_wt_a_dst_data7 (sc2mac_wt_a_dst_data7)
,.sc2mac_wt_a_src_data7 (sc2mac_wt_a_src_data7)

,.sc2mac_dat_a_dst_data8 (sc2mac_dat_a_dst_data8)
,.sc2mac_dat_a_src_data8 (sc2mac_dat_a_src_data8)
,.sc2mac_wt_a_dst_data8 (sc2mac_wt_a_dst_data8)
,.sc2mac_wt_a_src_data8 (sc2mac_wt_a_src_data8)

,.sc2mac_dat_a_dst_data9 (sc2mac_dat_a_dst_data9)
,.sc2mac_dat_a_src_data9 (sc2mac_dat_a_src_data9)
,.sc2mac_wt_a_dst_data9 (sc2mac_wt_a_dst_data9)
,.sc2mac_wt_a_src_data9 (sc2mac_wt_a_src_data9)

,.sc2mac_dat_a_dst_data10 (sc2mac_dat_a_dst_data10)
,.sc2mac_dat_a_src_data10 (sc2mac_dat_a_src_data10)
,.sc2mac_wt_a_dst_data10 (sc2mac_wt_a_dst_data10)
,.sc2mac_wt_a_src_data10 (sc2mac_wt_a_src_data10)

,.sc2mac_dat_a_dst_data11 (sc2mac_dat_a_dst_data11)
,.sc2mac_dat_a_src_data11 (sc2mac_dat_a_src_data11)
,.sc2mac_wt_a_dst_data11 (sc2mac_wt_a_dst_data11)
,.sc2mac_wt_a_src_data11 (sc2mac_wt_a_src_data11)

,.sc2mac_dat_a_dst_data12 (sc2mac_dat_a_dst_data12)
,.sc2mac_dat_a_src_data12 (sc2mac_dat_a_src_data12)
,.sc2mac_wt_a_dst_data12 (sc2mac_wt_a_dst_data12)
,.sc2mac_wt_a_src_data12 (sc2mac_wt_a_src_data12)

,.sc2mac_dat_a_dst_data13 (sc2mac_dat_a_dst_data13)
,.sc2mac_dat_a_src_data13 (sc2mac_dat_a_src_data13)
,.sc2mac_wt_a_dst_data13 (sc2mac_wt_a_dst_data13)
,.sc2mac_wt_a_src_data13 (sc2mac_wt_a_src_data13)

,.sc2mac_dat_a_dst_data14 (sc2mac_dat_a_dst_data14)
,.sc2mac_dat_a_src_data14 (sc2mac_dat_a_src_data14)
,.sc2mac_wt_a_dst_data14 (sc2mac_wt_a_dst_data14)
,.sc2mac_wt_a_src_data14 (sc2mac_wt_a_src_data14)

,.sc2mac_dat_a_dst_data15 (sc2mac_dat_a_dst_data15)
,.sc2mac_dat_a_src_data15 (sc2mac_dat_a_src_data15)
,.sc2mac_wt_a_dst_data15 (sc2mac_wt_a_dst_data15)
,.sc2mac_wt_a_src_data15 (sc2mac_wt_a_src_data15)

,.sc2mac_dat_a_dst_data16 (sc2mac_dat_a_dst_data16)
,.sc2mac_dat_a_src_data16 (sc2mac_dat_a_src_data16)
,.sc2mac_wt_a_dst_data16 (sc2mac_wt_a_dst_data16)
,.sc2mac_wt_a_src_data16 (sc2mac_wt_a_src_data16)

,.sc2mac_dat_a_dst_data17 (sc2mac_dat_a_dst_data17)
,.sc2mac_dat_a_src_data17 (sc2mac_dat_a_src_data17)
,.sc2mac_wt_a_dst_data17 (sc2mac_wt_a_dst_data17)
,.sc2mac_wt_a_src_data17 (sc2mac_wt_a_src_data17)

,.sc2mac_dat_a_dst_data18 (sc2mac_dat_a_dst_data18)
,.sc2mac_dat_a_src_data18 (sc2mac_dat_a_src_data18)
,.sc2mac_wt_a_dst_data18 (sc2mac_wt_a_dst_data18)
,.sc2mac_wt_a_src_data18 (sc2mac_wt_a_src_data18)

,.sc2mac_dat_a_dst_data19 (sc2mac_dat_a_dst_data19)
,.sc2mac_dat_a_src_data19 (sc2mac_dat_a_src_data19)
,.sc2mac_wt_a_dst_data19 (sc2mac_wt_a_dst_data19)
,.sc2mac_wt_a_src_data19 (sc2mac_wt_a_src_data19)

,.sc2mac_dat_a_dst_data20 (sc2mac_dat_a_dst_data20)
,.sc2mac_dat_a_src_data20 (sc2mac_dat_a_src_data20)
,.sc2mac_wt_a_dst_data20 (sc2mac_wt_a_dst_data20)
,.sc2mac_wt_a_src_data20 (sc2mac_wt_a_src_data20)

,.sc2mac_dat_a_dst_data21 (sc2mac_dat_a_dst_data21)
,.sc2mac_dat_a_src_data21 (sc2mac_dat_a_src_data21)
,.sc2mac_wt_a_dst_data21 (sc2mac_wt_a_dst_data21)
,.sc2mac_wt_a_src_data21 (sc2mac_wt_a_src_data21)

,.sc2mac_dat_a_dst_data22 (sc2mac_dat_a_dst_data22)
,.sc2mac_dat_a_src_data22 (sc2mac_dat_a_src_data22)
,.sc2mac_wt_a_dst_data22 (sc2mac_wt_a_dst_data22)
,.sc2mac_wt_a_src_data22 (sc2mac_wt_a_src_data22)

,.sc2mac_dat_a_dst_data23 (sc2mac_dat_a_dst_data23)
,.sc2mac_dat_a_src_data23 (sc2mac_dat_a_src_data23)
,.sc2mac_wt_a_dst_data23 (sc2mac_wt_a_dst_data23)
,.sc2mac_wt_a_src_data23 (sc2mac_wt_a_src_data23)

,.sc2mac_dat_a_dst_data24 (sc2mac_dat_a_dst_data24)
,.sc2mac_dat_a_src_data24 (sc2mac_dat_a_src_data24)
,.sc2mac_wt_a_dst_data24 (sc2mac_wt_a_dst_data24)
,.sc2mac_wt_a_src_data24 (sc2mac_wt_a_src_data24)

,.sc2mac_dat_a_dst_data25 (sc2mac_dat_a_dst_data25)
,.sc2mac_dat_a_src_data25 (sc2mac_dat_a_src_data25)
,.sc2mac_wt_a_dst_data25 (sc2mac_wt_a_dst_data25)
,.sc2mac_wt_a_src_data25 (sc2mac_wt_a_src_data25)

,.sc2mac_dat_a_dst_data26 (sc2mac_dat_a_dst_data26)
,.sc2mac_dat_a_src_data26 (sc2mac_dat_a_src_data26)
,.sc2mac_wt_a_dst_data26 (sc2mac_wt_a_dst_data26)
,.sc2mac_wt_a_src_data26 (sc2mac_wt_a_src_data26)

,.sc2mac_dat_a_dst_data27 (sc2mac_dat_a_dst_data27)
,.sc2mac_dat_a_src_data27 (sc2mac_dat_a_src_data27)
,.sc2mac_wt_a_dst_data27 (sc2mac_wt_a_dst_data27)
,.sc2mac_wt_a_src_data27 (sc2mac_wt_a_src_data27)

,.sc2mac_dat_a_dst_data28 (sc2mac_dat_a_dst_data28)
,.sc2mac_dat_a_src_data28 (sc2mac_dat_a_src_data28)
,.sc2mac_wt_a_dst_data28 (sc2mac_wt_a_dst_data28)
,.sc2mac_wt_a_src_data28 (sc2mac_wt_a_src_data28)

,.sc2mac_dat_a_dst_data29 (sc2mac_dat_a_dst_data29)
,.sc2mac_dat_a_src_data29 (sc2mac_dat_a_src_data29)
,.sc2mac_wt_a_dst_data29 (sc2mac_wt_a_dst_data29)
,.sc2mac_wt_a_src_data29 (sc2mac_wt_a_src_data29)

,.sc2mac_dat_a_dst_data30 (sc2mac_dat_a_dst_data30)
,.sc2mac_dat_a_src_data30 (sc2mac_dat_a_src_data30)
,.sc2mac_wt_a_dst_data30 (sc2mac_wt_a_dst_data30)
,.sc2mac_wt_a_src_data30 (sc2mac_wt_a_src_data30)

,.sc2mac_dat_a_dst_data31 (sc2mac_dat_a_dst_data31)
,.sc2mac_dat_a_src_data31 (sc2mac_dat_a_src_data31)
,.sc2mac_wt_a_dst_data31 (sc2mac_wt_a_dst_data31)
,.sc2mac_wt_a_src_data31 (sc2mac_wt_a_src_data31)

,.sc2mac_dat_a_dst_data32 (sc2mac_dat_a_dst_data32)
,.sc2mac_dat_a_src_data32 (sc2mac_dat_a_src_data32)
,.sc2mac_wt_a_dst_data32 (sc2mac_wt_a_dst_data32)
,.sc2mac_wt_a_src_data32 (sc2mac_wt_a_src_data32)

,.sc2mac_dat_a_dst_data33 (sc2mac_dat_a_dst_data33)
,.sc2mac_dat_a_src_data33 (sc2mac_dat_a_src_data33)
,.sc2mac_wt_a_dst_data33 (sc2mac_wt_a_dst_data33)
,.sc2mac_wt_a_src_data33 (sc2mac_wt_a_src_data33)

,.sc2mac_dat_a_dst_data34 (sc2mac_dat_a_dst_data34)
,.sc2mac_dat_a_src_data34 (sc2mac_dat_a_src_data34)
,.sc2mac_wt_a_dst_data34 (sc2mac_wt_a_dst_data34)
,.sc2mac_wt_a_src_data34 (sc2mac_wt_a_src_data34)

,.sc2mac_dat_a_dst_data35 (sc2mac_dat_a_dst_data35)
,.sc2mac_dat_a_src_data35 (sc2mac_dat_a_src_data35)
,.sc2mac_wt_a_dst_data35 (sc2mac_wt_a_dst_data35)
,.sc2mac_wt_a_src_data35 (sc2mac_wt_a_src_data35)

,.sc2mac_dat_a_dst_data36 (sc2mac_dat_a_dst_data36)
,.sc2mac_dat_a_src_data36 (sc2mac_dat_a_src_data36)
,.sc2mac_wt_a_dst_data36 (sc2mac_wt_a_dst_data36)
,.sc2mac_wt_a_src_data36 (sc2mac_wt_a_src_data36)

,.sc2mac_dat_a_dst_data37 (sc2mac_dat_a_dst_data37)
,.sc2mac_dat_a_src_data37 (sc2mac_dat_a_src_data37)
,.sc2mac_wt_a_dst_data37 (sc2mac_wt_a_dst_data37)
,.sc2mac_wt_a_src_data37 (sc2mac_wt_a_src_data37)

,.sc2mac_dat_a_dst_data38 (sc2mac_dat_a_dst_data38)
,.sc2mac_dat_a_src_data38 (sc2mac_dat_a_src_data38)
,.sc2mac_wt_a_dst_data38 (sc2mac_wt_a_dst_data38)
,.sc2mac_wt_a_src_data38 (sc2mac_wt_a_src_data38)

,.sc2mac_dat_a_dst_data39 (sc2mac_dat_a_dst_data39)
,.sc2mac_dat_a_src_data39 (sc2mac_dat_a_src_data39)
,.sc2mac_wt_a_dst_data39 (sc2mac_wt_a_dst_data39)
,.sc2mac_wt_a_src_data39 (sc2mac_wt_a_src_data39)

,.sc2mac_dat_a_dst_data40 (sc2mac_dat_a_dst_data40)
,.sc2mac_dat_a_src_data40 (sc2mac_dat_a_src_data40)
,.sc2mac_wt_a_dst_data40 (sc2mac_wt_a_dst_data40)
,.sc2mac_wt_a_src_data40 (sc2mac_wt_a_src_data40)

,.sc2mac_dat_a_dst_data41 (sc2mac_dat_a_dst_data41)
,.sc2mac_dat_a_src_data41 (sc2mac_dat_a_src_data41)
,.sc2mac_wt_a_dst_data41 (sc2mac_wt_a_dst_data41)
,.sc2mac_wt_a_src_data41 (sc2mac_wt_a_src_data41)

,.sc2mac_dat_a_dst_data42 (sc2mac_dat_a_dst_data42)
,.sc2mac_dat_a_src_data42 (sc2mac_dat_a_src_data42)
,.sc2mac_wt_a_dst_data42 (sc2mac_wt_a_dst_data42)
,.sc2mac_wt_a_src_data42 (sc2mac_wt_a_src_data42)

,.sc2mac_dat_a_dst_data43 (sc2mac_dat_a_dst_data43)
,.sc2mac_dat_a_src_data43 (sc2mac_dat_a_src_data43)
,.sc2mac_wt_a_dst_data43 (sc2mac_wt_a_dst_data43)
,.sc2mac_wt_a_src_data43 (sc2mac_wt_a_src_data43)

,.sc2mac_dat_a_dst_data44 (sc2mac_dat_a_dst_data44)
,.sc2mac_dat_a_src_data44 (sc2mac_dat_a_src_data44)
,.sc2mac_wt_a_dst_data44 (sc2mac_wt_a_dst_data44)
,.sc2mac_wt_a_src_data44 (sc2mac_wt_a_src_data44)

,.sc2mac_dat_a_dst_data45 (sc2mac_dat_a_dst_data45)
,.sc2mac_dat_a_src_data45 (sc2mac_dat_a_src_data45)
,.sc2mac_wt_a_dst_data45 (sc2mac_wt_a_dst_data45)
,.sc2mac_wt_a_src_data45 (sc2mac_wt_a_src_data45)

,.sc2mac_dat_a_dst_data46 (sc2mac_dat_a_dst_data46)
,.sc2mac_dat_a_src_data46 (sc2mac_dat_a_src_data46)
,.sc2mac_wt_a_dst_data46 (sc2mac_wt_a_dst_data46)
,.sc2mac_wt_a_src_data46 (sc2mac_wt_a_src_data46)

,.sc2mac_dat_a_dst_data47 (sc2mac_dat_a_dst_data47)
,.sc2mac_dat_a_src_data47 (sc2mac_dat_a_src_data47)
,.sc2mac_wt_a_dst_data47 (sc2mac_wt_a_dst_data47)
,.sc2mac_wt_a_src_data47 (sc2mac_wt_a_src_data47)

,.sc2mac_dat_a_dst_data48 (sc2mac_dat_a_dst_data48)
,.sc2mac_dat_a_src_data48 (sc2mac_dat_a_src_data48)
,.sc2mac_wt_a_dst_data48 (sc2mac_wt_a_dst_data48)
,.sc2mac_wt_a_src_data48 (sc2mac_wt_a_src_data48)

,.sc2mac_dat_a_dst_data49 (sc2mac_dat_a_dst_data49)
,.sc2mac_dat_a_src_data49 (sc2mac_dat_a_src_data49)
,.sc2mac_wt_a_dst_data49 (sc2mac_wt_a_dst_data49)
,.sc2mac_wt_a_src_data49 (sc2mac_wt_a_src_data49)

,.sc2mac_dat_a_dst_data50 (sc2mac_dat_a_dst_data50)
,.sc2mac_dat_a_src_data50 (sc2mac_dat_a_src_data50)
,.sc2mac_wt_a_dst_data50 (sc2mac_wt_a_dst_data50)
,.sc2mac_wt_a_src_data50 (sc2mac_wt_a_src_data50)

,.sc2mac_dat_a_dst_data51 (sc2mac_dat_a_dst_data51)
,.sc2mac_dat_a_src_data51 (sc2mac_dat_a_src_data51)
,.sc2mac_wt_a_dst_data51 (sc2mac_wt_a_dst_data51)
,.sc2mac_wt_a_src_data51 (sc2mac_wt_a_src_data51)

,.sc2mac_dat_a_dst_data52 (sc2mac_dat_a_dst_data52)
,.sc2mac_dat_a_src_data52 (sc2mac_dat_a_src_data52)
,.sc2mac_wt_a_dst_data52 (sc2mac_wt_a_dst_data52)
,.sc2mac_wt_a_src_data52 (sc2mac_wt_a_src_data52)

,.sc2mac_dat_a_dst_data53 (sc2mac_dat_a_dst_data53)
,.sc2mac_dat_a_src_data53 (sc2mac_dat_a_src_data53)
,.sc2mac_wt_a_dst_data53 (sc2mac_wt_a_dst_data53)
,.sc2mac_wt_a_src_data53 (sc2mac_wt_a_src_data53)

,.sc2mac_dat_a_dst_data54 (sc2mac_dat_a_dst_data54)
,.sc2mac_dat_a_src_data54 (sc2mac_dat_a_src_data54)
,.sc2mac_wt_a_dst_data54 (sc2mac_wt_a_dst_data54)
,.sc2mac_wt_a_src_data54 (sc2mac_wt_a_src_data54)

,.sc2mac_dat_a_dst_data55 (sc2mac_dat_a_dst_data55)
,.sc2mac_dat_a_src_data55 (sc2mac_dat_a_src_data55)
,.sc2mac_wt_a_dst_data55 (sc2mac_wt_a_dst_data55)
,.sc2mac_wt_a_src_data55 (sc2mac_wt_a_src_data55)

,.sc2mac_dat_a_dst_data56 (sc2mac_dat_a_dst_data56)
,.sc2mac_dat_a_src_data56 (sc2mac_dat_a_src_data56)
,.sc2mac_wt_a_dst_data56 (sc2mac_wt_a_dst_data56)
,.sc2mac_wt_a_src_data56 (sc2mac_wt_a_src_data56)

,.sc2mac_dat_a_dst_data57 (sc2mac_dat_a_dst_data57)
,.sc2mac_dat_a_src_data57 (sc2mac_dat_a_src_data57)
,.sc2mac_wt_a_dst_data57 (sc2mac_wt_a_dst_data57)
,.sc2mac_wt_a_src_data57 (sc2mac_wt_a_src_data57)

,.sc2mac_dat_a_dst_data58 (sc2mac_dat_a_dst_data58)
,.sc2mac_dat_a_src_data58 (sc2mac_dat_a_src_data58)
,.sc2mac_wt_a_dst_data58 (sc2mac_wt_a_dst_data58)
,.sc2mac_wt_a_src_data58 (sc2mac_wt_a_src_data58)

,.sc2mac_dat_a_dst_data59 (sc2mac_dat_a_dst_data59)
,.sc2mac_dat_a_src_data59 (sc2mac_dat_a_src_data59)
,.sc2mac_wt_a_dst_data59 (sc2mac_wt_a_dst_data59)
,.sc2mac_wt_a_src_data59 (sc2mac_wt_a_src_data59)

,.sc2mac_dat_a_dst_data60 (sc2mac_dat_a_dst_data60)
,.sc2mac_dat_a_src_data60 (sc2mac_dat_a_src_data60)
,.sc2mac_wt_a_dst_data60 (sc2mac_wt_a_dst_data60)
,.sc2mac_wt_a_src_data60 (sc2mac_wt_a_src_data60)

,.sc2mac_dat_a_dst_data61 (sc2mac_dat_a_dst_data61)
,.sc2mac_dat_a_src_data61 (sc2mac_dat_a_src_data61)
,.sc2mac_wt_a_dst_data61 (sc2mac_wt_a_dst_data61)
,.sc2mac_wt_a_src_data61 (sc2mac_wt_a_src_data61)

,.sc2mac_dat_a_dst_data62 (sc2mac_dat_a_dst_data62)
,.sc2mac_dat_a_src_data62 (sc2mac_dat_a_src_data62)
,.sc2mac_wt_a_dst_data62 (sc2mac_wt_a_dst_data62)
,.sc2mac_wt_a_src_data62 (sc2mac_wt_a_src_data62)

,.sc2mac_dat_a_dst_data63 (sc2mac_dat_a_dst_data63)
,.sc2mac_dat_a_src_data63 (sc2mac_dat_a_src_data63)
,.sc2mac_wt_a_dst_data63 (sc2mac_wt_a_dst_data63)
,.sc2mac_wt_a_src_data63 (sc2mac_wt_a_src_data63)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_a_src_sel (sc2mac_wt_a_src_sel[32/2-1:0])
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition C //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_partition_c u_partition_c (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.accu2sc_credit_vld (accu2sc_credit_vld)
  ,.accu2sc_credit_size (accu2sc_credit_size[2:0])
  ,.cacc2csb_resp_dst_valid (cacc2csb_resp_dst_valid)
  ,.cacc2csb_resp_dst_pd (cacc2csb_resp_dst_pd[33:0])
  ,.cacc2csb_resp_src_valid (cacc2csb_resp_src_valid)
  ,.cacc2csb_resp_src_pd (cacc2csb_resp_src_pd[33:0])
  ,.cacc2glb_done_intr_dst_pd (cacc2glb_done_intr_dst_pd[1:0])
  ,.cacc2glb_done_intr_src_pd (cacc2glb_done_intr_src_pd[1:0])
  ,.cmac_b2csb_resp_dst_valid (cmac_b2csb_resp_dst_valid)
  ,.cmac_b2csb_resp_dst_pd (cmac_b2csb_resp_dst_pd[33:0])
  ,.cmac_b2csb_resp_src_valid (cmac_b2csb_resp_src_valid)
  ,.cmac_b2csb_resp_src_pd (cmac_b2csb_resp_src_pd[33:0])
  ,.csb2cacc_req_dst_pvld (csb2cacc_req_dst_pvld)
  ,.csb2cacc_req_dst_prdy (csb2cacc_req_dst_prdy)
  ,.csb2cacc_req_dst_pd (csb2cacc_req_dst_pd[62:0])
  ,.csb2cacc_req_src_pvld (csb2cacc_req_src_pvld)
  ,.csb2cacc_req_src_prdy (csb2cacc_req_src_prdy)
  ,.csb2cacc_req_src_pd (csb2cacc_req_src_pd[62:0])
  ,.csb2cmac_b_req_dst_pvld (csb2cmac_b_req_dst_pvld)
  ,.csb2cmac_b_req_dst_prdy (csb2cmac_b_req_dst_prdy)
  ,.csb2cmac_b_req_dst_pd (csb2cmac_b_req_dst_pd[62:0])
  ,.csb2cmac_b_req_src_pvld (csb2cmac_b_req_src_pvld)
  ,.csb2cmac_b_req_src_prdy (csb2cmac_b_req_src_prdy)
  ,.csb2cmac_b_req_src_pd (csb2cmac_b_req_src_pd[62:0])
  ,.cdma2csb_resp_valid (cdma2csb_resp_valid)
  ,.cdma2csb_resp_pd (cdma2csb_resp_pd[33:0])
  ,.cdma_dat2glb_done_intr_pd (cdma_dat2glb_done_intr_pd[1:0])
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid)
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready)
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd)
  ,.cdma_dat2cvif_rd_req_valid (cdma_dat2cvif_rd_req_valid)
  ,.cdma_dat2cvif_rd_req_ready (cdma_dat2cvif_rd_req_ready)
  ,.cdma_dat2cvif_rd_req_pd (cdma_dat2cvif_rd_req_pd)
  ,.cdma_wt2cvif_rd_req_valid (cdma_wt2cvif_rd_req_valid)
  ,.cdma_wt2cvif_rd_req_ready (cdma_wt2cvif_rd_req_ready)
  ,.cdma_wt2cvif_rd_req_pd (cdma_wt2cvif_rd_req_pd)
  ,.cvif2cdma_dat_rd_rsp_valid (cvif2cdma_dat_rd_rsp_valid)
  ,.cvif2cdma_dat_rd_rsp_ready (cvif2cdma_dat_rd_rsp_ready)
  ,.cvif2cdma_dat_rd_rsp_pd (cvif2cdma_dat_rd_rsp_pd)
  ,.cvif2cdma_wt_rd_rsp_valid (cvif2cdma_wt_rd_rsp_valid)
  ,.cvif2cdma_wt_rd_rsp_ready (cvif2cdma_wt_rd_rsp_ready)
  ,.cvif2cdma_wt_rd_rsp_pd (cvif2cdma_wt_rd_rsp_pd)
  ,.cdma_wt2glb_done_intr_pd (cdma_wt2glb_done_intr_pd[1:0])
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid)
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready)
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd)
  ,.csb2cdma_req_pvld (csb2cdma_req_pvld)
  ,.csb2cdma_req_prdy (csb2cdma_req_prdy)
  ,.csb2cdma_req_pd (csb2cdma_req_pd[62:0])
  ,.csb2csc_req_pvld (csb2csc_req_pvld)
  ,.csb2csc_req_prdy (csb2csc_req_prdy)
  ,.csb2csc_req_pd (csb2csc_req_pd[62:0])
  ,.csc2csb_resp_valid (csc2csb_resp_valid)
  ,.csc2csb_resp_pd (csc2csb_resp_pd[33:0])
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid)
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready)
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd)
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid)
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready)
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd)
  ,.pwrbus_ram_pd (nvdla_pwrbus_ram_c_pd[31:0])
  ,.sc2mac_dat_a_src_pvld (sc2mac_dat_a_src_pvld)
  ,.sc2mac_dat_a_src_mask (sc2mac_dat_a_src_mask[64 -1:0])
//: my $kk=64 -1;
//: foreach my $i (0..${kk}){
//: print qq(
//: ,.sc2mac_dat_a_src_data${i} (sc2mac_dat_a_src_data${i})
//: ,.sc2mac_dat_b_dst_data${i} (sc2mac_dat_b_dst_data${i})
//: ,.sc2mac_wt_a_src_data${i} (sc2mac_wt_a_src_data${i})
//: ,.sc2mac_wt_b_dst_data${i} (sc2mac_wt_b_dst_data${i})
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_a_src_data0 (sc2mac_dat_a_src_data0)
,.sc2mac_dat_b_dst_data0 (sc2mac_dat_b_dst_data0)
,.sc2mac_wt_a_src_data0 (sc2mac_wt_a_src_data0)
,.sc2mac_wt_b_dst_data0 (sc2mac_wt_b_dst_data0)

,.sc2mac_dat_a_src_data1 (sc2mac_dat_a_src_data1)
,.sc2mac_dat_b_dst_data1 (sc2mac_dat_b_dst_data1)
,.sc2mac_wt_a_src_data1 (sc2mac_wt_a_src_data1)
,.sc2mac_wt_b_dst_data1 (sc2mac_wt_b_dst_data1)

,.sc2mac_dat_a_src_data2 (sc2mac_dat_a_src_data2)
,.sc2mac_dat_b_dst_data2 (sc2mac_dat_b_dst_data2)
,.sc2mac_wt_a_src_data2 (sc2mac_wt_a_src_data2)
,.sc2mac_wt_b_dst_data2 (sc2mac_wt_b_dst_data2)

,.sc2mac_dat_a_src_data3 (sc2mac_dat_a_src_data3)
,.sc2mac_dat_b_dst_data3 (sc2mac_dat_b_dst_data3)
,.sc2mac_wt_a_src_data3 (sc2mac_wt_a_src_data3)
,.sc2mac_wt_b_dst_data3 (sc2mac_wt_b_dst_data3)

,.sc2mac_dat_a_src_data4 (sc2mac_dat_a_src_data4)
,.sc2mac_dat_b_dst_data4 (sc2mac_dat_b_dst_data4)
,.sc2mac_wt_a_src_data4 (sc2mac_wt_a_src_data4)
,.sc2mac_wt_b_dst_data4 (sc2mac_wt_b_dst_data4)

,.sc2mac_dat_a_src_data5 (sc2mac_dat_a_src_data5)
,.sc2mac_dat_b_dst_data5 (sc2mac_dat_b_dst_data5)
,.sc2mac_wt_a_src_data5 (sc2mac_wt_a_src_data5)
,.sc2mac_wt_b_dst_data5 (sc2mac_wt_b_dst_data5)

,.sc2mac_dat_a_src_data6 (sc2mac_dat_a_src_data6)
,.sc2mac_dat_b_dst_data6 (sc2mac_dat_b_dst_data6)
,.sc2mac_wt_a_src_data6 (sc2mac_wt_a_src_data6)
,.sc2mac_wt_b_dst_data6 (sc2mac_wt_b_dst_data6)

,.sc2mac_dat_a_src_data7 (sc2mac_dat_a_src_data7)
,.sc2mac_dat_b_dst_data7 (sc2mac_dat_b_dst_data7)
,.sc2mac_wt_a_src_data7 (sc2mac_wt_a_src_data7)
,.sc2mac_wt_b_dst_data7 (sc2mac_wt_b_dst_data7)

,.sc2mac_dat_a_src_data8 (sc2mac_dat_a_src_data8)
,.sc2mac_dat_b_dst_data8 (sc2mac_dat_b_dst_data8)
,.sc2mac_wt_a_src_data8 (sc2mac_wt_a_src_data8)
,.sc2mac_wt_b_dst_data8 (sc2mac_wt_b_dst_data8)

,.sc2mac_dat_a_src_data9 (sc2mac_dat_a_src_data9)
,.sc2mac_dat_b_dst_data9 (sc2mac_dat_b_dst_data9)
,.sc2mac_wt_a_src_data9 (sc2mac_wt_a_src_data9)
,.sc2mac_wt_b_dst_data9 (sc2mac_wt_b_dst_data9)

,.sc2mac_dat_a_src_data10 (sc2mac_dat_a_src_data10)
,.sc2mac_dat_b_dst_data10 (sc2mac_dat_b_dst_data10)
,.sc2mac_wt_a_src_data10 (sc2mac_wt_a_src_data10)
,.sc2mac_wt_b_dst_data10 (sc2mac_wt_b_dst_data10)

,.sc2mac_dat_a_src_data11 (sc2mac_dat_a_src_data11)
,.sc2mac_dat_b_dst_data11 (sc2mac_dat_b_dst_data11)
,.sc2mac_wt_a_src_data11 (sc2mac_wt_a_src_data11)
,.sc2mac_wt_b_dst_data11 (sc2mac_wt_b_dst_data11)

,.sc2mac_dat_a_src_data12 (sc2mac_dat_a_src_data12)
,.sc2mac_dat_b_dst_data12 (sc2mac_dat_b_dst_data12)
,.sc2mac_wt_a_src_data12 (sc2mac_wt_a_src_data12)
,.sc2mac_wt_b_dst_data12 (sc2mac_wt_b_dst_data12)

,.sc2mac_dat_a_src_data13 (sc2mac_dat_a_src_data13)
,.sc2mac_dat_b_dst_data13 (sc2mac_dat_b_dst_data13)
,.sc2mac_wt_a_src_data13 (sc2mac_wt_a_src_data13)
,.sc2mac_wt_b_dst_data13 (sc2mac_wt_b_dst_data13)

,.sc2mac_dat_a_src_data14 (sc2mac_dat_a_src_data14)
,.sc2mac_dat_b_dst_data14 (sc2mac_dat_b_dst_data14)
,.sc2mac_wt_a_src_data14 (sc2mac_wt_a_src_data14)
,.sc2mac_wt_b_dst_data14 (sc2mac_wt_b_dst_data14)

,.sc2mac_dat_a_src_data15 (sc2mac_dat_a_src_data15)
,.sc2mac_dat_b_dst_data15 (sc2mac_dat_b_dst_data15)
,.sc2mac_wt_a_src_data15 (sc2mac_wt_a_src_data15)
,.sc2mac_wt_b_dst_data15 (sc2mac_wt_b_dst_data15)

,.sc2mac_dat_a_src_data16 (sc2mac_dat_a_src_data16)
,.sc2mac_dat_b_dst_data16 (sc2mac_dat_b_dst_data16)
,.sc2mac_wt_a_src_data16 (sc2mac_wt_a_src_data16)
,.sc2mac_wt_b_dst_data16 (sc2mac_wt_b_dst_data16)

,.sc2mac_dat_a_src_data17 (sc2mac_dat_a_src_data17)
,.sc2mac_dat_b_dst_data17 (sc2mac_dat_b_dst_data17)
,.sc2mac_wt_a_src_data17 (sc2mac_wt_a_src_data17)
,.sc2mac_wt_b_dst_data17 (sc2mac_wt_b_dst_data17)

,.sc2mac_dat_a_src_data18 (sc2mac_dat_a_src_data18)
,.sc2mac_dat_b_dst_data18 (sc2mac_dat_b_dst_data18)
,.sc2mac_wt_a_src_data18 (sc2mac_wt_a_src_data18)
,.sc2mac_wt_b_dst_data18 (sc2mac_wt_b_dst_data18)

,.sc2mac_dat_a_src_data19 (sc2mac_dat_a_src_data19)
,.sc2mac_dat_b_dst_data19 (sc2mac_dat_b_dst_data19)
,.sc2mac_wt_a_src_data19 (sc2mac_wt_a_src_data19)
,.sc2mac_wt_b_dst_data19 (sc2mac_wt_b_dst_data19)

,.sc2mac_dat_a_src_data20 (sc2mac_dat_a_src_data20)
,.sc2mac_dat_b_dst_data20 (sc2mac_dat_b_dst_data20)
,.sc2mac_wt_a_src_data20 (sc2mac_wt_a_src_data20)
,.sc2mac_wt_b_dst_data20 (sc2mac_wt_b_dst_data20)

,.sc2mac_dat_a_src_data21 (sc2mac_dat_a_src_data21)
,.sc2mac_dat_b_dst_data21 (sc2mac_dat_b_dst_data21)
,.sc2mac_wt_a_src_data21 (sc2mac_wt_a_src_data21)
,.sc2mac_wt_b_dst_data21 (sc2mac_wt_b_dst_data21)

,.sc2mac_dat_a_src_data22 (sc2mac_dat_a_src_data22)
,.sc2mac_dat_b_dst_data22 (sc2mac_dat_b_dst_data22)
,.sc2mac_wt_a_src_data22 (sc2mac_wt_a_src_data22)
,.sc2mac_wt_b_dst_data22 (sc2mac_wt_b_dst_data22)

,.sc2mac_dat_a_src_data23 (sc2mac_dat_a_src_data23)
,.sc2mac_dat_b_dst_data23 (sc2mac_dat_b_dst_data23)
,.sc2mac_wt_a_src_data23 (sc2mac_wt_a_src_data23)
,.sc2mac_wt_b_dst_data23 (sc2mac_wt_b_dst_data23)

,.sc2mac_dat_a_src_data24 (sc2mac_dat_a_src_data24)
,.sc2mac_dat_b_dst_data24 (sc2mac_dat_b_dst_data24)
,.sc2mac_wt_a_src_data24 (sc2mac_wt_a_src_data24)
,.sc2mac_wt_b_dst_data24 (sc2mac_wt_b_dst_data24)

,.sc2mac_dat_a_src_data25 (sc2mac_dat_a_src_data25)
,.sc2mac_dat_b_dst_data25 (sc2mac_dat_b_dst_data25)
,.sc2mac_wt_a_src_data25 (sc2mac_wt_a_src_data25)
,.sc2mac_wt_b_dst_data25 (sc2mac_wt_b_dst_data25)

,.sc2mac_dat_a_src_data26 (sc2mac_dat_a_src_data26)
,.sc2mac_dat_b_dst_data26 (sc2mac_dat_b_dst_data26)
,.sc2mac_wt_a_src_data26 (sc2mac_wt_a_src_data26)
,.sc2mac_wt_b_dst_data26 (sc2mac_wt_b_dst_data26)

,.sc2mac_dat_a_src_data27 (sc2mac_dat_a_src_data27)
,.sc2mac_dat_b_dst_data27 (sc2mac_dat_b_dst_data27)
,.sc2mac_wt_a_src_data27 (sc2mac_wt_a_src_data27)
,.sc2mac_wt_b_dst_data27 (sc2mac_wt_b_dst_data27)

,.sc2mac_dat_a_src_data28 (sc2mac_dat_a_src_data28)
,.sc2mac_dat_b_dst_data28 (sc2mac_dat_b_dst_data28)
,.sc2mac_wt_a_src_data28 (sc2mac_wt_a_src_data28)
,.sc2mac_wt_b_dst_data28 (sc2mac_wt_b_dst_data28)

,.sc2mac_dat_a_src_data29 (sc2mac_dat_a_src_data29)
,.sc2mac_dat_b_dst_data29 (sc2mac_dat_b_dst_data29)
,.sc2mac_wt_a_src_data29 (sc2mac_wt_a_src_data29)
,.sc2mac_wt_b_dst_data29 (sc2mac_wt_b_dst_data29)

,.sc2mac_dat_a_src_data30 (sc2mac_dat_a_src_data30)
,.sc2mac_dat_b_dst_data30 (sc2mac_dat_b_dst_data30)
,.sc2mac_wt_a_src_data30 (sc2mac_wt_a_src_data30)
,.sc2mac_wt_b_dst_data30 (sc2mac_wt_b_dst_data30)

,.sc2mac_dat_a_src_data31 (sc2mac_dat_a_src_data31)
,.sc2mac_dat_b_dst_data31 (sc2mac_dat_b_dst_data31)
,.sc2mac_wt_a_src_data31 (sc2mac_wt_a_src_data31)
,.sc2mac_wt_b_dst_data31 (sc2mac_wt_b_dst_data31)

,.sc2mac_dat_a_src_data32 (sc2mac_dat_a_src_data32)
,.sc2mac_dat_b_dst_data32 (sc2mac_dat_b_dst_data32)
,.sc2mac_wt_a_src_data32 (sc2mac_wt_a_src_data32)
,.sc2mac_wt_b_dst_data32 (sc2mac_wt_b_dst_data32)

,.sc2mac_dat_a_src_data33 (sc2mac_dat_a_src_data33)
,.sc2mac_dat_b_dst_data33 (sc2mac_dat_b_dst_data33)
,.sc2mac_wt_a_src_data33 (sc2mac_wt_a_src_data33)
,.sc2mac_wt_b_dst_data33 (sc2mac_wt_b_dst_data33)

,.sc2mac_dat_a_src_data34 (sc2mac_dat_a_src_data34)
,.sc2mac_dat_b_dst_data34 (sc2mac_dat_b_dst_data34)
,.sc2mac_wt_a_src_data34 (sc2mac_wt_a_src_data34)
,.sc2mac_wt_b_dst_data34 (sc2mac_wt_b_dst_data34)

,.sc2mac_dat_a_src_data35 (sc2mac_dat_a_src_data35)
,.sc2mac_dat_b_dst_data35 (sc2mac_dat_b_dst_data35)
,.sc2mac_wt_a_src_data35 (sc2mac_wt_a_src_data35)
,.sc2mac_wt_b_dst_data35 (sc2mac_wt_b_dst_data35)

,.sc2mac_dat_a_src_data36 (sc2mac_dat_a_src_data36)
,.sc2mac_dat_b_dst_data36 (sc2mac_dat_b_dst_data36)
,.sc2mac_wt_a_src_data36 (sc2mac_wt_a_src_data36)
,.sc2mac_wt_b_dst_data36 (sc2mac_wt_b_dst_data36)

,.sc2mac_dat_a_src_data37 (sc2mac_dat_a_src_data37)
,.sc2mac_dat_b_dst_data37 (sc2mac_dat_b_dst_data37)
,.sc2mac_wt_a_src_data37 (sc2mac_wt_a_src_data37)
,.sc2mac_wt_b_dst_data37 (sc2mac_wt_b_dst_data37)

,.sc2mac_dat_a_src_data38 (sc2mac_dat_a_src_data38)
,.sc2mac_dat_b_dst_data38 (sc2mac_dat_b_dst_data38)
,.sc2mac_wt_a_src_data38 (sc2mac_wt_a_src_data38)
,.sc2mac_wt_b_dst_data38 (sc2mac_wt_b_dst_data38)

,.sc2mac_dat_a_src_data39 (sc2mac_dat_a_src_data39)
,.sc2mac_dat_b_dst_data39 (sc2mac_dat_b_dst_data39)
,.sc2mac_wt_a_src_data39 (sc2mac_wt_a_src_data39)
,.sc2mac_wt_b_dst_data39 (sc2mac_wt_b_dst_data39)

,.sc2mac_dat_a_src_data40 (sc2mac_dat_a_src_data40)
,.sc2mac_dat_b_dst_data40 (sc2mac_dat_b_dst_data40)
,.sc2mac_wt_a_src_data40 (sc2mac_wt_a_src_data40)
,.sc2mac_wt_b_dst_data40 (sc2mac_wt_b_dst_data40)

,.sc2mac_dat_a_src_data41 (sc2mac_dat_a_src_data41)
,.sc2mac_dat_b_dst_data41 (sc2mac_dat_b_dst_data41)
,.sc2mac_wt_a_src_data41 (sc2mac_wt_a_src_data41)
,.sc2mac_wt_b_dst_data41 (sc2mac_wt_b_dst_data41)

,.sc2mac_dat_a_src_data42 (sc2mac_dat_a_src_data42)
,.sc2mac_dat_b_dst_data42 (sc2mac_dat_b_dst_data42)
,.sc2mac_wt_a_src_data42 (sc2mac_wt_a_src_data42)
,.sc2mac_wt_b_dst_data42 (sc2mac_wt_b_dst_data42)

,.sc2mac_dat_a_src_data43 (sc2mac_dat_a_src_data43)
,.sc2mac_dat_b_dst_data43 (sc2mac_dat_b_dst_data43)
,.sc2mac_wt_a_src_data43 (sc2mac_wt_a_src_data43)
,.sc2mac_wt_b_dst_data43 (sc2mac_wt_b_dst_data43)

,.sc2mac_dat_a_src_data44 (sc2mac_dat_a_src_data44)
,.sc2mac_dat_b_dst_data44 (sc2mac_dat_b_dst_data44)
,.sc2mac_wt_a_src_data44 (sc2mac_wt_a_src_data44)
,.sc2mac_wt_b_dst_data44 (sc2mac_wt_b_dst_data44)

,.sc2mac_dat_a_src_data45 (sc2mac_dat_a_src_data45)
,.sc2mac_dat_b_dst_data45 (sc2mac_dat_b_dst_data45)
,.sc2mac_wt_a_src_data45 (sc2mac_wt_a_src_data45)
,.sc2mac_wt_b_dst_data45 (sc2mac_wt_b_dst_data45)

,.sc2mac_dat_a_src_data46 (sc2mac_dat_a_src_data46)
,.sc2mac_dat_b_dst_data46 (sc2mac_dat_b_dst_data46)
,.sc2mac_wt_a_src_data46 (sc2mac_wt_a_src_data46)
,.sc2mac_wt_b_dst_data46 (sc2mac_wt_b_dst_data46)

,.sc2mac_dat_a_src_data47 (sc2mac_dat_a_src_data47)
,.sc2mac_dat_b_dst_data47 (sc2mac_dat_b_dst_data47)
,.sc2mac_wt_a_src_data47 (sc2mac_wt_a_src_data47)
,.sc2mac_wt_b_dst_data47 (sc2mac_wt_b_dst_data47)

,.sc2mac_dat_a_src_data48 (sc2mac_dat_a_src_data48)
,.sc2mac_dat_b_dst_data48 (sc2mac_dat_b_dst_data48)
,.sc2mac_wt_a_src_data48 (sc2mac_wt_a_src_data48)
,.sc2mac_wt_b_dst_data48 (sc2mac_wt_b_dst_data48)

,.sc2mac_dat_a_src_data49 (sc2mac_dat_a_src_data49)
,.sc2mac_dat_b_dst_data49 (sc2mac_dat_b_dst_data49)
,.sc2mac_wt_a_src_data49 (sc2mac_wt_a_src_data49)
,.sc2mac_wt_b_dst_data49 (sc2mac_wt_b_dst_data49)

,.sc2mac_dat_a_src_data50 (sc2mac_dat_a_src_data50)
,.sc2mac_dat_b_dst_data50 (sc2mac_dat_b_dst_data50)
,.sc2mac_wt_a_src_data50 (sc2mac_wt_a_src_data50)
,.sc2mac_wt_b_dst_data50 (sc2mac_wt_b_dst_data50)

,.sc2mac_dat_a_src_data51 (sc2mac_dat_a_src_data51)
,.sc2mac_dat_b_dst_data51 (sc2mac_dat_b_dst_data51)
,.sc2mac_wt_a_src_data51 (sc2mac_wt_a_src_data51)
,.sc2mac_wt_b_dst_data51 (sc2mac_wt_b_dst_data51)

,.sc2mac_dat_a_src_data52 (sc2mac_dat_a_src_data52)
,.sc2mac_dat_b_dst_data52 (sc2mac_dat_b_dst_data52)
,.sc2mac_wt_a_src_data52 (sc2mac_wt_a_src_data52)
,.sc2mac_wt_b_dst_data52 (sc2mac_wt_b_dst_data52)

,.sc2mac_dat_a_src_data53 (sc2mac_dat_a_src_data53)
,.sc2mac_dat_b_dst_data53 (sc2mac_dat_b_dst_data53)
,.sc2mac_wt_a_src_data53 (sc2mac_wt_a_src_data53)
,.sc2mac_wt_b_dst_data53 (sc2mac_wt_b_dst_data53)

,.sc2mac_dat_a_src_data54 (sc2mac_dat_a_src_data54)
,.sc2mac_dat_b_dst_data54 (sc2mac_dat_b_dst_data54)
,.sc2mac_wt_a_src_data54 (sc2mac_wt_a_src_data54)
,.sc2mac_wt_b_dst_data54 (sc2mac_wt_b_dst_data54)

,.sc2mac_dat_a_src_data55 (sc2mac_dat_a_src_data55)
,.sc2mac_dat_b_dst_data55 (sc2mac_dat_b_dst_data55)
,.sc2mac_wt_a_src_data55 (sc2mac_wt_a_src_data55)
,.sc2mac_wt_b_dst_data55 (sc2mac_wt_b_dst_data55)

,.sc2mac_dat_a_src_data56 (sc2mac_dat_a_src_data56)
,.sc2mac_dat_b_dst_data56 (sc2mac_dat_b_dst_data56)
,.sc2mac_wt_a_src_data56 (sc2mac_wt_a_src_data56)
,.sc2mac_wt_b_dst_data56 (sc2mac_wt_b_dst_data56)

,.sc2mac_dat_a_src_data57 (sc2mac_dat_a_src_data57)
,.sc2mac_dat_b_dst_data57 (sc2mac_dat_b_dst_data57)
,.sc2mac_wt_a_src_data57 (sc2mac_wt_a_src_data57)
,.sc2mac_wt_b_dst_data57 (sc2mac_wt_b_dst_data57)

,.sc2mac_dat_a_src_data58 (sc2mac_dat_a_src_data58)
,.sc2mac_dat_b_dst_data58 (sc2mac_dat_b_dst_data58)
,.sc2mac_wt_a_src_data58 (sc2mac_wt_a_src_data58)
,.sc2mac_wt_b_dst_data58 (sc2mac_wt_b_dst_data58)

,.sc2mac_dat_a_src_data59 (sc2mac_dat_a_src_data59)
,.sc2mac_dat_b_dst_data59 (sc2mac_dat_b_dst_data59)
,.sc2mac_wt_a_src_data59 (sc2mac_wt_a_src_data59)
,.sc2mac_wt_b_dst_data59 (sc2mac_wt_b_dst_data59)

,.sc2mac_dat_a_src_data60 (sc2mac_dat_a_src_data60)
,.sc2mac_dat_b_dst_data60 (sc2mac_dat_b_dst_data60)
,.sc2mac_wt_a_src_data60 (sc2mac_wt_a_src_data60)
,.sc2mac_wt_b_dst_data60 (sc2mac_wt_b_dst_data60)

,.sc2mac_dat_a_src_data61 (sc2mac_dat_a_src_data61)
,.sc2mac_dat_b_dst_data61 (sc2mac_dat_b_dst_data61)
,.sc2mac_wt_a_src_data61 (sc2mac_wt_a_src_data61)
,.sc2mac_wt_b_dst_data61 (sc2mac_wt_b_dst_data61)

,.sc2mac_dat_a_src_data62 (sc2mac_dat_a_src_data62)
,.sc2mac_dat_b_dst_data62 (sc2mac_dat_b_dst_data62)
,.sc2mac_wt_a_src_data62 (sc2mac_wt_a_src_data62)
,.sc2mac_wt_b_dst_data62 (sc2mac_wt_b_dst_data62)

,.sc2mac_dat_a_src_data63 (sc2mac_dat_a_src_data63)
,.sc2mac_dat_b_dst_data63 (sc2mac_dat_b_dst_data63)
,.sc2mac_wt_a_src_data63 (sc2mac_wt_a_src_data63)
,.sc2mac_wt_b_dst_data63 (sc2mac_wt_b_dst_data63)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_a_src_pd (sc2mac_dat_a_src_pd[8:0])
  ,.sc2mac_dat_b_dst_pvld (sc2mac_dat_b_dst_pvld)
  ,.sc2mac_dat_b_dst_mask (sc2mac_dat_b_dst_mask[64 -1:0])
  ,.sc2mac_dat_b_dst_pd (sc2mac_dat_b_dst_pd[8:0])
  ,.sc2mac_wt_a_src_pvld (sc2mac_wt_a_src_pvld)
  ,.sc2mac_wt_a_src_mask (sc2mac_wt_a_src_mask[64 -1:0])
  ,.sc2mac_wt_a_src_sel (sc2mac_wt_a_src_sel[32/2-1:0])
  ,.sc2mac_wt_b_dst_pvld (sc2mac_wt_b_dst_pvld)
  ,.sc2mac_wt_b_dst_mask (sc2mac_wt_b_dst_mask[64 -1:0])
  ,.sc2mac_wt_b_dst_sel (sc2mac_wt_b_dst_sel[32/2-1:0])
  ,.nvdla_core_clk (dla_core_clk)
  ,.dla_reset_rstn (nvdla_core_rstn)
  ,.nvdla_clk_ovr_on (nvdla_clk_ovr_on)
  );
//&Connect /nvdla_obs/ nvdla_pwrpart_c_obs;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition MA //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_partition_m u_partition_ma (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.csb2cmac_a_req_pvld (csb2cmac_a_req_dst_pvld) //|< w
  ,.csb2cmac_a_req_prdy (csb2cmac_a_req_dst_prdy) //|> w
  ,.csb2cmac_a_req_pd (csb2cmac_a_req_dst_pd) //|< w
  ,.cmac_a2csb_resp_valid (cmac_a2csb_resp_src_valid) //|> w
  ,.cmac_a2csb_resp_pd (cmac_a2csb_resp_src_pd) //|> w
  ,.sc2mac_wt_pvld (sc2mac_wt_a_dst_pvld) //|< w
  ,.sc2mac_wt_mask (sc2mac_wt_a_dst_mask) //|< w
//: for(my $i=0; $i<64 ; $i++){
//: print qq(
//: ,.sc2mac_wt_data${i} (sc2mac_wt_a_dst_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_data0 (sc2mac_wt_a_dst_data0) //|< w 
,.sc2mac_wt_data1 (sc2mac_wt_a_dst_data1) //|< w 
,.sc2mac_wt_data2 (sc2mac_wt_a_dst_data2) //|< w 
,.sc2mac_wt_data3 (sc2mac_wt_a_dst_data3) //|< w 
,.sc2mac_wt_data4 (sc2mac_wt_a_dst_data4) //|< w 
,.sc2mac_wt_data5 (sc2mac_wt_a_dst_data5) //|< w 
,.sc2mac_wt_data6 (sc2mac_wt_a_dst_data6) //|< w 
,.sc2mac_wt_data7 (sc2mac_wt_a_dst_data7) //|< w 
,.sc2mac_wt_data8 (sc2mac_wt_a_dst_data8) //|< w 
,.sc2mac_wt_data9 (sc2mac_wt_a_dst_data9) //|< w 
,.sc2mac_wt_data10 (sc2mac_wt_a_dst_data10) //|< w 
,.sc2mac_wt_data11 (sc2mac_wt_a_dst_data11) //|< w 
,.sc2mac_wt_data12 (sc2mac_wt_a_dst_data12) //|< w 
,.sc2mac_wt_data13 (sc2mac_wt_a_dst_data13) //|< w 
,.sc2mac_wt_data14 (sc2mac_wt_a_dst_data14) //|< w 
,.sc2mac_wt_data15 (sc2mac_wt_a_dst_data15) //|< w 
,.sc2mac_wt_data16 (sc2mac_wt_a_dst_data16) //|< w 
,.sc2mac_wt_data17 (sc2mac_wt_a_dst_data17) //|< w 
,.sc2mac_wt_data18 (sc2mac_wt_a_dst_data18) //|< w 
,.sc2mac_wt_data19 (sc2mac_wt_a_dst_data19) //|< w 
,.sc2mac_wt_data20 (sc2mac_wt_a_dst_data20) //|< w 
,.sc2mac_wt_data21 (sc2mac_wt_a_dst_data21) //|< w 
,.sc2mac_wt_data22 (sc2mac_wt_a_dst_data22) //|< w 
,.sc2mac_wt_data23 (sc2mac_wt_a_dst_data23) //|< w 
,.sc2mac_wt_data24 (sc2mac_wt_a_dst_data24) //|< w 
,.sc2mac_wt_data25 (sc2mac_wt_a_dst_data25) //|< w 
,.sc2mac_wt_data26 (sc2mac_wt_a_dst_data26) //|< w 
,.sc2mac_wt_data27 (sc2mac_wt_a_dst_data27) //|< w 
,.sc2mac_wt_data28 (sc2mac_wt_a_dst_data28) //|< w 
,.sc2mac_wt_data29 (sc2mac_wt_a_dst_data29) //|< w 
,.sc2mac_wt_data30 (sc2mac_wt_a_dst_data30) //|< w 
,.sc2mac_wt_data31 (sc2mac_wt_a_dst_data31) //|< w 
,.sc2mac_wt_data32 (sc2mac_wt_a_dst_data32) //|< w 
,.sc2mac_wt_data33 (sc2mac_wt_a_dst_data33) //|< w 
,.sc2mac_wt_data34 (sc2mac_wt_a_dst_data34) //|< w 
,.sc2mac_wt_data35 (sc2mac_wt_a_dst_data35) //|< w 
,.sc2mac_wt_data36 (sc2mac_wt_a_dst_data36) //|< w 
,.sc2mac_wt_data37 (sc2mac_wt_a_dst_data37) //|< w 
,.sc2mac_wt_data38 (sc2mac_wt_a_dst_data38) //|< w 
,.sc2mac_wt_data39 (sc2mac_wt_a_dst_data39) //|< w 
,.sc2mac_wt_data40 (sc2mac_wt_a_dst_data40) //|< w 
,.sc2mac_wt_data41 (sc2mac_wt_a_dst_data41) //|< w 
,.sc2mac_wt_data42 (sc2mac_wt_a_dst_data42) //|< w 
,.sc2mac_wt_data43 (sc2mac_wt_a_dst_data43) //|< w 
,.sc2mac_wt_data44 (sc2mac_wt_a_dst_data44) //|< w 
,.sc2mac_wt_data45 (sc2mac_wt_a_dst_data45) //|< w 
,.sc2mac_wt_data46 (sc2mac_wt_a_dst_data46) //|< w 
,.sc2mac_wt_data47 (sc2mac_wt_a_dst_data47) //|< w 
,.sc2mac_wt_data48 (sc2mac_wt_a_dst_data48) //|< w 
,.sc2mac_wt_data49 (sc2mac_wt_a_dst_data49) //|< w 
,.sc2mac_wt_data50 (sc2mac_wt_a_dst_data50) //|< w 
,.sc2mac_wt_data51 (sc2mac_wt_a_dst_data51) //|< w 
,.sc2mac_wt_data52 (sc2mac_wt_a_dst_data52) //|< w 
,.sc2mac_wt_data53 (sc2mac_wt_a_dst_data53) //|< w 
,.sc2mac_wt_data54 (sc2mac_wt_a_dst_data54) //|< w 
,.sc2mac_wt_data55 (sc2mac_wt_a_dst_data55) //|< w 
,.sc2mac_wt_data56 (sc2mac_wt_a_dst_data56) //|< w 
,.sc2mac_wt_data57 (sc2mac_wt_a_dst_data57) //|< w 
,.sc2mac_wt_data58 (sc2mac_wt_a_dst_data58) //|< w 
,.sc2mac_wt_data59 (sc2mac_wt_a_dst_data59) //|< w 
,.sc2mac_wt_data60 (sc2mac_wt_a_dst_data60) //|< w 
,.sc2mac_wt_data61 (sc2mac_wt_a_dst_data61) //|< w 
,.sc2mac_wt_data62 (sc2mac_wt_a_dst_data62) //|< w 
,.sc2mac_wt_data63 (sc2mac_wt_a_dst_data63) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_sel (sc2mac_wt_a_dst_sel) //|< w
  ,.sc2mac_dat_pvld (sc2mac_dat_a_dst_pvld) //|< w
  ,.sc2mac_dat_mask (sc2mac_dat_a_dst_mask) //|< w
//: for(my $i=0; $i<64 ; $i++){
//: print qq(
//: ,.sc2mac_dat_data${i} (sc2mac_dat_a_dst_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_data0 (sc2mac_dat_a_dst_data0) //|< w 
,.sc2mac_dat_data1 (sc2mac_dat_a_dst_data1) //|< w 
,.sc2mac_dat_data2 (sc2mac_dat_a_dst_data2) //|< w 
,.sc2mac_dat_data3 (sc2mac_dat_a_dst_data3) //|< w 
,.sc2mac_dat_data4 (sc2mac_dat_a_dst_data4) //|< w 
,.sc2mac_dat_data5 (sc2mac_dat_a_dst_data5) //|< w 
,.sc2mac_dat_data6 (sc2mac_dat_a_dst_data6) //|< w 
,.sc2mac_dat_data7 (sc2mac_dat_a_dst_data7) //|< w 
,.sc2mac_dat_data8 (sc2mac_dat_a_dst_data8) //|< w 
,.sc2mac_dat_data9 (sc2mac_dat_a_dst_data9) //|< w 
,.sc2mac_dat_data10 (sc2mac_dat_a_dst_data10) //|< w 
,.sc2mac_dat_data11 (sc2mac_dat_a_dst_data11) //|< w 
,.sc2mac_dat_data12 (sc2mac_dat_a_dst_data12) //|< w 
,.sc2mac_dat_data13 (sc2mac_dat_a_dst_data13) //|< w 
,.sc2mac_dat_data14 (sc2mac_dat_a_dst_data14) //|< w 
,.sc2mac_dat_data15 (sc2mac_dat_a_dst_data15) //|< w 
,.sc2mac_dat_data16 (sc2mac_dat_a_dst_data16) //|< w 
,.sc2mac_dat_data17 (sc2mac_dat_a_dst_data17) //|< w 
,.sc2mac_dat_data18 (sc2mac_dat_a_dst_data18) //|< w 
,.sc2mac_dat_data19 (sc2mac_dat_a_dst_data19) //|< w 
,.sc2mac_dat_data20 (sc2mac_dat_a_dst_data20) //|< w 
,.sc2mac_dat_data21 (sc2mac_dat_a_dst_data21) //|< w 
,.sc2mac_dat_data22 (sc2mac_dat_a_dst_data22) //|< w 
,.sc2mac_dat_data23 (sc2mac_dat_a_dst_data23) //|< w 
,.sc2mac_dat_data24 (sc2mac_dat_a_dst_data24) //|< w 
,.sc2mac_dat_data25 (sc2mac_dat_a_dst_data25) //|< w 
,.sc2mac_dat_data26 (sc2mac_dat_a_dst_data26) //|< w 
,.sc2mac_dat_data27 (sc2mac_dat_a_dst_data27) //|< w 
,.sc2mac_dat_data28 (sc2mac_dat_a_dst_data28) //|< w 
,.sc2mac_dat_data29 (sc2mac_dat_a_dst_data29) //|< w 
,.sc2mac_dat_data30 (sc2mac_dat_a_dst_data30) //|< w 
,.sc2mac_dat_data31 (sc2mac_dat_a_dst_data31) //|< w 
,.sc2mac_dat_data32 (sc2mac_dat_a_dst_data32) //|< w 
,.sc2mac_dat_data33 (sc2mac_dat_a_dst_data33) //|< w 
,.sc2mac_dat_data34 (sc2mac_dat_a_dst_data34) //|< w 
,.sc2mac_dat_data35 (sc2mac_dat_a_dst_data35) //|< w 
,.sc2mac_dat_data36 (sc2mac_dat_a_dst_data36) //|< w 
,.sc2mac_dat_data37 (sc2mac_dat_a_dst_data37) //|< w 
,.sc2mac_dat_data38 (sc2mac_dat_a_dst_data38) //|< w 
,.sc2mac_dat_data39 (sc2mac_dat_a_dst_data39) //|< w 
,.sc2mac_dat_data40 (sc2mac_dat_a_dst_data40) //|< w 
,.sc2mac_dat_data41 (sc2mac_dat_a_dst_data41) //|< w 
,.sc2mac_dat_data42 (sc2mac_dat_a_dst_data42) //|< w 
,.sc2mac_dat_data43 (sc2mac_dat_a_dst_data43) //|< w 
,.sc2mac_dat_data44 (sc2mac_dat_a_dst_data44) //|< w 
,.sc2mac_dat_data45 (sc2mac_dat_a_dst_data45) //|< w 
,.sc2mac_dat_data46 (sc2mac_dat_a_dst_data46) //|< w 
,.sc2mac_dat_data47 (sc2mac_dat_a_dst_data47) //|< w 
,.sc2mac_dat_data48 (sc2mac_dat_a_dst_data48) //|< w 
,.sc2mac_dat_data49 (sc2mac_dat_a_dst_data49) //|< w 
,.sc2mac_dat_data50 (sc2mac_dat_a_dst_data50) //|< w 
,.sc2mac_dat_data51 (sc2mac_dat_a_dst_data51) //|< w 
,.sc2mac_dat_data52 (sc2mac_dat_a_dst_data52) //|< w 
,.sc2mac_dat_data53 (sc2mac_dat_a_dst_data53) //|< w 
,.sc2mac_dat_data54 (sc2mac_dat_a_dst_data54) //|< w 
,.sc2mac_dat_data55 (sc2mac_dat_a_dst_data55) //|< w 
,.sc2mac_dat_data56 (sc2mac_dat_a_dst_data56) //|< w 
,.sc2mac_dat_data57 (sc2mac_dat_a_dst_data57) //|< w 
,.sc2mac_dat_data58 (sc2mac_dat_a_dst_data58) //|< w 
,.sc2mac_dat_data59 (sc2mac_dat_a_dst_data59) //|< w 
,.sc2mac_dat_data60 (sc2mac_dat_a_dst_data60) //|< w 
,.sc2mac_dat_data61 (sc2mac_dat_a_dst_data61) //|< w 
,.sc2mac_dat_data62 (sc2mac_dat_a_dst_data62) //|< w 
,.sc2mac_dat_data63 (sc2mac_dat_a_dst_data63) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_pd (sc2mac_dat_a_dst_pd) //|< w
  ,.mac2accu_pvld (mac_a2accu_src_pvld) //|> w
  ,.mac2accu_mask (mac_a2accu_src_mask) //|> w
  ,.mac2accu_mode (mac_a2accu_src_mode) //|> w
//: for(my $i=0; $i<32/2 ; $i++){
//: print qq(
//: ,.mac2accu_data${i} (mac_a2accu_src_data${i}) //|> w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac2accu_data0 (mac_a2accu_src_data0) //|> w 
,.mac2accu_data1 (mac_a2accu_src_data1) //|> w 
,.mac2accu_data2 (mac_a2accu_src_data2) //|> w 
,.mac2accu_data3 (mac_a2accu_src_data3) //|> w 
,.mac2accu_data4 (mac_a2accu_src_data4) //|> w 
,.mac2accu_data5 (mac_a2accu_src_data5) //|> w 
,.mac2accu_data6 (mac_a2accu_src_data6) //|> w 
,.mac2accu_data7 (mac_a2accu_src_data7) //|> w 
,.mac2accu_data8 (mac_a2accu_src_data8) //|> w 
,.mac2accu_data9 (mac_a2accu_src_data9) //|> w 
,.mac2accu_data10 (mac_a2accu_src_data10) //|> w 
,.mac2accu_data11 (mac_a2accu_src_data11) //|> w 
,.mac2accu_data12 (mac_a2accu_src_data12) //|> w 
,.mac2accu_data13 (mac_a2accu_src_data13) //|> w 
,.mac2accu_data14 (mac_a2accu_src_data14) //|> w 
,.mac2accu_data15 (mac_a2accu_src_data15) //|> w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac2accu_pd (mac_a2accu_src_pd) //|> w
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.nvdla_core_clk (dla_core_clk)
  ,.dla_reset_rstn (nvdla_core_rstn)
  ,.nvdla_clk_ovr_on (nvdla_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition MB //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_partition_m u_partition_mb (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.csb2cmac_a_req_pvld (csb2cmac_b_req_dst_pvld) //|< w
  ,.csb2cmac_a_req_prdy (csb2cmac_b_req_dst_prdy) //|> w
  ,.csb2cmac_a_req_pd (csb2cmac_b_req_dst_pd) //|< w
  ,.cmac_a2csb_resp_valid (cmac_b2csb_resp_src_valid) //|> w
  ,.cmac_a2csb_resp_pd (cmac_b2csb_resp_src_pd) //|> w
  ,.sc2mac_wt_pvld (sc2mac_wt_b_dst_pvld) //|< w
  ,.sc2mac_wt_mask (sc2mac_wt_b_dst_mask) //|< w
//: for(my $i=0; $i<64 ; $i++){
//: print qq(
//: ,.sc2mac_wt_data${i} (sc2mac_wt_b_dst_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_data0 (sc2mac_wt_b_dst_data0) //|< w 
,.sc2mac_wt_data1 (sc2mac_wt_b_dst_data1) //|< w 
,.sc2mac_wt_data2 (sc2mac_wt_b_dst_data2) //|< w 
,.sc2mac_wt_data3 (sc2mac_wt_b_dst_data3) //|< w 
,.sc2mac_wt_data4 (sc2mac_wt_b_dst_data4) //|< w 
,.sc2mac_wt_data5 (sc2mac_wt_b_dst_data5) //|< w 
,.sc2mac_wt_data6 (sc2mac_wt_b_dst_data6) //|< w 
,.sc2mac_wt_data7 (sc2mac_wt_b_dst_data7) //|< w 
,.sc2mac_wt_data8 (sc2mac_wt_b_dst_data8) //|< w 
,.sc2mac_wt_data9 (sc2mac_wt_b_dst_data9) //|< w 
,.sc2mac_wt_data10 (sc2mac_wt_b_dst_data10) //|< w 
,.sc2mac_wt_data11 (sc2mac_wt_b_dst_data11) //|< w 
,.sc2mac_wt_data12 (sc2mac_wt_b_dst_data12) //|< w 
,.sc2mac_wt_data13 (sc2mac_wt_b_dst_data13) //|< w 
,.sc2mac_wt_data14 (sc2mac_wt_b_dst_data14) //|< w 
,.sc2mac_wt_data15 (sc2mac_wt_b_dst_data15) //|< w 
,.sc2mac_wt_data16 (sc2mac_wt_b_dst_data16) //|< w 
,.sc2mac_wt_data17 (sc2mac_wt_b_dst_data17) //|< w 
,.sc2mac_wt_data18 (sc2mac_wt_b_dst_data18) //|< w 
,.sc2mac_wt_data19 (sc2mac_wt_b_dst_data19) //|< w 
,.sc2mac_wt_data20 (sc2mac_wt_b_dst_data20) //|< w 
,.sc2mac_wt_data21 (sc2mac_wt_b_dst_data21) //|< w 
,.sc2mac_wt_data22 (sc2mac_wt_b_dst_data22) //|< w 
,.sc2mac_wt_data23 (sc2mac_wt_b_dst_data23) //|< w 
,.sc2mac_wt_data24 (sc2mac_wt_b_dst_data24) //|< w 
,.sc2mac_wt_data25 (sc2mac_wt_b_dst_data25) //|< w 
,.sc2mac_wt_data26 (sc2mac_wt_b_dst_data26) //|< w 
,.sc2mac_wt_data27 (sc2mac_wt_b_dst_data27) //|< w 
,.sc2mac_wt_data28 (sc2mac_wt_b_dst_data28) //|< w 
,.sc2mac_wt_data29 (sc2mac_wt_b_dst_data29) //|< w 
,.sc2mac_wt_data30 (sc2mac_wt_b_dst_data30) //|< w 
,.sc2mac_wt_data31 (sc2mac_wt_b_dst_data31) //|< w 
,.sc2mac_wt_data32 (sc2mac_wt_b_dst_data32) //|< w 
,.sc2mac_wt_data33 (sc2mac_wt_b_dst_data33) //|< w 
,.sc2mac_wt_data34 (sc2mac_wt_b_dst_data34) //|< w 
,.sc2mac_wt_data35 (sc2mac_wt_b_dst_data35) //|< w 
,.sc2mac_wt_data36 (sc2mac_wt_b_dst_data36) //|< w 
,.sc2mac_wt_data37 (sc2mac_wt_b_dst_data37) //|< w 
,.sc2mac_wt_data38 (sc2mac_wt_b_dst_data38) //|< w 
,.sc2mac_wt_data39 (sc2mac_wt_b_dst_data39) //|< w 
,.sc2mac_wt_data40 (sc2mac_wt_b_dst_data40) //|< w 
,.sc2mac_wt_data41 (sc2mac_wt_b_dst_data41) //|< w 
,.sc2mac_wt_data42 (sc2mac_wt_b_dst_data42) //|< w 
,.sc2mac_wt_data43 (sc2mac_wt_b_dst_data43) //|< w 
,.sc2mac_wt_data44 (sc2mac_wt_b_dst_data44) //|< w 
,.sc2mac_wt_data45 (sc2mac_wt_b_dst_data45) //|< w 
,.sc2mac_wt_data46 (sc2mac_wt_b_dst_data46) //|< w 
,.sc2mac_wt_data47 (sc2mac_wt_b_dst_data47) //|< w 
,.sc2mac_wt_data48 (sc2mac_wt_b_dst_data48) //|< w 
,.sc2mac_wt_data49 (sc2mac_wt_b_dst_data49) //|< w 
,.sc2mac_wt_data50 (sc2mac_wt_b_dst_data50) //|< w 
,.sc2mac_wt_data51 (sc2mac_wt_b_dst_data51) //|< w 
,.sc2mac_wt_data52 (sc2mac_wt_b_dst_data52) //|< w 
,.sc2mac_wt_data53 (sc2mac_wt_b_dst_data53) //|< w 
,.sc2mac_wt_data54 (sc2mac_wt_b_dst_data54) //|< w 
,.sc2mac_wt_data55 (sc2mac_wt_b_dst_data55) //|< w 
,.sc2mac_wt_data56 (sc2mac_wt_b_dst_data56) //|< w 
,.sc2mac_wt_data57 (sc2mac_wt_b_dst_data57) //|< w 
,.sc2mac_wt_data58 (sc2mac_wt_b_dst_data58) //|< w 
,.sc2mac_wt_data59 (sc2mac_wt_b_dst_data59) //|< w 
,.sc2mac_wt_data60 (sc2mac_wt_b_dst_data60) //|< w 
,.sc2mac_wt_data61 (sc2mac_wt_b_dst_data61) //|< w 
,.sc2mac_wt_data62 (sc2mac_wt_b_dst_data62) //|< w 
,.sc2mac_wt_data63 (sc2mac_wt_b_dst_data63) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_sel (sc2mac_wt_b_dst_sel) //|< w
  ,.sc2mac_dat_pvld (sc2mac_dat_b_dst_pvld) //|< w
  ,.sc2mac_dat_mask (sc2mac_dat_b_dst_mask) //|< w
//: for(my $i=0; $i<64 ; $i++){
//: print qq(
//: ,.sc2mac_dat_data${i} (sc2mac_dat_b_dst_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_data0 (sc2mac_dat_b_dst_data0) //|< w 
,.sc2mac_dat_data1 (sc2mac_dat_b_dst_data1) //|< w 
,.sc2mac_dat_data2 (sc2mac_dat_b_dst_data2) //|< w 
,.sc2mac_dat_data3 (sc2mac_dat_b_dst_data3) //|< w 
,.sc2mac_dat_data4 (sc2mac_dat_b_dst_data4) //|< w 
,.sc2mac_dat_data5 (sc2mac_dat_b_dst_data5) //|< w 
,.sc2mac_dat_data6 (sc2mac_dat_b_dst_data6) //|< w 
,.sc2mac_dat_data7 (sc2mac_dat_b_dst_data7) //|< w 
,.sc2mac_dat_data8 (sc2mac_dat_b_dst_data8) //|< w 
,.sc2mac_dat_data9 (sc2mac_dat_b_dst_data9) //|< w 
,.sc2mac_dat_data10 (sc2mac_dat_b_dst_data10) //|< w 
,.sc2mac_dat_data11 (sc2mac_dat_b_dst_data11) //|< w 
,.sc2mac_dat_data12 (sc2mac_dat_b_dst_data12) //|< w 
,.sc2mac_dat_data13 (sc2mac_dat_b_dst_data13) //|< w 
,.sc2mac_dat_data14 (sc2mac_dat_b_dst_data14) //|< w 
,.sc2mac_dat_data15 (sc2mac_dat_b_dst_data15) //|< w 
,.sc2mac_dat_data16 (sc2mac_dat_b_dst_data16) //|< w 
,.sc2mac_dat_data17 (sc2mac_dat_b_dst_data17) //|< w 
,.sc2mac_dat_data18 (sc2mac_dat_b_dst_data18) //|< w 
,.sc2mac_dat_data19 (sc2mac_dat_b_dst_data19) //|< w 
,.sc2mac_dat_data20 (sc2mac_dat_b_dst_data20) //|< w 
,.sc2mac_dat_data21 (sc2mac_dat_b_dst_data21) //|< w 
,.sc2mac_dat_data22 (sc2mac_dat_b_dst_data22) //|< w 
,.sc2mac_dat_data23 (sc2mac_dat_b_dst_data23) //|< w 
,.sc2mac_dat_data24 (sc2mac_dat_b_dst_data24) //|< w 
,.sc2mac_dat_data25 (sc2mac_dat_b_dst_data25) //|< w 
,.sc2mac_dat_data26 (sc2mac_dat_b_dst_data26) //|< w 
,.sc2mac_dat_data27 (sc2mac_dat_b_dst_data27) //|< w 
,.sc2mac_dat_data28 (sc2mac_dat_b_dst_data28) //|< w 
,.sc2mac_dat_data29 (sc2mac_dat_b_dst_data29) //|< w 
,.sc2mac_dat_data30 (sc2mac_dat_b_dst_data30) //|< w 
,.sc2mac_dat_data31 (sc2mac_dat_b_dst_data31) //|< w 
,.sc2mac_dat_data32 (sc2mac_dat_b_dst_data32) //|< w 
,.sc2mac_dat_data33 (sc2mac_dat_b_dst_data33) //|< w 
,.sc2mac_dat_data34 (sc2mac_dat_b_dst_data34) //|< w 
,.sc2mac_dat_data35 (sc2mac_dat_b_dst_data35) //|< w 
,.sc2mac_dat_data36 (sc2mac_dat_b_dst_data36) //|< w 
,.sc2mac_dat_data37 (sc2mac_dat_b_dst_data37) //|< w 
,.sc2mac_dat_data38 (sc2mac_dat_b_dst_data38) //|< w 
,.sc2mac_dat_data39 (sc2mac_dat_b_dst_data39) //|< w 
,.sc2mac_dat_data40 (sc2mac_dat_b_dst_data40) //|< w 
,.sc2mac_dat_data41 (sc2mac_dat_b_dst_data41) //|< w 
,.sc2mac_dat_data42 (sc2mac_dat_b_dst_data42) //|< w 
,.sc2mac_dat_data43 (sc2mac_dat_b_dst_data43) //|< w 
,.sc2mac_dat_data44 (sc2mac_dat_b_dst_data44) //|< w 
,.sc2mac_dat_data45 (sc2mac_dat_b_dst_data45) //|< w 
,.sc2mac_dat_data46 (sc2mac_dat_b_dst_data46) //|< w 
,.sc2mac_dat_data47 (sc2mac_dat_b_dst_data47) //|< w 
,.sc2mac_dat_data48 (sc2mac_dat_b_dst_data48) //|< w 
,.sc2mac_dat_data49 (sc2mac_dat_b_dst_data49) //|< w 
,.sc2mac_dat_data50 (sc2mac_dat_b_dst_data50) //|< w 
,.sc2mac_dat_data51 (sc2mac_dat_b_dst_data51) //|< w 
,.sc2mac_dat_data52 (sc2mac_dat_b_dst_data52) //|< w 
,.sc2mac_dat_data53 (sc2mac_dat_b_dst_data53) //|< w 
,.sc2mac_dat_data54 (sc2mac_dat_b_dst_data54) //|< w 
,.sc2mac_dat_data55 (sc2mac_dat_b_dst_data55) //|< w 
,.sc2mac_dat_data56 (sc2mac_dat_b_dst_data56) //|< w 
,.sc2mac_dat_data57 (sc2mac_dat_b_dst_data57) //|< w 
,.sc2mac_dat_data58 (sc2mac_dat_b_dst_data58) //|< w 
,.sc2mac_dat_data59 (sc2mac_dat_b_dst_data59) //|< w 
,.sc2mac_dat_data60 (sc2mac_dat_b_dst_data60) //|< w 
,.sc2mac_dat_data61 (sc2mac_dat_b_dst_data61) //|< w 
,.sc2mac_dat_data62 (sc2mac_dat_b_dst_data62) //|< w 
,.sc2mac_dat_data63 (sc2mac_dat_b_dst_data63) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_pd (sc2mac_dat_b_dst_pd) //|< w
  ,.mac2accu_pvld (mac_b2accu_src_pvld) //|> w
  ,.mac2accu_mask (mac_b2accu_src_mask) //|> w
  ,.mac2accu_mode (mac_b2accu_src_mode) //|> w
//: for(my $i=0; $i<32/2 ; $i++){
//: print qq(
//: ,.mac2accu_data${i} (mac_b2accu_src_data${i}) //|> w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac2accu_data0 (mac_b2accu_src_data0) //|> w 
,.mac2accu_data1 (mac_b2accu_src_data1) //|> w 
,.mac2accu_data2 (mac_b2accu_src_data2) //|> w 
,.mac2accu_data3 (mac_b2accu_src_data3) //|> w 
,.mac2accu_data4 (mac_b2accu_src_data4) //|> w 
,.mac2accu_data5 (mac_b2accu_src_data5) //|> w 
,.mac2accu_data6 (mac_b2accu_src_data6) //|> w 
,.mac2accu_data7 (mac_b2accu_src_data7) //|> w 
,.mac2accu_data8 (mac_b2accu_src_data8) //|> w 
,.mac2accu_data9 (mac_b2accu_src_data9) //|> w 
,.mac2accu_data10 (mac_b2accu_src_data10) //|> w 
,.mac2accu_data11 (mac_b2accu_src_data11) //|> w 
,.mac2accu_data12 (mac_b2accu_src_data12) //|> w 
,.mac2accu_data13 (mac_b2accu_src_data13) //|> w 
,.mac2accu_data14 (mac_b2accu_src_data14) //|> w 
,.mac2accu_data15 (mac_b2accu_src_data15) //|> w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac2accu_pd (mac_b2accu_src_pd) //|> w
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.nvdla_core_clk (dla_core_clk)
  ,.dla_reset_rstn (nvdla_core_rstn)
  ,.nvdla_clk_ovr_on (nvdla_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition A //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_partition_a u_partition_a (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.accu2sc_credit_vld (accu2sc_credit_vld)
  ,.accu2sc_credit_size (accu2sc_credit_size[2:0])
  ,.csb2cacc_req_dst_pvld (csb2cacc_req_dst_pvld)
  ,.csb2cacc_req_dst_prdy (csb2cacc_req_dst_prdy)
  ,.csb2cacc_req_dst_pd (csb2cacc_req_dst_pd[62:0])
  ,.cacc2csb_resp_src_valid (cacc2csb_resp_src_valid)
  ,.cacc2csb_resp_src_pd (cacc2csb_resp_src_pd[33:0])
  ,.cacc2glb_done_intr_src_pd (cacc2glb_done_intr_src_pd[1:0])
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.mac_a2accu_dst_pvld (mac_a2accu_dst_pvld)
  ,.mac_a2accu_dst_mask (mac_a2accu_dst_mask[32/2-1:0])
  ,.mac_a2accu_dst_mode (mac_a2accu_dst_mode)
//: for(my $i=0; $i<32/2 ; $i++){
//: print qq(
//: ,.mac_a2accu_dst_data${i} (mac_a2accu_dst_data${i}[22 -1:0]) )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac_a2accu_dst_data0 (mac_a2accu_dst_data0[22 -1:0]) 
,.mac_a2accu_dst_data1 (mac_a2accu_dst_data1[22 -1:0]) 
,.mac_a2accu_dst_data2 (mac_a2accu_dst_data2[22 -1:0]) 
,.mac_a2accu_dst_data3 (mac_a2accu_dst_data3[22 -1:0]) 
,.mac_a2accu_dst_data4 (mac_a2accu_dst_data4[22 -1:0]) 
,.mac_a2accu_dst_data5 (mac_a2accu_dst_data5[22 -1:0]) 
,.mac_a2accu_dst_data6 (mac_a2accu_dst_data6[22 -1:0]) 
,.mac_a2accu_dst_data7 (mac_a2accu_dst_data7[22 -1:0]) 
,.mac_a2accu_dst_data8 (mac_a2accu_dst_data8[22 -1:0]) 
,.mac_a2accu_dst_data9 (mac_a2accu_dst_data9[22 -1:0]) 
,.mac_a2accu_dst_data10 (mac_a2accu_dst_data10[22 -1:0]) 
,.mac_a2accu_dst_data11 (mac_a2accu_dst_data11[22 -1:0]) 
,.mac_a2accu_dst_data12 (mac_a2accu_dst_data12[22 -1:0]) 
,.mac_a2accu_dst_data13 (mac_a2accu_dst_data13[22 -1:0]) 
,.mac_a2accu_dst_data14 (mac_a2accu_dst_data14[22 -1:0]) 
,.mac_a2accu_dst_data15 (mac_a2accu_dst_data15[22 -1:0]) 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_a2accu_dst_pd (mac_a2accu_dst_pd[8:0])
  ,.mac_b2accu_src_pvld (mac_b2accu_src_pvld)
  ,.mac_b2accu_src_mask (mac_b2accu_src_mask[32/2-1:0])
  ,.mac_b2accu_src_mode (mac_b2accu_src_mode)
//: for(my $i=0; $i<32/2 ; $i++){
//: print qq(
//: ,.mac_b2accu_src_data${i} (mac_b2accu_src_data${i}[22 -1:0]) )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac_b2accu_src_data0 (mac_b2accu_src_data0[22 -1:0]) 
,.mac_b2accu_src_data1 (mac_b2accu_src_data1[22 -1:0]) 
,.mac_b2accu_src_data2 (mac_b2accu_src_data2[22 -1:0]) 
,.mac_b2accu_src_data3 (mac_b2accu_src_data3[22 -1:0]) 
,.mac_b2accu_src_data4 (mac_b2accu_src_data4[22 -1:0]) 
,.mac_b2accu_src_data5 (mac_b2accu_src_data5[22 -1:0]) 
,.mac_b2accu_src_data6 (mac_b2accu_src_data6[22 -1:0]) 
,.mac_b2accu_src_data7 (mac_b2accu_src_data7[22 -1:0]) 
,.mac_b2accu_src_data8 (mac_b2accu_src_data8[22 -1:0]) 
,.mac_b2accu_src_data9 (mac_b2accu_src_data9[22 -1:0]) 
,.mac_b2accu_src_data10 (mac_b2accu_src_data10[22 -1:0]) 
,.mac_b2accu_src_data11 (mac_b2accu_src_data11[22 -1:0]) 
,.mac_b2accu_src_data12 (mac_b2accu_src_data12[22 -1:0]) 
,.mac_b2accu_src_data13 (mac_b2accu_src_data13[22 -1:0]) 
,.mac_b2accu_src_data14 (mac_b2accu_src_data14[22 -1:0]) 
,.mac_b2accu_src_data15 (mac_b2accu_src_data15[22 -1:0]) 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_b2accu_src_pd (mac_b2accu_src_pd[8:0])
  ,.pwrbus_ram_pd (nvdla_pwrbus_ram_a_pd[31:0])
  ,.nvdla_core_clk (dla_core_clk)
  ,.dla_reset_rstn (nvdla_core_rstn)
  ,.nvdla_clk_ovr_on (nvdla_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition P //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_partition_p u_partition_p (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd[62:0])
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd[62:0])
  ,.mac_a2accu_dst_pvld (mac_a2accu_dst_pvld)
  ,.mac_a2accu_dst_mask (mac_a2accu_dst_mask[32/2-1:0])
  ,.mac_a2accu_dst_mode (mac_a2accu_dst_mode)
//: for(my $i=0; $i<32/2 ; $i++){
//: print qq(
//: ,.mac_a2accu_dst_data${i} (mac_a2accu_dst_data${i}[22 -1:0]) )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac_a2accu_dst_data0 (mac_a2accu_dst_data0[22 -1:0]) 
,.mac_a2accu_dst_data1 (mac_a2accu_dst_data1[22 -1:0]) 
,.mac_a2accu_dst_data2 (mac_a2accu_dst_data2[22 -1:0]) 
,.mac_a2accu_dst_data3 (mac_a2accu_dst_data3[22 -1:0]) 
,.mac_a2accu_dst_data4 (mac_a2accu_dst_data4[22 -1:0]) 
,.mac_a2accu_dst_data5 (mac_a2accu_dst_data5[22 -1:0]) 
,.mac_a2accu_dst_data6 (mac_a2accu_dst_data6[22 -1:0]) 
,.mac_a2accu_dst_data7 (mac_a2accu_dst_data7[22 -1:0]) 
,.mac_a2accu_dst_data8 (mac_a2accu_dst_data8[22 -1:0]) 
,.mac_a2accu_dst_data9 (mac_a2accu_dst_data9[22 -1:0]) 
,.mac_a2accu_dst_data10 (mac_a2accu_dst_data10[22 -1:0]) 
,.mac_a2accu_dst_data11 (mac_a2accu_dst_data11[22 -1:0]) 
,.mac_a2accu_dst_data12 (mac_a2accu_dst_data12[22 -1:0]) 
,.mac_a2accu_dst_data13 (mac_a2accu_dst_data13[22 -1:0]) 
,.mac_a2accu_dst_data14 (mac_a2accu_dst_data14[22 -1:0]) 
,.mac_a2accu_dst_data15 (mac_a2accu_dst_data15[22 -1:0]) 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_a2accu_dst_pd (mac_a2accu_dst_pd[8:0])
  ,.mac_a2accu_src_pvld (mac_a2accu_src_pvld)
  ,.mac_a2accu_src_mask (mac_a2accu_src_mask[32/2-1:0])
  ,.mac_a2accu_src_mode (mac_a2accu_src_mode)
//: for(my $i=0; $i<32/2 ; $i++){
//: print qq(
//: ,.mac_a2accu_src_data${i} (mac_a2accu_src_data${i}[22 -1:0]) )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac_a2accu_src_data0 (mac_a2accu_src_data0[22 -1:0]) 
,.mac_a2accu_src_data1 (mac_a2accu_src_data1[22 -1:0]) 
,.mac_a2accu_src_data2 (mac_a2accu_src_data2[22 -1:0]) 
,.mac_a2accu_src_data3 (mac_a2accu_src_data3[22 -1:0]) 
,.mac_a2accu_src_data4 (mac_a2accu_src_data4[22 -1:0]) 
,.mac_a2accu_src_data5 (mac_a2accu_src_data5[22 -1:0]) 
,.mac_a2accu_src_data6 (mac_a2accu_src_data6[22 -1:0]) 
,.mac_a2accu_src_data7 (mac_a2accu_src_data7[22 -1:0]) 
,.mac_a2accu_src_data8 (mac_a2accu_src_data8[22 -1:0]) 
,.mac_a2accu_src_data9 (mac_a2accu_src_data9[22 -1:0]) 
,.mac_a2accu_src_data10 (mac_a2accu_src_data10[22 -1:0]) 
,.mac_a2accu_src_data11 (mac_a2accu_src_data11[22 -1:0]) 
,.mac_a2accu_src_data12 (mac_a2accu_src_data12[22 -1:0]) 
,.mac_a2accu_src_data13 (mac_a2accu_src_data13[22 -1:0]) 
,.mac_a2accu_src_data14 (mac_a2accu_src_data14[22 -1:0]) 
,.mac_a2accu_src_data15 (mac_a2accu_src_data15[22 -1:0]) 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_a2accu_src_pd (mac_a2accu_src_pd[8:0])
  ,.sdp_b2cvif_rd_cdt_lat_fifo_pop (sdp_b2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2cvif_rd_req_valid (sdp_b2cvif_rd_req_valid)
  ,.sdp_b2cvif_rd_req_ready (sdp_b2cvif_rd_req_ready)
  ,.sdp_b2cvif_rd_req_pd (sdp_b2cvif_rd_req_pd )
  ,.cvif2sdp_b_rd_rsp_valid (cvif2sdp_b_rd_rsp_valid)
  ,.cvif2sdp_b_rd_rsp_ready (cvif2sdp_b_rd_rsp_ready)
  ,.cvif2sdp_b_rd_rsp_pd (cvif2sdp_b_rd_rsp_pd )
  ,.sdp_e2cvif_rd_cdt_lat_fifo_pop (sdp_e2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2cvif_rd_req_valid (sdp_e2cvif_rd_req_valid)
  ,.sdp_e2cvif_rd_req_ready (sdp_e2cvif_rd_req_ready)
  ,.sdp_e2cvif_rd_req_pd (sdp_e2cvif_rd_req_pd )
  ,.cvif2sdp_e_rd_rsp_valid (cvif2sdp_e_rd_rsp_valid)
  ,.cvif2sdp_e_rd_rsp_ready (cvif2sdp_e_rd_rsp_ready)
  ,.cvif2sdp_e_rd_rsp_pd (cvif2sdp_e_rd_rsp_pd )
  ,.sdp_n2cvif_rd_cdt_lat_fifo_pop (sdp_n2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2cvif_rd_req_valid (sdp_n2cvif_rd_req_valid)
  ,.sdp_n2cvif_rd_req_ready (sdp_n2cvif_rd_req_ready)
  ,.sdp_n2cvif_rd_req_pd (sdp_n2cvif_rd_req_pd )
  ,.cvif2sdp_n_rd_rsp_valid (cvif2sdp_n_rd_rsp_valid)
  ,.cvif2sdp_n_rd_rsp_ready (cvif2sdp_n_rd_rsp_ready)
  ,.cvif2sdp_n_rd_rsp_pd (cvif2sdp_n_rd_rsp_pd )
  ,.cvif2sdp_rd_rsp_valid (cvif2sdp_rd_rsp_valid)
  ,.cvif2sdp_rd_rsp_ready (cvif2sdp_rd_rsp_ready)
  ,.cvif2sdp_rd_rsp_pd (cvif2sdp_rd_rsp_pd )
  ,.sdp2cvif_rd_cdt_lat_fifo_pop (sdp2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp2cvif_rd_req_valid (sdp2cvif_rd_req_valid)
  ,.sdp2cvif_rd_req_ready (sdp2cvif_rd_req_ready)
  ,.sdp2cvif_rd_req_pd (sdp2cvif_rd_req_pd )
  ,.sdp2cvif_wr_req_valid (sdp2cvif_wr_req_valid)
  ,.sdp2cvif_wr_req_ready (sdp2cvif_wr_req_ready)
  ,.sdp2cvif_wr_req_pd (sdp2cvif_wr_req_pd )
  ,.cvif2sdp_wr_rsp_complete (cvif2sdp_wr_rsp_complete)
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd )
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd )
  ,.sdp_e2mcif_rd_cdt_lat_fifo_pop (sdp_e2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2mcif_rd_req_valid (sdp_e2mcif_rd_req_valid)
  ,.sdp_e2mcif_rd_req_ready (sdp_e2mcif_rd_req_ready)
  ,.sdp_e2mcif_rd_req_pd (sdp_e2mcif_rd_req_pd )
  ,.mcif2sdp_e_rd_rsp_valid (mcif2sdp_e_rd_rsp_valid)
  ,.mcif2sdp_e_rd_rsp_ready (mcif2sdp_e_rd_rsp_ready)
  ,.mcif2sdp_e_rd_rsp_pd (mcif2sdp_e_rd_rsp_pd )
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd )
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd )
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd )
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.pwrbus_ram_pd (nvdla_pwrbus_ram_p_pd[31:0])
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd[33:0])
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0])
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd )
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd )
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd )
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd[33:0])
  ,.nvdla_core_clk (dla_core_clk)
  ,.dla_reset_rstn (nvdla_core_rstn)
  ,.nvdla_clk_ovr_on (nvdla_clk_ovr_on)
  );
endmodule // NV_nvdla