// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_DRAM_write.v
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
module NV_NVDLA_NOCIF_DRAM_write (
    nvdla_core_clk
   ,nvdla_core_rstn
   ,pwrbus_ram_pd
//:my $i;
//:for($i=0;$i<5;$i++) {
//:print qq(
//:,client${i}2mcif_wr_req_pd
//:,client${i}2mcif_wr_req_valid
//:,client${i}2mcif_wr_wt
//:,client${i}2mcif_wr_axid
//:,client${i}2mcif_wr_req_ready
//:,mcif2client${i}_wr_rsp_complete
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,client02mcif_wr_req_pd
,client02mcif_wr_req_valid
,client02mcif_wr_wt
,client02mcif_wr_axid
,client02mcif_wr_req_ready
,mcif2client0_wr_rsp_complete

,client12mcif_wr_req_pd
,client12mcif_wr_req_valid
,client12mcif_wr_wt
,client12mcif_wr_axid
,client12mcif_wr_req_ready
,mcif2client1_wr_rsp_complete

,client22mcif_wr_req_pd
,client22mcif_wr_req_valid
,client22mcif_wr_wt
,client22mcif_wr_axid
,client22mcif_wr_req_ready
,mcif2client2_wr_rsp_complete

,client32mcif_wr_req_pd
,client32mcif_wr_req_valid
,client32mcif_wr_wt
,client32mcif_wr_axid
,client32mcif_wr_req_ready
,mcif2client3_wr_rsp_complete

,client42mcif_wr_req_pd
,client42mcif_wr_req_valid
,client42mcif_wr_wt
,client42mcif_wr_axid
,client42mcif_wr_req_ready
,mcif2client4_wr_rsp_complete

//| eperl: generated_end (DO NOT EDIT ABOVE)
    ,reg2dp_wr_os_cnt
    ,noc2mcif_axi_b_bid //|< i
    ,noc2mcif_axi_b_bvalid //|< i
  ,mcif2noc_axi_aw_awaddr //|> o
  ,mcif2noc_axi_aw_awready //|< i
  ,mcif2noc_axi_w_wready //|< i
  ,mcif2noc_axi_aw_awid //|> o
  ,mcif2noc_axi_aw_awlen //|> o
  ,mcif2noc_axi_aw_awvalid //|> o
  ,mcif2noc_axi_w_wdata //|> o
  ,mcif2noc_axi_w_wlast //|> o
  ,mcif2noc_axi_w_wstrb //|> o
  ,mcif2noc_axi_w_wvalid //|> o
  ,noc2mcif_axi_b_bready //|> o
);
//:my $i;
//:for($i=0;$i<5;$i++) {
//:print qq(
//:input [512 +2:0] client${i}2mcif_wr_req_pd;
//:input client${i}2mcif_wr_req_valid;
//:output client${i}2mcif_wr_req_ready;
//:input [7:0] client${i}2mcif_wr_wt;
//:input [3:0] client${i}2mcif_wr_axid;
//:output mcif2client${i}_wr_rsp_complete;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [512 +2:0] client02mcif_wr_req_pd;
input client02mcif_wr_req_valid;
output client02mcif_wr_req_ready;
input [7:0] client02mcif_wr_wt;
input [3:0] client02mcif_wr_axid;
output mcif2client0_wr_rsp_complete;

input [512 +2:0] client12mcif_wr_req_pd;
input client12mcif_wr_req_valid;
output client12mcif_wr_req_ready;
input [7:0] client12mcif_wr_wt;
input [3:0] client12mcif_wr_axid;
output mcif2client1_wr_rsp_complete;

input [512 +2:0] client22mcif_wr_req_pd;
input client22mcif_wr_req_valid;
output client22mcif_wr_req_ready;
input [7:0] client22mcif_wr_wt;
input [3:0] client22mcif_wr_axid;
output mcif2client2_wr_rsp_complete;

input [512 +2:0] client32mcif_wr_req_pd;
input client32mcif_wr_req_valid;
output client32mcif_wr_req_ready;
input [7:0] client32mcif_wr_wt;
input [3:0] client32mcif_wr_axid;
output mcif2client3_wr_rsp_complete;

input [512 +2:0] client42mcif_wr_req_pd;
input client42mcif_wr_req_valid;
output client42mcif_wr_req_ready;
input [7:0] client42mcif_wr_wt;
input [3:0] client42mcif_wr_axid;
output mcif2client4_wr_rsp_complete;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_clk;
input nvdla_core_rstn;
  output mcif2noc_axi_aw_awvalid; /* data valid */
input mcif2noc_axi_aw_awready; /* data return handshake */
output [7:0] mcif2noc_axi_aw_awid;
output [3:0] mcif2noc_axi_aw_awlen;
output [64 -1:0] mcif2noc_axi_aw_awaddr;
output mcif2noc_axi_w_wvalid; /* data valid */
input mcif2noc_axi_w_wready; /* data return handshake */
output [512 -1:0] mcif2noc_axi_w_wdata;
output [(512/8)-1:0] mcif2noc_axi_w_wstrb;
output mcif2noc_axi_w_wlast;
input noc2mcif_axi_b_bvalid; /* data valid */
output noc2mcif_axi_b_bready; /* data return handshake */
input [7:0] noc2mcif_axi_b_bid;
input [7:0] reg2dp_wr_os_cnt;
input [31:0] pwrbus_ram_pd;
wire eg2ig_axi_vld;
wire [1:0] eg2ig_axi_len;
wire [3:0] cq_wr_thread_id;
wire [2:0] cq_wr_pd;
wire cq_wr_prdy;
wire cq_wr_pvld;
NV_NVDLA_NOCIF_DRAM_WRITE_ig u_ig (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.reg2dp_wr_os_cnt (reg2dp_wr_os_cnt)
//:my $i;
//:for($i=0;$i<5;$i++) {
//:print qq(
//:,.client${i}2mcif_wr_req_valid(client${i}2mcif_wr_req_valid)
//:,.client${i}2mcif_wr_req_ready(client${i}2mcif_wr_req_ready)
//:,.client${i}2mcif_wr_req_pd(client${i}2mcif_wr_req_pd)
//:,.client${i}2mcif_wr_wt(client${i}2mcif_wr_wt)
//:,.client${i}2mcif_wr_axid(client${i}2mcif_wr_axid)
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.client02mcif_wr_req_valid(client02mcif_wr_req_valid)
,.client02mcif_wr_req_ready(client02mcif_wr_req_ready)
,.client02mcif_wr_req_pd(client02mcif_wr_req_pd)
,.client02mcif_wr_wt(client02mcif_wr_wt)
,.client02mcif_wr_axid(client02mcif_wr_axid)

,.client12mcif_wr_req_valid(client12mcif_wr_req_valid)
,.client12mcif_wr_req_ready(client12mcif_wr_req_ready)
,.client12mcif_wr_req_pd(client12mcif_wr_req_pd)
,.client12mcif_wr_wt(client12mcif_wr_wt)
,.client12mcif_wr_axid(client12mcif_wr_axid)

,.client22mcif_wr_req_valid(client22mcif_wr_req_valid)
,.client22mcif_wr_req_ready(client22mcif_wr_req_ready)
,.client22mcif_wr_req_pd(client22mcif_wr_req_pd)
,.client22mcif_wr_wt(client22mcif_wr_wt)
,.client22mcif_wr_axid(client22mcif_wr_axid)

,.client32mcif_wr_req_valid(client32mcif_wr_req_valid)
,.client32mcif_wr_req_ready(client32mcif_wr_req_ready)
,.client32mcif_wr_req_pd(client32mcif_wr_req_pd)
,.client32mcif_wr_wt(client32mcif_wr_wt)
,.client32mcif_wr_axid(client32mcif_wr_axid)

,.client42mcif_wr_req_valid(client42mcif_wr_req_valid)
,.client42mcif_wr_req_ready(client42mcif_wr_req_ready)
,.client42mcif_wr_req_pd(client42mcif_wr_req_pd)
,.client42mcif_wr_wt(client42mcif_wr_wt)
,.client42mcif_wr_axid(client42mcif_wr_axid)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.cq_wr_pvld (cq_wr_pvld) //|> w
  ,.cq_wr_prdy (cq_wr_prdy) //|< w
  ,.cq_wr_thread_id (cq_wr_thread_id[3:0]) //|> w
  ,.cq_wr_pd (cq_wr_pd[2:0]) //|> w
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (mcif2noc_axi_aw_awid[7:0]) //|> o
  ,.mcif2noc_axi_aw_awlen (mcif2noc_axi_aw_awlen[3:0]) //|> o
  ,.mcif2noc_axi_aw_awaddr (mcif2noc_axi_aw_awaddr[64 -1:0]) //|> o
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (mcif2noc_axi_w_wdata) //|> o
  ,.mcif2noc_axi_w_wstrb (mcif2noc_axi_w_wstrb[(512/8)-1:0]) //|> o
  ,.mcif2noc_axi_w_wlast (mcif2noc_axi_w_wlast) //|> o
  ,.eg2ig_axi_len (eg2ig_axi_len[1:0]) //|< w
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|< w
);
//:my $i;
//:for($i=0;$i<5;$i++) {
//:print qq(
//:wire [2:0] cq_rd${i}_pd;
//:wire cq_rd${i}_pvld;
//:wire cq_rd${i}_prdy;
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [2:0] cq_rd0_pd;
wire cq_rd0_pvld;
wire cq_rd0_prdy;

wire [2:0] cq_rd1_pd;
wire cq_rd1_pvld;
wire cq_rd1_prdy;

wire [2:0] cq_rd2_pd;
wire cq_rd2_pvld;
wire cq_rd2_prdy;

wire [2:0] cq_rd3_pd;
wire cq_rd3_pvld;
wire cq_rd3_prdy;

wire [2:0] cq_rd4_pd;
wire cq_rd4_pvld;
wire cq_rd4_prdy;

//| eperl: generated_end (DO NOT EDIT ABOVE)
NV_NVDLA_NOCIF_DRAM_WRITE_eg u_eg (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
//:my $i;
//:for($i=0;$i<5;$i++) {
//:print qq(
//:,.mcif2client${i}_wr_rsp_complete(mcif2client${i}_wr_rsp_complete)
//:);
//:}
//:for($i=0;$i<5;$i++) {
//:print qq(
//:,.cq_rd${i}_pd (cq_rd${i}_pd) //|< w
//:,.cq_rd${i}_pvld (cq_rd${i}_pvld) //|< w
//:,.cq_rd${i}_prdy (cq_rd${i}_prdy) //|> w
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mcif2client0_wr_rsp_complete(mcif2client0_wr_rsp_complete)

,.mcif2client1_wr_rsp_complete(mcif2client1_wr_rsp_complete)

,.mcif2client2_wr_rsp_complete(mcif2client2_wr_rsp_complete)

,.mcif2client3_wr_rsp_complete(mcif2client3_wr_rsp_complete)

,.mcif2client4_wr_rsp_complete(mcif2client4_wr_rsp_complete)

,.cq_rd0_pd (cq_rd0_pd) //|< w
,.cq_rd0_pvld (cq_rd0_pvld) //|< w
,.cq_rd0_prdy (cq_rd0_prdy) //|> w

,.cq_rd1_pd (cq_rd1_pd) //|< w
,.cq_rd1_pvld (cq_rd1_pvld) //|< w
,.cq_rd1_prdy (cq_rd1_prdy) //|> w

,.cq_rd2_pd (cq_rd2_pd) //|< w
,.cq_rd2_pvld (cq_rd2_pvld) //|< w
,.cq_rd2_prdy (cq_rd2_prdy) //|> w

,.cq_rd3_pd (cq_rd3_pd) //|< w
,.cq_rd3_pvld (cq_rd3_pvld) //|< w
,.cq_rd3_prdy (cq_rd3_prdy) //|> w

,.cq_rd4_pd (cq_rd4_pd) //|< w
,.cq_rd4_pvld (cq_rd4_pvld) //|< w
,.cq_rd4_prdy (cq_rd4_prdy) //|> w

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.noc2mcif_axi_b_bvalid (noc2mcif_axi_b_bvalid) //|< i
  ,.noc2mcif_axi_b_bready (noc2mcif_axi_b_bready) //|> o
  ,.noc2mcif_axi_b_bid (noc2mcif_axi_b_bid[7:0]) //|< i
  ,.eg2ig_axi_len (eg2ig_axi_len[1:0]) //|> w
  ,.eg2ig_axi_vld (eg2ig_axi_vld) //|> w
  );
NV_NVDLA_NOCIF_DRAM_WRITE_cq u_cq (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.cq_wr_prdy (cq_wr_prdy) //|> w
  ,.cq_wr_pvld (cq_wr_pvld) //|< w
  ,.cq_wr_thread_id (cq_wr_thread_id[2:0]) //|< w
  ,.cq_wr_pd (cq_wr_pd[2:0]) //|< w
//:my $i;
//:for($i=0;$i<5;$i++) {
//:print qq(
//:,.cq_rd${i}_pd (cq_rd${i}_pd) //|< w
//:,.cq_rd${i}_pvld (cq_rd${i}_pvld) //|< w
//:,.cq_rd${i}_prdy (cq_rd${i}_prdy) //|> w
//:);
//:}
//:my $i;
//:for($i=5;$i<5;$i++) {
//:print qq(
//:,.cq_rd${i}_prdy (1'b1) //|< w
//:);
//:}
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.cq_rd0_pd (cq_rd0_pd) //|< w
,.cq_rd0_pvld (cq_rd0_pvld) //|< w
,.cq_rd0_prdy (cq_rd0_prdy) //|> w

,.cq_rd1_pd (cq_rd1_pd) //|< w
,.cq_rd1_pvld (cq_rd1_pvld) //|< w
,.cq_rd1_prdy (cq_rd1_prdy) //|> w

,.cq_rd2_pd (cq_rd2_pd) //|< w
,.cq_rd2_pvld (cq_rd2_pvld) //|< w
,.cq_rd2_prdy (cq_rd2_prdy) //|> w

,.cq_rd3_pd (cq_rd3_pd) //|< w
,.cq_rd3_pvld (cq_rd3_pvld) //|< w
,.cq_rd3_prdy (cq_rd3_prdy) //|> w

,.cq_rd4_pd (cq_rd4_pd) //|< w
,.cq_rd4_pvld (cq_rd4_pvld) //|< w
,.cq_rd4_prdy (cq_rd4_prdy) //|> w

//| eperl: generated_end (DO NOT EDIT ABOVE)
);
endmodule