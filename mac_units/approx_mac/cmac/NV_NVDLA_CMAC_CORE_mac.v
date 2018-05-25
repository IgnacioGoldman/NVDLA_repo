// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================

// File Name: mac.v

module NV_NVDLA_CMAC_CORE_mac (
   nvdla_core_clk     //|< i
  ,nvdla_wg_clk       //|< i
  ,nvdla_core_rstn    //|< i
  ,cfg_is_fp16        //|< i
  ,cfg_is_int16       //|< i
  ,cfg_is_int8        //|< i
  ,cfg_is_wg          //|< i
  ,cfg_reg_en         //|< i
  ,dat_actv_data      //|< i
  ,dat_actv_nan       //|< i
  ,dat_actv_nz        //|< i
  ,dat_actv_pvld      //|< i
  ,dat_pre_exp        //|< i
  ,dat_pre_mask       //|< i
  ,dat_pre_pvld       //|< i
  ,dat_pre_stripe_end //|< i
  ,dat_pre_stripe_st  //|< i
  ,wt_actv_data       //|< i
  ,wt_actv_nan        //|< i
  ,wt_actv_nz         //|< i
  ,wt_actv_pvld       //|< i
  ,wt_sd_exp          //|< i
  ,wt_sd_mask         //|< i
  ,wt_sd_pvld         //|< i
  ,mac_out_data       //|> o
  ,mac_out_nan        //|> o
  ,mac_out_pvld       //|> o
  );

input           nvdla_core_clk;
input           nvdla_wg_clk;
input           nvdla_core_rstn;
input           cfg_is_fp16;
input           cfg_is_int16;
input           cfg_is_int8;
input           cfg_is_wg;
input           cfg_reg_en;
input  [1023:0] dat_actv_data;
input    [63:0] dat_actv_nan;
input   [127:0] dat_actv_nz;
input   [103:0] dat_actv_pvld;
input   [191:0] dat_pre_exp;
input    [63:0] dat_pre_mask;
input           dat_pre_pvld;
input           dat_pre_stripe_end;
input           dat_pre_stripe_st;
input  [1023:0] wt_actv_data;
input    [63:0] wt_actv_nan;
input   [127:0] wt_actv_nz;
input   [103:0] wt_actv_pvld;
input   [191:0] wt_sd_exp;
input    [63:0] wt_sd_mask;
input           wt_sd_pvld;
output  [175:0] mac_out_data;
output reg      mac_out_nan;
output reg      mac_out_pvld;
wire     [31:0] mult_res_00;
wire     [31:0] mult_res_01;
wire     [31:0] mult_res_02;
wire     [31:0] mult_res_03;
wire     [31:0] mult_res_04;
wire     [31:0] mult_res_05;
wire     [31:0] mult_res_06;
wire     [31:0] mult_res_07;
wire     [31:0] mult_res_08;
wire     [31:0] mult_res_09;
wire     [31:0] mult_res_10;
wire     [31:0] mult_res_11;
wire     [31:0] mult_res_12;
wire     [31:0] mult_res_13;
wire     [31:0] mult_res_14;
wire     [31:0] mult_res_15;
wire     [31:0] mult_res_16;
wire     [31:0] mult_res_17;
wire     [31:0] mult_res_18;
wire     [31:0] mult_res_19;
wire     [31:0] mult_res_20;
wire     [31:0] mult_res_21;
wire     [31:0] mult_res_22;
wire     [31:0] mult_res_23;
wire     [31:0] mult_res_24;
wire     [31:0] mult_res_25;
wire     [31:0] mult_res_26;
wire     [31:0] mult_res_27;
wire     [31:0] mult_res_28;
wire     [31:0] mult_res_29;
wire     [31:0] mult_res_30;
wire     [31:0] mult_res_31;
wire     [31:0] mult_res_32;
wire     [31:0] mult_res_33;
wire     [31:0] mult_res_34;
wire     [31:0] mult_res_35;
wire     [31:0] mult_res_36;
wire     [31:0] mult_res_37;
wire     [31:0] mult_res_38;
wire     [31:0] mult_res_39;
wire     [31:0] mult_res_40;
wire     [31:0] mult_res_41;
wire     [31:0] mult_res_42;
wire     [31:0] mult_res_43;
wire     [31:0] mult_res_44;
wire     [31:0] mult_res_45;
wire     [31:0] mult_res_46;
wire     [31:0] mult_res_47;
wire     [31:0] mult_res_48;
wire     [31:0] mult_res_49;
wire     [31:0] mult_res_50;
wire     [31:0] mult_res_51;
wire     [31:0] mult_res_52;
wire     [31:0] mult_res_53;
wire     [31:0] mult_res_54;
wire     [31:0] mult_res_55;
wire     [31:0] mult_res_56;
wire     [31:0] mult_res_57;
wire     [31:0] mult_res_58;
wire     [31:0] mult_res_59;
wire     [31:0] mult_res_60;
wire     [31:0] mult_res_61;
wire     [31:0] mult_res_62;
wire     [31:0] mult_res_63;
reg      [43:0] sign_ext_mult_res_00;
reg      [43:0] sign_ext_mult_res_01;
reg      [43:0] sign_ext_mult_res_02;
reg      [43:0] sign_ext_mult_res_03;
reg      [43:0] sign_ext_mult_res_04;
reg      [43:0] sign_ext_mult_res_05;
reg      [43:0] sign_ext_mult_res_06;
reg      [43:0] sign_ext_mult_res_07;
reg      [43:0] sign_ext_mult_res_08;
reg      [43:0] sign_ext_mult_res_09;
reg      [43:0] sign_ext_mult_res_10;
reg      [43:0] sign_ext_mult_res_11;
reg      [43:0] sign_ext_mult_res_12;
reg      [43:0] sign_ext_mult_res_13;
reg      [43:0] sign_ext_mult_res_14;
reg      [43:0] sign_ext_mult_res_15;
reg      [43:0] sign_ext_mult_res_16;
reg      [43:0] sign_ext_mult_res_17;
reg      [43:0] sign_ext_mult_res_18;
reg      [43:0] sign_ext_mult_res_19;
reg      [43:0] sign_ext_mult_res_20;
reg      [43:0] sign_ext_mult_res_21;
reg      [43:0] sign_ext_mult_res_22;
reg      [43:0] sign_ext_mult_res_23;
reg      [43:0] sign_ext_mult_res_24;
reg      [43:0] sign_ext_mult_res_25;
reg      [43:0] sign_ext_mult_res_26;
reg      [43:0] sign_ext_mult_res_27;
reg      [43:0] sign_ext_mult_res_28;
reg      [43:0] sign_ext_mult_res_29;
reg      [43:0] sign_ext_mult_res_30;
reg      [43:0] sign_ext_mult_res_31;

reg      [43:0] sign_ext_mult_res_32;
reg      [43:0] sign_ext_mult_res_33;
reg      [43:0] sign_ext_mult_res_34;
reg      [43:0] sign_ext_mult_res_35;
reg      [43:0] sign_ext_mult_res_36;
reg      [43:0] sign_ext_mult_res_37;
reg      [43:0] sign_ext_mult_res_38;
reg      [43:0] sign_ext_mult_res_39;
reg      [43:0] sign_ext_mult_res_40;
reg      [43:0] sign_ext_mult_res_41;
reg      [43:0] sign_ext_mult_res_42;
reg      [43:0] sign_ext_mult_res_43;
reg      [43:0] sign_ext_mult_res_44;
reg      [43:0] sign_ext_mult_res_45;
reg      [43:0] sign_ext_mult_res_46;
reg      [43:0] sign_ext_mult_res_47;
reg      [43:0] sign_ext_mult_res_48;
reg      [43:0] sign_ext_mult_res_49;
reg      [43:0] sign_ext_mult_res_50;
reg      [43:0] sign_ext_mult_res_51;
reg      [43:0] sign_ext_mult_res_52;
reg      [43:0] sign_ext_mult_res_53;
reg      [43:0] sign_ext_mult_res_54;
reg      [43:0] sign_ext_mult_res_55;
reg      [43:0] sign_ext_mult_res_56;
reg      [43:0] sign_ext_mult_res_57;
reg      [43:0] sign_ext_mult_res_58;
reg      [43:0] sign_ext_mult_res_59;
reg      [43:0] sign_ext_mult_res_60;
reg      [43:0] sign_ext_mult_res_61;
reg      [43:0] sign_ext_mult_res_62;
reg      [43:0] sign_ext_mult_res_63;


reg      [15:0] dat_actv_data0;
reg      [15:0] dat_actv_data1;
reg      [15:0] dat_actv_data10;
reg      [15:0] dat_actv_data11;
reg      [15:0] dat_actv_data12;
reg      [15:0] dat_actv_data13;
reg      [15:0] dat_actv_data14;
reg      [15:0] dat_actv_data15;
reg      [15:0] dat_actv_data16;
reg      [15:0] dat_actv_data17;
reg      [15:0] dat_actv_data18;
reg      [15:0] dat_actv_data19;
reg      [15:0] dat_actv_data2;
reg      [15:0] dat_actv_data20;
reg      [15:0] dat_actv_data21;
reg      [15:0] dat_actv_data22;
reg      [15:0] dat_actv_data23;
reg      [15:0] dat_actv_data24;
reg      [15:0] dat_actv_data25;
reg      [15:0] dat_actv_data26;
reg      [15:0] dat_actv_data27;
reg      [15:0] dat_actv_data28;
reg      [15:0] dat_actv_data29;
reg      [15:0] dat_actv_data3;
reg      [15:0] dat_actv_data30;
reg      [15:0] dat_actv_data31;
reg      [15:0] dat_actv_data32;
reg      [15:0] dat_actv_data33;
reg      [15:0] dat_actv_data34;
reg      [15:0] dat_actv_data35;
reg      [15:0] dat_actv_data36;
reg      [15:0] dat_actv_data37;
reg      [15:0] dat_actv_data38;
reg      [15:0] dat_actv_data39;
reg      [15:0] dat_actv_data4;
reg      [15:0] dat_actv_data40;
reg      [15:0] dat_actv_data41;
reg      [15:0] dat_actv_data42;
reg      [15:0] dat_actv_data43;
reg      [15:0] dat_actv_data44;
reg      [15:0] dat_actv_data45;
reg      [15:0] dat_actv_data46;
reg      [15:0] dat_actv_data47;
reg      [15:0] dat_actv_data48;
reg      [15:0] dat_actv_data49;
reg      [15:0] dat_actv_data5;
reg      [15:0] dat_actv_data50;
reg      [15:0] dat_actv_data51;
reg      [15:0] dat_actv_data52;
reg      [15:0] dat_actv_data53;
reg      [15:0] dat_actv_data54;
reg      [15:0] dat_actv_data55;
reg      [15:0] dat_actv_data56;
reg      [15:0] dat_actv_data57;
reg      [15:0] dat_actv_data58;
reg      [15:0] dat_actv_data59;
reg      [15:0] dat_actv_data6;
reg      [15:0] dat_actv_data60;
reg      [15:0] dat_actv_data61;
reg      [15:0] dat_actv_data62;
reg      [15:0] dat_actv_data63;
reg      [15:0] dat_actv_data7;
reg      [15:0] dat_actv_data8;
reg      [15:0] dat_actv_data9;
reg     [175:0] mac_out_data;
reg     [175:0] mac_out_data_w;
reg     [175:0] mac_out_data_w1;
reg     [175:0] mac_out_data_w2;
reg     [43:0] temp0;
reg     [43:0] temp1;
reg     [43:0] temp2;
reg     [43:0] temp3;
reg     [43:0] temp4;
reg     [43:0] temp5;
reg     [43:0] temp6;
reg     [43:0] temp7;
reg     [43:0] temp8;
reg     [43:0] temp9;
reg     [43:0] temp10;
reg     [43:0] temp11;
reg     [43:0] temp12;
reg     [43:0] temp13;
reg     [43:0] temp14;
reg     [43:0] temp15;

reg     [43:0] temp16;
reg     [43:0] temp17;
reg     [43:0] temp18;
reg     [43:0] temp19;
reg     [43:0] temp20;
reg     [43:0] temp21;
reg     [43:0] temp22;
reg     [43:0] temp23;
reg     [43:0] temp24;
reg     [43:0] temp25;
reg     [43:0] temp26;
reg     [43:0] temp27;
reg     [43:0] temp28;
reg     [43:0] temp29;
reg     [43:0] temp30;
reg     [43:0] temp31;

reg     [43:0] tempsec0;
reg     [43:0] tempsec1;
reg     [43:0] tempsec2;
reg     [43:0] tempsec3;
reg     [43:0] tempsec4;
reg     [43:0] tempsec5;
reg     [43:0] tempsec6;
reg     [43:0] tempsec7;

reg     [43:0] tempsec8;
reg     [43:0] tempsec9;
reg     [43:0] tempsec10;
reg     [43:0] tempsec11;
reg     [43:0] tempsec12;
reg     [43:0] tempsec13;
reg     [43:0] tempsec14;
reg     [43:0] tempsec15;

reg     [43:0] tempter0;
reg     [43:0] tempter1;
reg     [43:0] tempter2;
reg     [43:0] tempter3;

reg     [43:0] tempter4;
reg     [43:0] tempter5;
reg     [43:0] tempter6;
reg     [43:0] tempter7;

reg     [43:0] tempcua0;
reg     [43:0] tempcua1;

reg     [43:0] tempcua2;
reg     [43:0] tempcua3;

reg     [43:0] tempqui0;
reg     [43:0] tempqui1;

reg     [43:0] tempsect0;



reg      [15:0] wt_actv_data0;
reg      [15:0] wt_actv_data1;
reg      [15:0] wt_actv_data10;
reg      [15:0] wt_actv_data11;
reg      [15:0] wt_actv_data12;
reg      [15:0] wt_actv_data13;
reg      [15:0] wt_actv_data14;
reg      [15:0] wt_actv_data15;
reg      [15:0] wt_actv_data16;
reg      [15:0] wt_actv_data17;
reg      [15:0] wt_actv_data18;
reg      [15:0] wt_actv_data19;
reg      [15:0] wt_actv_data2;
reg      [15:0] wt_actv_data20;
reg      [15:0] wt_actv_data21;
reg      [15:0] wt_actv_data22;
reg      [15:0] wt_actv_data23;
reg      [15:0] wt_actv_data24;
reg      [15:0] wt_actv_data25;
reg      [15:0] wt_actv_data26;
reg      [15:0] wt_actv_data27;
reg      [15:0] wt_actv_data28;
reg      [15:0] wt_actv_data29;
reg      [15:0] wt_actv_data3;
reg      [15:0] wt_actv_data30;
reg      [15:0] wt_actv_data31;
reg      [15:0] wt_actv_data32;
reg      [15:0] wt_actv_data33;
reg      [15:0] wt_actv_data34;
reg      [15:0] wt_actv_data35;
reg      [15:0] wt_actv_data36;
reg      [15:0] wt_actv_data37;
reg      [15:0] wt_actv_data38;
reg      [15:0] wt_actv_data39;
reg      [15:0] wt_actv_data4;
reg      [15:0] wt_actv_data40;
reg      [15:0] wt_actv_data41;
reg      [15:0] wt_actv_data42;
reg      [15:0] wt_actv_data43;
reg      [15:0] wt_actv_data44;
reg      [15:0] wt_actv_data45;
reg      [15:0] wt_actv_data46;
reg      [15:0] wt_actv_data47;
reg      [15:0] wt_actv_data48;
reg      [15:0] wt_actv_data49;
reg      [15:0] wt_actv_data5;
reg      [15:0] wt_actv_data50;
reg      [15:0] wt_actv_data51;
reg      [15:0] wt_actv_data52;
reg      [15:0] wt_actv_data53;
reg      [15:0] wt_actv_data54;
reg      [15:0] wt_actv_data55;
reg      [15:0] wt_actv_data56;
reg      [15:0] wt_actv_data57;
reg      [15:0] wt_actv_data58;
reg      [15:0] wt_actv_data59;
reg      [15:0] wt_actv_data6;
reg      [15:0] wt_actv_data60;
reg      [15:0] wt_actv_data61;
reg      [15:0] wt_actv_data62;
reg      [15:0] wt_actv_data63;
reg      [15:0] wt_actv_data7;
reg      [15:0] wt_actv_data8;
reg      [15:0] wt_actv_data9;

reg enable;
reg edge_of_pvld;
reg [43:0] a1;
reg [43:0] w2nonX;
//==========================================================

//==========================================================
// Single multiplication instances
//==========================================================


always @(
  wt_actv_data
  ) begin
    {wt_actv_data63, wt_actv_data62, wt_actv_data61, wt_actv_data60, wt_actv_data59, wt_actv_data58, wt_actv_data57, wt_actv_data56, wt_actv_data55, wt_actv_data54, wt_actv_data53, wt_actv_data52, wt_actv_data51, wt_actv_data50, wt_actv_data49, wt_actv_data48, wt_actv_data47, wt_actv_data46, wt_actv_data45, wt_actv_data44, wt_actv_data43, wt_actv_data42, wt_actv_data41, wt_actv_data40, wt_actv_data39, wt_actv_data38, wt_actv_data37, wt_actv_data36, wt_actv_data35, wt_actv_data34, wt_actv_data33, wt_actv_data32, wt_actv_data31, wt_actv_data30, wt_actv_data29, wt_actv_data28, wt_actv_data27, wt_actv_data26, wt_actv_data25, wt_actv_data24, wt_actv_data23, wt_actv_data22, wt_actv_data21, wt_actv_data20, wt_actv_data19, wt_actv_data18, wt_actv_data17, wt_actv_data16, wt_actv_data15, wt_actv_data14, wt_actv_data13, wt_actv_data12, wt_actv_data11, wt_actv_data10, wt_actv_data9, wt_actv_data8, wt_actv_data7, wt_actv_data6, wt_actv_data5, wt_actv_data4, wt_actv_data3, wt_actv_data2, wt_actv_data1, wt_actv_data0} = wt_actv_data;
end

always @(
  dat_actv_data
  ) begin
    {dat_actv_data63, dat_actv_data62, dat_actv_data61, dat_actv_data60, dat_actv_data59, dat_actv_data58, dat_actv_data57, dat_actv_data56, dat_actv_data55, dat_actv_data54, dat_actv_data53, dat_actv_data52, dat_actv_data51, dat_actv_data50, dat_actv_data49, dat_actv_data48, dat_actv_data47, dat_actv_data46, dat_actv_data45, dat_actv_data44, dat_actv_data43, dat_actv_data42, dat_actv_data41, dat_actv_data40, dat_actv_data39, dat_actv_data38, dat_actv_data37, dat_actv_data36, dat_actv_data35, dat_actv_data34, dat_actv_data33, dat_actv_data32, dat_actv_data31, dat_actv_data30, dat_actv_data29, dat_actv_data28, dat_actv_data27, dat_actv_data26, dat_actv_data25, dat_actv_data24, dat_actv_data23, dat_actv_data22, dat_actv_data21, dat_actv_data20, dat_actv_data19, dat_actv_data18, dat_actv_data17, dat_actv_data16, dat_actv_data15, dat_actv_data14, dat_actv_data13, dat_actv_data12, dat_actv_data11, dat_actv_data10, dat_actv_data9, dat_actv_data8, dat_actv_data7, dat_actv_data6, dat_actv_data5, dat_actv_data4, dat_actv_data3, dat_actv_data2, dat_actv_data1, dat_actv_data0} = dat_actv_data;
end
/*
always @(
  wt_actv_nz
  ) begin
    {wt_actv_nz63, wt_actv_nz62, wt_actv_nz61, wt_actv_nz60, wt_actv_nz59, wt_actv_nz58, wt_actv_nz57, wt_actv_nz56, wt_actv_nz55, wt_actv_nz54, wt_actv_nz53, wt_actv_nz52, wt_actv_nz51, wt_actv_nz50, wt_actv_nz49, wt_actv_nz48, wt_actv_nz47, wt_actv_nz46, wt_actv_nz45, wt_actv_nz44, wt_actv_nz43, wt_actv_nz42, wt_actv_nz41, wt_actv_nz40, wt_actv_nz39, wt_actv_nz38, wt_actv_nz37, wt_actv_nz36, wt_actv_nz35, wt_actv_nz34, wt_actv_nz33, wt_actv_nz32, wt_actv_nz31, wt_actv_nz30, wt_actv_nz29, wt_actv_nz28, wt_actv_nz27, wt_actv_nz26, wt_actv_nz25, wt_actv_nz24, wt_actv_nz23, wt_actv_nz22, wt_actv_nz21, wt_actv_nz20, wt_actv_nz19, wt_actv_nz18, wt_actv_nz17, wt_actv_nz16, wt_actv_nz15, wt_actv_nz14, wt_actv_nz13, wt_actv_nz12, wt_actv_nz11, wt_actv_nz10, wt_actv_nz9, wt_actv_nz8, wt_actv_nz7, wt_actv_nz6, wt_actv_nz5, wt_actv_nz4, wt_actv_nz3, wt_actv_nz2, wt_actv_nz1, wt_actv_nz0} = wt_actv_nz;
end

always @(
  dat_actv_nz
  ) begin
    {dat_actv_nz63, dat_actv_nz62, dat_actv_nz61, dat_actv_nz60, dat_actv_nz59, dat_actv_nz58, dat_actv_nz57, dat_actv_nz56, dat_actv_nz55, dat_actv_nz54, dat_actv_nz53, dat_actv_nz52, dat_actv_nz51, dat_actv_nz50, dat_actv_nz49, dat_actv_nz48, dat_actv_nz47, dat_actv_nz46, dat_actv_nz45, dat_actv_nz44, dat_actv_nz43, dat_actv_nz42, dat_actv_nz41, dat_actv_nz40, dat_actv_nz39, dat_actv_nz38, dat_actv_nz37, dat_actv_nz36, dat_actv_nz35, dat_actv_nz34, dat_actv_nz33, dat_actv_nz32, dat_actv_nz31, dat_actv_nz30, dat_actv_nz29, dat_actv_nz28, dat_actv_nz27, dat_actv_nz26, dat_actv_nz25, dat_actv_nz24, dat_actv_nz23, dat_actv_nz22, dat_actv_nz21, dat_actv_nz20, dat_actv_nz19, dat_actv_nz18, dat_actv_nz17, dat_actv_nz16, dat_actv_nz15, dat_actv_nz14, dat_actv_nz13, dat_actv_nz12, dat_actv_nz11, dat_actv_nz10, dat_actv_nz9, dat_actv_nz8, dat_actv_nz7, dat_actv_nz6, dat_actv_nz5, dat_actv_nz4, dat_actv_nz3, dat_actv_nz2, dat_actv_nz1, dat_actv_nz0} = dat_actv_nz;
end
*/
mult16 u_mul_0 (
  .a                  (wt_actv_data0[15:0])   //|< r
  ,.b                 (dat_actv_data0[15:0])  //|< r
  ,.out               (mult_res_00[31:0])     //|> w
  );
mult16 u_mul_1 (
  .a                  (wt_actv_data1[15:0])   //|< r
  ,.b                 (dat_actv_data1[15:0])  //|< r
  ,.out               (mult_res_01[31:0])     //|> w
  );
mult16 u_mul_2 (
  .a                  (wt_actv_data2[15:0])   //|< r
  ,.b                 (dat_actv_data2[15:0])  //|< r
  ,.out               (mult_res_02[31:0])     //|> w
  );
mult16 u_mul_3 (
  .a                  (wt_actv_data3[15:0])   //|< r
  ,.b                 (dat_actv_data3[15:0])  //|< r
  ,.out               (mult_res_03[31:0])     //|> w
  );
mult16 u_mul_4 (
  .a                  (wt_actv_data4[15:0])   //|< r
  ,.b                 (dat_actv_data4[15:0])  //|< r
  ,.out               (mult_res_04[31:0])     //|> w
  );
mult16 u_mul_5 (
  .a                  (wt_actv_data5[15:0])   //|< r
  ,.b                 (dat_actv_data5[15:0])  //|< r
  ,.out               (mult_res_05[31:0])     //|> w
  );
mult16 u_mul_6 (
  .a                  (wt_actv_data6[15:0])   //|< r
  ,.b                 (dat_actv_data6[15:0])  //|< r
  ,.out               (mult_res_06[31:0])     //|> w
  );
mult16 u_mul_7 (
  .a                  (wt_actv_data7[15:0])   //|< r
  ,.b                 (dat_actv_data7[15:0])  //|< r
  ,.out               (mult_res_07[31:0])     //|> w
  );
mult16 u_mul_8 (
  .a                  (wt_actv_data8[15:0])   //|< r
  ,.b                 (dat_actv_data8[15:0])  //|< r
  ,.out               (mult_res_08[31:0])     //|> w
  );
mult16 u_mul_9 (
  .a                  (wt_actv_data9[15:0])   //|< r
  ,.b                 (dat_actv_data9[15:0])  //|< r
  ,.out               (mult_res_09[31:0])     //|> w
  );
mult16 u_mul_10 (
  .a                  (wt_actv_data10[15:0])   //|< r
  ,.b                 (dat_actv_data10[15:0])  //|< r
  ,.out               (mult_res_10[31:0])     //|> w
  );
mult16 u_mul_11 (
  .a                  (wt_actv_data11[15:0])   //|< r
  ,.b                 (dat_actv_data11[15:0])  //|< r
  ,.out               (mult_res_11[31:0])     //|> w
  );
mult16 u_mul_12 (
  .a                  (wt_actv_data12[15:0])   //|< r
  ,.b                 (dat_actv_data12[15:0])  //|< r
  ,.out               (mult_res_12[31:0])     //|> w
  );
mult16 u_mul_13 (
  .a                  (wt_actv_data13[15:0])   //|< r
  ,.b                 (dat_actv_data13[15:0])  //|< r
  ,.out               (mult_res_13[31:0])     //|> w
  );
mult16 u_mul_14 (
  .a                  (wt_actv_data14[15:0])   //|< r
  ,.b                 (dat_actv_data14[15:0])  //|< r
  ,.out               (mult_res_14[31:0])     //|> w
  );
mult16 u_mul_15 (
  .a                  (wt_actv_data15[15:0])   //|< r
  ,.b                 (dat_actv_data15[15:0])  //|< r
  ,.out               (mult_res_15[31:0])     //|> w
  );
mult16 u_mul_16 (
  .a                  (wt_actv_data16[15:0])   //|< r
  ,.b                 (dat_actv_data16[15:0])  //|< r
  ,.out               (mult_res_16[31:0])     //|> w
  );
mult16 u_mul_17 (
  .a                  (wt_actv_data17[15:0])   //|< r
  ,.b                 (dat_actv_data17[15:0])  //|< r
  ,.out               (mult_res_17[31:0])     //|> w
  );
mult16 u_mul_18 (
  .a                  (wt_actv_data18[15:0])   //|< r
  ,.b                 (dat_actv_data18[15:0])  //|< r
  ,.out               (mult_res_18[31:0])     //|> w
  );
mult16 u_mul_19 (
  .a                  (wt_actv_data19[15:0])   //|< r
  ,.b                 (dat_actv_data19[15:0])  //|< r
  ,.out               (mult_res_19[31:0])     //|> w
  );
mult16 u_mul_20 (
  .a                  (wt_actv_data20[15:0])   //|< r
  ,.b                 (dat_actv_data20[15:0])  //|< r
  ,.out               (mult_res_20[31:0])     //|> w
  );
mult16 u_mul_21 (
  .a                  (wt_actv_data21[15:0])   //|< r
  ,.b                 (dat_actv_data21[15:0])  //|< r
  ,.out               (mult_res_21[31:0])     //|> w
  );
mult16 u_mul_22 (
  .a                  (wt_actv_data22[15:0])   //|< r
  ,.b                 (dat_actv_data22[15:0])  //|< r
  ,.out               (mult_res_22[31:0])     //|> w
  );
mult16 u_mul_23 (
  .a                  (wt_actv_data23[15:0])   //|< r
  ,.b                 (dat_actv_data23[15:0])  //|< r
  ,.out               (mult_res_23[31:0])     //|> w
  );
mult16 u_mul_24 (
  .a                  (wt_actv_data24[15:0])   //|< r
  ,.b                 (dat_actv_data24[15:0])  //|< r
  ,.out               (mult_res_24[31:0])     //|> w
  );
mult16 u_mul_25 (
  .a                  (wt_actv_data25[15:0])   //|< r
  ,.b                 (dat_actv_data25[15:0])  //|< r
  ,.out               (mult_res_25[31:0])     //|> w
  );
mult16 u_mul_26 (
  .a                  (wt_actv_data26[15:0])   //|< r
  ,.b                 (dat_actv_data26[15:0])  //|< r
  ,.out               (mult_res_26[31:0])     //|> w
  );
mult16 u_mul_27 (
  .a                  (wt_actv_data27[15:0])   //|< r
  ,.b                 (dat_actv_data27[15:0])  //|< r
  ,.out               (mult_res_27[31:0])     //|> w
  );
mult16 u_mul_28 (
  .a                  (wt_actv_data28[15:0])   //|< r
  ,.b                 (dat_actv_data28[15:0])  //|< r
  ,.out               (mult_res_28[31:0])     //|> w
  );
mult16 u_mul_29 (
  .a                  (wt_actv_data29[15:0])   //|< r
  ,.b                 (dat_actv_data29[15:0])  //|< r
  ,.out               (mult_res_29[31:0])     //|> w
  );
mult16 u_mul_30 (
  .a                  (wt_actv_data30[15:0])   //|< r
  ,.b                 (dat_actv_data30[15:0])  //|< r
  ,.out               (mult_res_30[31:0])     //|> w
  );
mult16 u_mul_31 (
  .a                  (wt_actv_data31[15:0])   //|< r
  ,.b                 (dat_actv_data31[15:0])  //|< r
  ,.out               (mult_res_31[31:0])     //|> w
  );
mult16 u_mul_32 (
  .a                  (wt_actv_data32[15:0])   //|< r
  ,.b                 (dat_actv_data32[15:0])  //|< r
  ,.out               (mult_res_32[31:0])     //|> w
  );
mult16 u_mul_33 (
  .a                  (wt_actv_data33[15:0])   //|< r
  ,.b                 (dat_actv_data33[15:0])  //|< r
  ,.out               (mult_res_33[31:0])     //|> w
  );
mult16 u_mul_34 (
  .a                  (wt_actv_data34[15:0])   //|< r
  ,.b                 (dat_actv_data34[15:0])  //|< r
  ,.out               (mult_res_34[31:0])     //|> w
  );
mult16 u_mul_35 (
  .a                  (wt_actv_data35[15:0])   //|< r
  ,.b                 (dat_actv_data35[15:0])  //|< r
  ,.out               (mult_res_35[31:0])     //|> w
  );
mult16 u_mul_36 (
  .a                  (wt_actv_data36[15:0])   //|< r
  ,.b                 (dat_actv_data36[15:0])  //|< r
  ,.out               (mult_res_36[31:0])     //|> w
  );
mult16 u_mul_37 (
  .a                  (wt_actv_data37[15:0])   //|< r
  ,.b                 (dat_actv_data37[15:0])  //|< r
  ,.out               (mult_res_37[31:0])     //|> w
  );
mult16 u_mul_38 (
  .a                  (wt_actv_data38[15:0])   //|< r
  ,.b                 (dat_actv_data38[15:0])  //|< r
  ,.out               (mult_res_38[31:0])     //|> w
  );
mult16 u_mul_39 (
  .a                  (wt_actv_data39[15:0])   //|< r
  ,.b                 (dat_actv_data39[15:0])  //|< r
  ,.out               (mult_res_39[31:0])     //|> w
  );
mult16 u_mul_40 (
  .a                  (wt_actv_data40[15:0])   //|< r
  ,.b                 (dat_actv_data40[15:0])  //|< r
  ,.out               (mult_res_40[31:0])     //|> w
  );
mult16 u_mul_41 (
  .a                  (wt_actv_data41[15:0])   //|< r
  ,.b                 (dat_actv_data41[15:0])  //|< r
  ,.out               (mult_res_41[31:0])     //|> w
  );
mult16 u_mul_42 (
  .a                  (wt_actv_data42[15:0])   //|< r
  ,.b                 (dat_actv_data42[15:0])  //|< r
  ,.out               (mult_res_42[31:0])     //|> w
  );
mult16 u_mul_43 (
  .a                  (wt_actv_data43[15:0])   //|< r
  ,.b                 (dat_actv_data43[15:0])  //|< r
  ,.out               (mult_res_43[31:0])     //|> w
  );
mult16 u_mul_44 (
  .a                  (wt_actv_data44[15:0])   //|< r
  ,.b                 (dat_actv_data44[15:0])  //|< r
  ,.out               (mult_res_44[31:0])     //|> w
  );
mult16 u_mul_45 (
  .a                  (wt_actv_data45[15:0])   //|< r
  ,.b                 (dat_actv_data45[15:0])  //|< r
  ,.out               (mult_res_45[31:0])     //|> w
  );
mult16 u_mul_46 (
  .a                  (wt_actv_data46[15:0])   //|< r
  ,.b                 (dat_actv_data46[15:0])  //|< r
  ,.out               (mult_res_46[31:0])     //|> w
  );
mult16 u_mul_47 (
  .a                  (wt_actv_data47[15:0])   //|< r
  ,.b                 (dat_actv_data47[15:0])  //|< r
  ,.out               (mult_res_47[31:0])     //|> w
  );
mult16 u_mul_48 (
  .a                  (wt_actv_data48[15:0])   //|< r
  ,.b                 (dat_actv_data48[15:0])  //|< r
  ,.out               (mult_res_48[31:0])     //|> w
  );
mult16 u_mul_49 (
  .a                  (wt_actv_data49[15:0])   //|< r
  ,.b                 (dat_actv_data49[15:0])  //|< r
  ,.out               (mult_res_49[31:0])     //|> w
  );
mult16 u_mul_50 (
  .a                  (wt_actv_data50[15:0])   //|< r
  ,.b                 (dat_actv_data50[15:0])  //|< r
  ,.out               (mult_res_50[31:0])     //|> w
  );
mult16 u_mul_51 (
  .a                  (wt_actv_data51[15:0])   //|< r
  ,.b                 (dat_actv_data51[15:0])  //|< r
  ,.out               (mult_res_51[31:0])     //|> w
  );
mult16 u_mul_52 (
  .a                  (wt_actv_data52[15:0])   //|< r
  ,.b                 (dat_actv_data52[15:0])  //|< r
  ,.out               (mult_res_52[31:0])     //|> w
  );
mult16 u_mul_53 (
  .a                  (wt_actv_data53[15:0])   //|< r
  ,.b                 (dat_actv_data53[15:0])  //|< r
  ,.out               (mult_res_53[31:0])     //|> w
  );
mult16 u_mul_54 (
  .a                  (wt_actv_data54[15:0])   //|< r
  ,.b                 (dat_actv_data54[15:0])  //|< r
  ,.out               (mult_res_54[31:0])     //|> w
  );
mult16 u_mul_55 (
  .a                  (wt_actv_data55[15:0])   //|< r
  ,.b                 (dat_actv_data55[15:0])  //|< r
  ,.out               (mult_res_55[31:0])     //|> w
  );
mult16 u_mul_56 (
  .a                  (wt_actv_data56[15:0])   //|< r
  ,.b                 (dat_actv_data56[15:0])  //|< r
  ,.out               (mult_res_56[31:0])     //|> w
  );
mult16 u_mul_57 (
  .a                  (wt_actv_data57[15:0])   //|< r
  ,.b                 (dat_actv_data57[15:0])  //|< r
  ,.out               (mult_res_57[31:0])     //|> w
  );
mult16 u_mul_58 (
  .a                  (wt_actv_data58[15:0])   //|< r
  ,.b                 (dat_actv_data58[15:0])  //|< r
  ,.out               (mult_res_58[31:0])     //|> w
  );
mult16 u_mul_59 (
  .a                  (wt_actv_data59[15:0])   //|< r
  ,.b                 (dat_actv_data59[15:0])  //|< r
  ,.out               (mult_res_59[31:0])     //|> w
  );
mult16 u_mul_60 (
  .a                  (wt_actv_data60[15:0])   //|< r
  ,.b                 (dat_actv_data60[15:0])  //|< r
  ,.out               (mult_res_60[31:0])     //|> w
  );
mult16 u_mul_61 (
  .a                  (wt_actv_data61[15:0])   //|< r
  ,.b                 (dat_actv_data61[15:0])  //|< r
  ,.out               (mult_res_61[31:0])     //|> w
  );
mult16 u_mul_62 (
  .a                  (wt_actv_data62[15:0])   //|< r
  ,.b                 (dat_actv_data62[15:0])  //|< r
  ,.out               (mult_res_62[31:0])     //|> w
  );
mult16 u_mul_63 (
  .a                  (wt_actv_data63[15:0])   //|< r
  ,.b                 (dat_actv_data63[15:0])  //|< r
  ,.out               (mult_res_63[31:0])     //|> w
  );



// Config logic
//==========================================================

always @(posedge nvdla_core_clk) begin
	/*Sign extension, one clk cycle*/
	sign_ext_mult_res_00 = (mult_res_00[31]) ? {12'b111111111111,mult_res_00} : {12'b000000000000,mult_res_00};
	sign_ext_mult_res_01 = (mult_res_01[31]) ? {12'b111111111111,mult_res_01} : {12'b000000000000,mult_res_01};
	sign_ext_mult_res_02 = (mult_res_02[31]) ? {12'b111111111111,mult_res_02} : {12'b000000000000,mult_res_02};
	sign_ext_mult_res_03 = (mult_res_03[31]) ? {12'b111111111111,mult_res_03} : {12'b000000000000,mult_res_03};
	sign_ext_mult_res_04 = (mult_res_04[31]) ? {12'b111111111111,mult_res_04} : {12'b000000000000,mult_res_04};
	sign_ext_mult_res_05 = (mult_res_05[31]) ? {12'b111111111111,mult_res_05} : {12'b000000000000,mult_res_05};
	sign_ext_mult_res_06 = (mult_res_06[31]) ? {12'b111111111111,mult_res_06} : {12'b000000000000,mult_res_06};
	sign_ext_mult_res_07 = (mult_res_07[31]) ? {12'b111111111111,mult_res_07} : {12'b000000000000,mult_res_07};
	sign_ext_mult_res_08 = (mult_res_08[31]) ? {12'b111111111111,mult_res_08} : {12'b000000000000,mult_res_08};
	sign_ext_mult_res_09 = (mult_res_09[31]) ? {12'b111111111111,mult_res_09} : {12'b000000000000,mult_res_09};
	sign_ext_mult_res_10 = (mult_res_10[31]) ? {12'b111111111111,mult_res_10} : {12'b000000000000,mult_res_10};
	sign_ext_mult_res_11 = (mult_res_11[31]) ? {12'b111111111111,mult_res_11} : {12'b000000000000,mult_res_11};
	sign_ext_mult_res_12 = (mult_res_12[31]) ? {12'b111111111111,mult_res_12} : {12'b000000000000,mult_res_12};
	sign_ext_mult_res_13 = (mult_res_13[31]) ? {12'b111111111111,mult_res_13} : {12'b000000000000,mult_res_13};
	sign_ext_mult_res_14 = (mult_res_14[31]) ? {12'b111111111111,mult_res_14} : {12'b000000000000,mult_res_14};
	sign_ext_mult_res_15 = (mult_res_15[31]) ? {12'b111111111111,mult_res_15} : {12'b000000000000,mult_res_15};
	sign_ext_mult_res_16 = (mult_res_16[31]) ? {12'b111111111111,mult_res_16} : {12'b000000000000,mult_res_16};
	sign_ext_mult_res_17 = (mult_res_17[31]) ? {12'b111111111111,mult_res_17} : {12'b000000000000,mult_res_17};
	sign_ext_mult_res_18 = (mult_res_18[31]) ? {12'b111111111111,mult_res_18} : {12'b000000000000,mult_res_18};
	sign_ext_mult_res_19 = (mult_res_19[31]) ? {12'b111111111111,mult_res_19} : {12'b000000000000,mult_res_19};
	sign_ext_mult_res_20 = (mult_res_20[31]) ? {12'b111111111111,mult_res_20} : {12'b000000000000,mult_res_20};
	sign_ext_mult_res_21 = (mult_res_21[31]) ? {12'b111111111111,mult_res_21} : {12'b000000000000,mult_res_21};
	sign_ext_mult_res_22 = (mult_res_22[31]) ? {12'b111111111111,mult_res_22} : {12'b000000000000,mult_res_22};
	sign_ext_mult_res_23 = (mult_res_23[31]) ? {12'b111111111111,mult_res_23} : {12'b000000000000,mult_res_23};
	sign_ext_mult_res_24 = (mult_res_24[31]) ? {12'b111111111111,mult_res_24} : {12'b000000000000,mult_res_24};
	sign_ext_mult_res_25 = (mult_res_25[31]) ? {12'b111111111111,mult_res_25} : {12'b000000000000,mult_res_25};
	sign_ext_mult_res_26 = (mult_res_26[31]) ? {12'b111111111111,mult_res_26} : {12'b000000000000,mult_res_26};
	sign_ext_mult_res_27 = (mult_res_27[31]) ? {12'b111111111111,mult_res_27} : {12'b000000000000,mult_res_27};
	sign_ext_mult_res_28 = (mult_res_28[31]) ? {12'b111111111111,mult_res_28} : {12'b000000000000,mult_res_28};
	sign_ext_mult_res_29 = (mult_res_29[31]) ? {12'b111111111111,mult_res_29} : {12'b000000000000,mult_res_29};
	sign_ext_mult_res_30 = (mult_res_30[31]) ? {12'b111111111111,mult_res_30} : {12'b000000000000,mult_res_30};
	sign_ext_mult_res_31 = (mult_res_31[31]) ? {12'b111111111111,mult_res_31} : {12'b000000000000,mult_res_31};

	sign_ext_mult_res_32 = (mult_res_32[31]) ? {12'b111111111111,mult_res_32} : {12'b000000000000,mult_res_32};
	sign_ext_mult_res_33 = (mult_res_33[31]) ? {12'b111111111111,mult_res_33} : {12'b000000000000,mult_res_33};
	sign_ext_mult_res_34 = (mult_res_34[31]) ? {12'b111111111111,mult_res_34} : {12'b000000000000,mult_res_34};
	sign_ext_mult_res_35 = (mult_res_35[31]) ? {12'b111111111111,mult_res_35} : {12'b000000000000,mult_res_35};
	sign_ext_mult_res_36 = (mult_res_36[31]) ? {12'b111111111111,mult_res_36} : {12'b000000000000,mult_res_36};
	sign_ext_mult_res_37 = (mult_res_37[31]) ? {12'b111111111111,mult_res_37} : {12'b000000000000,mult_res_37};
	sign_ext_mult_res_38 = (mult_res_38[31]) ? {12'b111111111111,mult_res_38} : {12'b000000000000,mult_res_38};
	sign_ext_mult_res_39 = (mult_res_39[31]) ? {12'b111111111111,mult_res_39} : {12'b000000000000,mult_res_39};
	sign_ext_mult_res_40 = (mult_res_40[31]) ? {12'b111111111111,mult_res_40} : {12'b000000000000,mult_res_40};
	sign_ext_mult_res_41 = (mult_res_41[31]) ? {12'b111111111111,mult_res_41} : {12'b000000000000,mult_res_41};
	sign_ext_mult_res_42 = (mult_res_42[31]) ? {12'b111111111111,mult_res_42} : {12'b000000000000,mult_res_42};
	sign_ext_mult_res_43 = (mult_res_43[31]) ? {12'b111111111111,mult_res_43} : {12'b000000000000,mult_res_43};
	sign_ext_mult_res_44 = (mult_res_44[31]) ? {12'b111111111111,mult_res_44} : {12'b000000000000,mult_res_44};
	sign_ext_mult_res_45 = (mult_res_45[31]) ? {12'b111111111111,mult_res_45} : {12'b000000000000,mult_res_45};
	sign_ext_mult_res_46 = (mult_res_46[31]) ? {12'b111111111111,mult_res_46} : {12'b000000000000,mult_res_46};
	sign_ext_mult_res_47 = (mult_res_47[31]) ? {12'b111111111111,mult_res_47} : {12'b000000000000,mult_res_47};
	sign_ext_mult_res_48 = (mult_res_48[31]) ? {12'b111111111111,mult_res_48} : {12'b000000000000,mult_res_48};
	sign_ext_mult_res_49 = (mult_res_49[31]) ? {12'b111111111111,mult_res_49} : {12'b000000000000,mult_res_49};
	sign_ext_mult_res_50 = (mult_res_50[31]) ? {12'b111111111111,mult_res_50} : {12'b000000000000,mult_res_50};
	sign_ext_mult_res_51 = (mult_res_51[31]) ? {12'b111111111111,mult_res_51} : {12'b000000000000,mult_res_51};
	sign_ext_mult_res_52 = (mult_res_52[31]) ? {12'b111111111111,mult_res_52} : {12'b000000000000,mult_res_52};
	sign_ext_mult_res_53 = (mult_res_53[31]) ? {12'b111111111111,mult_res_53} : {12'b000000000000,mult_res_53};
	sign_ext_mult_res_54 = (mult_res_54[31]) ? {12'b111111111111,mult_res_54} : {12'b000000000000,mult_res_54};
	sign_ext_mult_res_55 = (mult_res_55[31]) ? {12'b111111111111,mult_res_55} : {12'b000000000000,mult_res_55};
	sign_ext_mult_res_56 = (mult_res_56[31]) ? {12'b111111111111,mult_res_56} : {12'b000000000000,mult_res_56};
	sign_ext_mult_res_57 = (mult_res_57[31]) ? {12'b111111111111,mult_res_57} : {12'b000000000000,mult_res_57};
	sign_ext_mult_res_58 = (mult_res_58[31]) ? {12'b111111111111,mult_res_58} : {12'b000000000000,mult_res_58};
	sign_ext_mult_res_59 = (mult_res_59[31]) ? {12'b111111111111,mult_res_59} : {12'b000000000000,mult_res_59};
	sign_ext_mult_res_60 = (mult_res_60[31]) ? {12'b111111111111,mult_res_60} : {12'b000000000000,mult_res_60};
	sign_ext_mult_res_61 = (mult_res_61[31]) ? {12'b111111111111,mult_res_61} : {12'b000000000000,mult_res_61};
	sign_ext_mult_res_62 = (mult_res_62[31]) ? {12'b111111111111,mult_res_62} : {12'b000000000000,mult_res_62};
	sign_ext_mult_res_63 = (mult_res_63[31]) ? {12'b111111111111,mult_res_63} : {12'b000000000000,mult_res_63};
		
	/*First sum considering overflow*/
	temp0 = sign_ext_mult_res_00 + sign_ext_mult_res_01;
	temp1 = sign_ext_mult_res_02 + sign_ext_mult_res_03;
	temp2 = sign_ext_mult_res_04 + sign_ext_mult_res_05;
	temp3 = sign_ext_mult_res_06 + sign_ext_mult_res_07;
	temp4 = sign_ext_mult_res_08 + sign_ext_mult_res_09;
	temp5 = sign_ext_mult_res_10 + sign_ext_mult_res_11;
	temp6 = sign_ext_mult_res_12 + sign_ext_mult_res_13;
	temp7 = sign_ext_mult_res_14 + sign_ext_mult_res_15;
	temp8 = sign_ext_mult_res_16 + sign_ext_mult_res_17;
	temp9 = sign_ext_mult_res_18 + sign_ext_mult_res_19;
	temp10 = sign_ext_mult_res_20 + sign_ext_mult_res_21;
	temp11 = sign_ext_mult_res_22 + sign_ext_mult_res_23;
	temp12 = sign_ext_mult_res_24 + sign_ext_mult_res_25;
	temp13 = sign_ext_mult_res_26 + sign_ext_mult_res_27;
	temp14 = sign_ext_mult_res_28 + sign_ext_mult_res_29;
	temp15 = sign_ext_mult_res_30 + sign_ext_mult_res_31;

	temp16 = sign_ext_mult_res_32 + sign_ext_mult_res_33;
	temp17 = sign_ext_mult_res_34 + sign_ext_mult_res_35;
	temp18 = sign_ext_mult_res_36 + sign_ext_mult_res_37;
	temp19 = sign_ext_mult_res_38 + sign_ext_mult_res_39;
	temp20 = sign_ext_mult_res_40 + sign_ext_mult_res_41;
	temp21 = sign_ext_mult_res_42 + sign_ext_mult_res_43;
	temp22 = sign_ext_mult_res_44 + sign_ext_mult_res_45;
	temp23 = sign_ext_mult_res_46 + sign_ext_mult_res_47;
	temp24 = sign_ext_mult_res_48 + sign_ext_mult_res_49;
	temp25 = sign_ext_mult_res_50 + sign_ext_mult_res_51;
	temp26 = sign_ext_mult_res_52 + sign_ext_mult_res_53;
	temp27 = sign_ext_mult_res_54 + sign_ext_mult_res_55;
	temp28 = sign_ext_mult_res_56 + sign_ext_mult_res_57;
	temp29 = sign_ext_mult_res_58 + sign_ext_mult_res_59;
	temp30 = sign_ext_mult_res_60 + sign_ext_mult_res_61;
	temp31 = sign_ext_mult_res_62 + sign_ext_mult_res_63;

	/*2da linea*/
	tempsec0 = temp0 + temp1;
	tempsec1 = temp2 + temp3;
	tempsec2 = temp4 + temp5;
	tempsec3 = temp6 + temp7;
	tempsec4 = temp8 + temp9;
	tempsec5 = temp10 + temp11;
	tempsec6 = temp12 + temp13;
	tempsec7 = temp14 + temp15;

	tempsec8 = temp16 + temp17;
	tempsec9 = temp18 + temp19;
	tempsec10 = temp20 + temp21;
	tempsec11 = temp22 + temp23;
	tempsec12 = temp24 + temp25;
	tempsec13 = temp26 + temp27;
	tempsec14 = temp28 + temp29;
	tempsec15 = temp30 + temp31;
	
	/*3ra linea*/
	tempter0 = tempsec0 + tempsec1;
	tempter1 = tempsec2 + tempsec3;
	tempter2 = tempsec4 + tempsec5;
	tempter3 = tempsec6 + tempsec7;

	tempter4 = tempsec8 + tempsec9;
	tempter5 = tempsec10 + tempsec11;
	tempter6 = tempsec12 + tempsec13;
	tempter7 = tempsec14 + tempsec15;
	
	/*4ta linea*/
	tempcua0 = tempter0 + tempter1;
	tempcua1 = tempter2 + tempter3;
	
	tempcua2 = tempter4 + tempter5;
	tempcua3 = tempter6 + tempter7;
	
	/*5ta linea*/
	tempqui0 = tempcua0 + tempcua1;
	
	tempqui1 = tempcua2 + tempcua3;

	/*6ta linea*/
	tempsect0 = tempqui0 + tempqui1;
	
	/*Pipeline*/
	mac_out_nan <= 1'b0;
	a1 = tempsect0[37:0] & 37'b1;
	if(a1 >= 1'b0) begin
		mac_out_data_w[43:0] <= {6'b0,tempsect0[37:0]};	
	end
        mac_out_data_w2[43:0] <= mac_out_data_w[43:0];
	mac_out_data[43:0] <= mac_out_data_w2[43:0];
        mac_out_data[175:44] <= 'bx;
	if(enable == 1'b1) begin
		mac_out_pvld <= 1'b1;
        end
        if(mac_out_pvld == 1'b1 || cfg_reg_en == 1'b1) begin
		mac_out_pvld <= 1'b0;
        end
end

always @(mac_out_data_w2, mac_out_pvld) begin 
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
/*
always @(mac_out_data) begin
	$display("data: %0h * weight: %0h = mac_out_data: %0h",dat_actv_data, wt_actv_data,mac_out_data);
end*/
endmodule // NV_NVDLA_CMAC_CORE_mac
