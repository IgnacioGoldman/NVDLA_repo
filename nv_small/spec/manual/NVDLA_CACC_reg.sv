//   Ordt 171103.01 autogenerated file 
//   Input: NVDLA_CACC.rdl
//   Parms: opendla.parms
//   Date: Sat May 26 21:42:07 CEST 2018
//

import uvm_pkg::*;
import ordt_uvm_reg_pkg::*;

// S_STATUS
class reg_addrmap_NVDLA_NVDLA_CACC_S_STATUS extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl STATUS_0;
  rand uvm_reg_field_rdl STATUS_1;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_S_STATUS");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.STATUS_0 = new("STATUS_0");
    this.STATUS_0.set_rdl_access_info(1, 0, 0, 1, 0, 0);
    this.STATUS_0.configure(this, 2, 0, "RO", 1, 2'h0, 1, 0, 0);
    this.STATUS_0.add_def_property("spec_access", "r");
    this.STATUS_0.add_def_property("spec_sw_default", "0x0");
    this.STATUS_0.add_def_property("sw_default_mask", "0x0");
    this.STATUS_0.add_def_property("reset_mask", "0x3");
    this.STATUS_1 = new("STATUS_1");
    this.STATUS_1.set_rdl_access_info(1, 0, 0, 1, 0, 0);
    this.STATUS_1.configure(this, 2, 16, "RO", 1, 2'h0, 1, 0, 0);
    this.STATUS_1.add_def_property("spec_access", "r");
    this.STATUS_1.add_def_property("spec_sw_default", "0x0");
    this.STATUS_1.add_def_property("sw_default_mask", "0x0");
    this.STATUS_1.add_def_property("reset_mask", "0x3");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "STATUS_0"}, 0, 2);
    add_hdl_path_slice({rdl_reg_name, "STATUS_1"}, 16, 2);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_S_STATUS

// S_POINTER
class reg_addrmap_NVDLA_NVDLA_CACC_S_POINTER extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl PRODUCER;
  rand uvm_reg_field_rdl CONSUMER;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_S_POINTER");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.PRODUCER = new("PRODUCER");
    this.PRODUCER.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.PRODUCER.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 0);
    this.PRODUCER.add_def_property("spec_access", "rw");
    this.PRODUCER.add_def_property("spec_sw_default", "0x0");
    this.PRODUCER.add_def_property("sw_default_mask", "0x0");
    this.PRODUCER.add_def_property("reset_mask", "0x1");
    this.CONSUMER = new("CONSUMER");
    this.CONSUMER.set_rdl_access_info(1, 0, 0, 1, 0, 0);
    this.CONSUMER.configure(this, 1, 16, "RO", 1, 1'h0, 1, 0, 0);
    this.CONSUMER.add_def_property("spec_access", "r");
    this.CONSUMER.add_def_property("spec_sw_default", "0x0");
    this.CONSUMER.add_def_property("sw_default_mask", "0x0");
    this.CONSUMER.add_def_property("reset_mask", "0x1");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "PRODUCER"}, 0, 1);
    add_hdl_path_slice({rdl_reg_name, "CONSUMER"}, 16, 1);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_S_POINTER

// D_OP_ENABLE
class reg_addrmap_NVDLA_NVDLA_CACC_D_OP_ENABLE extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl OP_EN;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_OP_ENABLE");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.OP_EN = new("OP_EN");
    this.OP_EN.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.OP_EN.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 1);
    this.OP_EN.add_def_property("spec_access", "rwto");
    this.OP_EN.add_def_property("spec_sw_default", "0x0");
    this.OP_EN.add_def_property("sw_default_mask", "0x0");
    this.OP_EN.add_def_property("reset_mask", "0x1");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "OP_EN"}, 0, 1);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_OP_ENABLE

// D_MISC_CFG
class reg_addrmap_NVDLA_NVDLA_CACC_D_MISC_CFG extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl CONV_MODE;
  rand uvm_reg_field_rdl PROC_PRECISION;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_MISC_CFG");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.CONV_MODE = new("CONV_MODE");
    this.CONV_MODE.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.CONV_MODE.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 0);
    this.CONV_MODE.add_def_property("spec_access", "rw");
    this.CONV_MODE.add_def_property("spec_sw_default", "0x0");
    this.CONV_MODE.add_def_property("sw_default_mask", "0x0");
    this.CONV_MODE.add_def_property("reset_mask", "0x1");
    this.PROC_PRECISION = new("PROC_PRECISION");
    this.PROC_PRECISION.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.PROC_PRECISION.configure(this, 2, 12, "RW", 0, 2'h1, 1, 1, 0);
    this.PROC_PRECISION.add_def_property("spec_access", "rw");
    this.PROC_PRECISION.add_def_property("spec_sw_default", "0x0");
    this.PROC_PRECISION.add_def_property("sw_default_mask", "0x0");
    this.PROC_PRECISION.add_def_property("reset_mask", "0x3");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "CONV_MODE"}, 0, 1);
    add_hdl_path_slice({rdl_reg_name, "PROC_PRECISION"}, 12, 2);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_MISC_CFG

// D_DATAOUT_SIZE_0
class reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_0 extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl DATAOUT_WIDTH;
  rand uvm_reg_field_rdl DATAOUT_HEIGHT;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_0");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.DATAOUT_WIDTH = new("DATAOUT_WIDTH");
    this.DATAOUT_WIDTH.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.DATAOUT_WIDTH.configure(this, 13, 0, "RW", 0, 13'h0, 1, 1, 0);
    this.DATAOUT_WIDTH.add_def_property("spec_access", "rw");
    this.DATAOUT_WIDTH.add_def_property("spec_sw_default", "0x0");
    this.DATAOUT_WIDTH.add_def_property("sw_default_mask", "0x0");
    this.DATAOUT_WIDTH.add_def_property("reset_mask", "0x1fff");
    this.DATAOUT_HEIGHT = new("DATAOUT_HEIGHT");
    this.DATAOUT_HEIGHT.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.DATAOUT_HEIGHT.configure(this, 13, 16, "RW", 0, 13'h0, 1, 1, 0);
    this.DATAOUT_HEIGHT.add_def_property("spec_access", "rw");
    this.DATAOUT_HEIGHT.add_def_property("spec_sw_default", "0x0");
    this.DATAOUT_HEIGHT.add_def_property("sw_default_mask", "0x0");
    this.DATAOUT_HEIGHT.add_def_property("reset_mask", "0x1fff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "DATAOUT_WIDTH"}, 0, 13);
    add_hdl_path_slice({rdl_reg_name, "DATAOUT_HEIGHT"}, 16, 13);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_0

// D_DATAOUT_SIZE_1
class reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_1 extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl DATAOUT_CHANNEL;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_1");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.DATAOUT_CHANNEL = new("DATAOUT_CHANNEL");
    this.DATAOUT_CHANNEL.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.DATAOUT_CHANNEL.configure(this, 13, 0, "RW", 0, 13'h0, 1, 1, 1);
    this.DATAOUT_CHANNEL.add_def_property("spec_access", "rw");
    this.DATAOUT_CHANNEL.add_def_property("spec_sw_default", "0x0");
    this.DATAOUT_CHANNEL.add_def_property("sw_default_mask", "0x0");
    this.DATAOUT_CHANNEL.add_def_property("reset_mask", "0x1fff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "DATAOUT_CHANNEL"}, 0, 13);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_1

// D_DATAOUT_ADDR
class reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_ADDR extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl DATAOUT_ADDR;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_ADDR");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.DATAOUT_ADDR = new("DATAOUT_ADDR");
    this.DATAOUT_ADDR.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.DATAOUT_ADDR.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
    this.DATAOUT_ADDR.add_def_property("spec_access", "rw");
    this.DATAOUT_ADDR.add_def_property("spec_sw_default", "0x0");
    this.DATAOUT_ADDR.add_def_property("sw_default_mask", "0x0");
    this.DATAOUT_ADDR.add_def_property("reset_mask", "0xffffffff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "DATAOUT_ADDR"}, 0, 32);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_ADDR

// D_BATCH_NUMBER
class reg_addrmap_NVDLA_NVDLA_CACC_D_BATCH_NUMBER extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl BATCHES;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_BATCH_NUMBER");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.BATCHES = new("BATCHES");
    this.BATCHES.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.BATCHES.configure(this, 5, 0, "RW", 0, 5'h0, 1, 1, 1);
    this.BATCHES.add_def_property("spec_access", "rw");
    this.BATCHES.add_def_property("spec_sw_default", "0x0");
    this.BATCHES.add_def_property("sw_default_mask", "0x0");
    this.BATCHES.add_def_property("reset_mask", "0x1f");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "BATCHES"}, 0, 5);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_BATCH_NUMBER

// D_LINE_STRIDE
class reg_addrmap_NVDLA_NVDLA_CACC_D_LINE_STRIDE extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl LINE_STRIDE;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_LINE_STRIDE");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.LINE_STRIDE = new("LINE_STRIDE");
    this.LINE_STRIDE.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.LINE_STRIDE.configure(this, 24, 0, "RW", 0, 24'h0, 1, 1, 1);
    this.LINE_STRIDE.add_def_property("spec_access", "rw");
    this.LINE_STRIDE.add_def_property("spec_sw_default", "0x0");
    this.LINE_STRIDE.add_def_property("sw_default_mask", "0x0");
    this.LINE_STRIDE.add_def_property("reset_mask", "0xffffff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "LINE_STRIDE"}, 0, 24);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_LINE_STRIDE

// D_SURF_STRIDE
class reg_addrmap_NVDLA_NVDLA_CACC_D_SURF_STRIDE extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl SURF_STRIDE;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_SURF_STRIDE");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.SURF_STRIDE = new("SURF_STRIDE");
    this.SURF_STRIDE.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.SURF_STRIDE.configure(this, 24, 0, "RW", 0, 24'h0, 1, 1, 1);
    this.SURF_STRIDE.add_def_property("spec_access", "rw");
    this.SURF_STRIDE.add_def_property("spec_sw_default", "0x0");
    this.SURF_STRIDE.add_def_property("sw_default_mask", "0x0");
    this.SURF_STRIDE.add_def_property("reset_mask", "0xffffff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "SURF_STRIDE"}, 0, 24);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_SURF_STRIDE

// D_DATAOUT_MAP
class reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_MAP extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl LINE_PACKED;
  rand uvm_reg_field_rdl SURF_PACKED;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_MAP");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.LINE_PACKED = new("LINE_PACKED");
    this.LINE_PACKED.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.LINE_PACKED.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 0);
    this.LINE_PACKED.add_def_property("spec_access", "rw");
    this.LINE_PACKED.add_def_property("spec_sw_default", "0x0");
    this.LINE_PACKED.add_def_property("sw_default_mask", "0x0");
    this.LINE_PACKED.add_def_property("reset_mask", "0x1");
    this.SURF_PACKED = new("SURF_PACKED");
    this.SURF_PACKED.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.SURF_PACKED.configure(this, 1, 16, "RW", 0, 1'h0, 1, 1, 0);
    this.SURF_PACKED.add_def_property("spec_access", "rw");
    this.SURF_PACKED.add_def_property("spec_sw_default", "0x0");
    this.SURF_PACKED.add_def_property("sw_default_mask", "0x0");
    this.SURF_PACKED.add_def_property("reset_mask", "0x1");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "LINE_PACKED"}, 0, 1);
    add_hdl_path_slice({rdl_reg_name, "SURF_PACKED"}, 16, 1);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_MAP

// D_CLIP_CFG
class reg_addrmap_NVDLA_NVDLA_CACC_D_CLIP_CFG extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl CLIP_TRUNCATE;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_CLIP_CFG");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.CLIP_TRUNCATE = new("CLIP_TRUNCATE");
    this.CLIP_TRUNCATE.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.CLIP_TRUNCATE.configure(this, 5, 0, "RW", 0, 5'h0, 1, 1, 1);
    this.CLIP_TRUNCATE.add_def_property("spec_access", "rw");
    this.CLIP_TRUNCATE.add_def_property("spec_sw_default", "0x0");
    this.CLIP_TRUNCATE.add_def_property("sw_default_mask", "0x0");
    this.CLIP_TRUNCATE.add_def_property("reset_mask", "0x1f");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "CLIP_TRUNCATE"}, 0, 5);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_CLIP_CFG

// D_OUT_SATURATION
class reg_addrmap_NVDLA_NVDLA_CACC_D_OUT_SATURATION extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl SAT_COUNT;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_OUT_SATURATION");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.SAT_COUNT = new("SAT_COUNT");
    this.SAT_COUNT.set_rdl_access_info(1, 0, 0, 1, 0, 0);
    this.SAT_COUNT.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
    this.SAT_COUNT.add_def_property("spec_access", "r");
    this.SAT_COUNT.add_def_property("spec_sw_default", "0x0");
    this.SAT_COUNT.add_def_property("sw_default_mask", "0x0");
    this.SAT_COUNT.add_def_property("reset_mask", "0xffffffff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "SAT_COUNT"}, 0, 32);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_OUT_SATURATION

// D_CYA
class reg_addrmap_NVDLA_NVDLA_CACC_D_CYA extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl CYA;
  
  function new(string name = "reg_addrmap_NVDLA_NVDLA_CACC_D_CYA");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.CYA = new("CYA");
    this.CYA.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.CYA.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
    this.CYA.add_def_property("spec_access", "rw");
    this.CYA.add_def_property("spec_sw_default", "0x0");
    this.CYA.add_def_property("sw_default_mask", "0x0");
    this.CYA.add_def_property("reset_mask", "0xffffffff");
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "CYA"}, 0, 32);
  endfunction: build
  
endclass : reg_addrmap_NVDLA_NVDLA_CACC_D_CYA

// Block NVDLA_CACC
class block_addrmap_NVDLA_NVDLA_CACC extends uvm_reg_block_rdl;
  rand reg_addrmap_NVDLA_NVDLA_CACC_S_STATUS S_STATUS;
  rand reg_addrmap_NVDLA_NVDLA_CACC_S_POINTER S_POINTER;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_OP_ENABLE D_OP_ENABLE;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_MISC_CFG D_MISC_CFG;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_0 D_DATAOUT_SIZE_0;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_SIZE_1 D_DATAOUT_SIZE_1;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_ADDR D_DATAOUT_ADDR;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_BATCH_NUMBER D_BATCH_NUMBER;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_LINE_STRIDE D_LINE_STRIDE;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_SURF_STRIDE D_SURF_STRIDE;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_DATAOUT_MAP D_DATAOUT_MAP;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_CLIP_CFG D_CLIP_CFG;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_OUT_SATURATION D_OUT_SATURATION;
  rand reg_addrmap_NVDLA_NVDLA_CACC_D_CYA D_CYA;
  
  function new(string name = "block_addrmap_NVDLA_NVDLA_CACC");
    super.new(name);
  endfunction: new
  
  virtual function void build();
    this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 1);
    this.S_STATUS = new("S_STATUS");
    this.S_STATUS.configure(this, null, "");
    this.S_STATUS.set_rdl_tag("S_STATUS_");
    this.S_STATUS.set_reg_test_info(0, 0, 32);
    this.S_STATUS.build();
    this.default_map.add_reg(this.S_STATUS, `UVM_REG_ADDR_WIDTH'h0, "RO", 0);
    this.S_POINTER = new("S_POINTER");
    this.S_POINTER.configure(this, null, "");
    this.S_POINTER.set_rdl_tag("S_POINTER_");
    this.S_POINTER.set_reg_test_info(0, 0, 0);
    this.S_POINTER.build();
    this.default_map.add_reg(this.S_POINTER, `UVM_REG_ADDR_WIDTH'h4, "RW", 0);
    this.D_OP_ENABLE = new("D_OP_ENABLE");
    this.D_OP_ENABLE.configure(this, null, "");
    this.D_OP_ENABLE.set_rdl_tag("D_OP_ENABLE_");
    this.D_OP_ENABLE.set_reg_test_info(0, 0, 2);
    this.D_OP_ENABLE.build();
    this.default_map.add_reg(this.D_OP_ENABLE, `UVM_REG_ADDR_WIDTH'h8, "RW", 0);
    this.D_MISC_CFG = new("D_MISC_CFG");
    this.D_MISC_CFG.configure(this, null, "");
    this.D_MISC_CFG.set_rdl_tag("D_MISC_CFG_");
    this.D_MISC_CFG.set_reg_test_info(0, 0, 2);
    this.D_MISC_CFG.build();
    this.default_map.add_reg(this.D_MISC_CFG, `UVM_REG_ADDR_WIDTH'hc, "RW", 0);
    this.D_DATAOUT_SIZE_0 = new("D_DATAOUT_SIZE_0");
    this.D_DATAOUT_SIZE_0.configure(this, null, "");
    this.D_DATAOUT_SIZE_0.set_rdl_tag("D_DATAOUT_SIZE_0_");
    this.D_DATAOUT_SIZE_0.set_reg_test_info(0, 0, 2);
    this.D_DATAOUT_SIZE_0.build();
    this.default_map.add_reg(this.D_DATAOUT_SIZE_0, `UVM_REG_ADDR_WIDTH'h10, "RW", 0);
    this.D_DATAOUT_SIZE_1 = new("D_DATAOUT_SIZE_1");
    this.D_DATAOUT_SIZE_1.configure(this, null, "");
    this.D_DATAOUT_SIZE_1.set_rdl_tag("D_DATAOUT_SIZE_1_");
    this.D_DATAOUT_SIZE_1.set_reg_test_info(0, 0, 2);
    this.D_DATAOUT_SIZE_1.build();
    this.default_map.add_reg(this.D_DATAOUT_SIZE_1, `UVM_REG_ADDR_WIDTH'h14, "RW", 0);
    this.D_DATAOUT_ADDR = new("D_DATAOUT_ADDR");
    this.D_DATAOUT_ADDR.configure(this, null, "");
    this.D_DATAOUT_ADDR.set_rdl_tag("D_DATAOUT_ADDR_");
    this.D_DATAOUT_ADDR.set_reg_test_info(0, 0, 2);
    this.D_DATAOUT_ADDR.build();
    this.default_map.add_reg(this.D_DATAOUT_ADDR, `UVM_REG_ADDR_WIDTH'h18, "RW", 0);
    this.D_BATCH_NUMBER = new("D_BATCH_NUMBER");
    this.D_BATCH_NUMBER.configure(this, null, "");
    this.D_BATCH_NUMBER.set_rdl_tag("D_BATCH_NUMBER_");
    this.D_BATCH_NUMBER.set_reg_test_info(0, 0, 2);
    this.D_BATCH_NUMBER.build();
    this.default_map.add_reg(this.D_BATCH_NUMBER, `UVM_REG_ADDR_WIDTH'h1c, "RW", 0);
    this.D_LINE_STRIDE = new("D_LINE_STRIDE");
    this.D_LINE_STRIDE.configure(this, null, "");
    this.D_LINE_STRIDE.set_rdl_tag("D_LINE_STRIDE_");
    this.D_LINE_STRIDE.set_reg_test_info(0, 0, 2);
    this.D_LINE_STRIDE.build();
    this.default_map.add_reg(this.D_LINE_STRIDE, `UVM_REG_ADDR_WIDTH'h20, "RW", 0);
    this.D_SURF_STRIDE = new("D_SURF_STRIDE");
    this.D_SURF_STRIDE.configure(this, null, "");
    this.D_SURF_STRIDE.set_rdl_tag("D_SURF_STRIDE_");
    this.D_SURF_STRIDE.set_reg_test_info(0, 0, 2);
    this.D_SURF_STRIDE.build();
    this.default_map.add_reg(this.D_SURF_STRIDE, `UVM_REG_ADDR_WIDTH'h24, "RW", 0);
    this.D_DATAOUT_MAP = new("D_DATAOUT_MAP");
    this.D_DATAOUT_MAP.configure(this, null, "");
    this.D_DATAOUT_MAP.set_rdl_tag("D_DATAOUT_MAP_");
    this.D_DATAOUT_MAP.set_reg_test_info(0, 0, 2);
    this.D_DATAOUT_MAP.build();
    this.default_map.add_reg(this.D_DATAOUT_MAP, `UVM_REG_ADDR_WIDTH'h28, "RW", 0);
    this.D_CLIP_CFG = new("D_CLIP_CFG");
    this.D_CLIP_CFG.configure(this, null, "");
    this.D_CLIP_CFG.set_rdl_tag("D_CLIP_CFG_");
    this.D_CLIP_CFG.set_reg_test_info(0, 0, 2);
    this.D_CLIP_CFG.build();
    this.default_map.add_reg(this.D_CLIP_CFG, `UVM_REG_ADDR_WIDTH'h2c, "RW", 0);
    this.D_OUT_SATURATION = new("D_OUT_SATURATION");
    this.D_OUT_SATURATION.configure(this, null, "");
    this.D_OUT_SATURATION.set_rdl_tag("D_OUT_SATURATION_");
    this.D_OUT_SATURATION.set_reg_test_info(0, 0, 32);
    this.D_OUT_SATURATION.build();
    this.default_map.add_reg(this.D_OUT_SATURATION, `UVM_REG_ADDR_WIDTH'h30, "RO", 0);
    this.D_CYA = new("D_CYA");
    this.D_CYA.configure(this, null, "");
    this.D_CYA.set_rdl_tag("D_CYA_");
    this.D_CYA.set_reg_test_info(0, 0, 2);
    this.D_CYA.build();
    this.default_map.add_reg(this.D_CYA, `UVM_REG_ADDR_WIDTH'h34, "RW", 0);
  endfunction: build
  
  `uvm_object_utils(block_addrmap_NVDLA_NVDLA_CACC)
endclass : block_addrmap_NVDLA_NVDLA_CACC

// Base block
class block_addrmap_NVDLA extends uvm_reg_block_rdl;
  rand block_addrmap_NVDLA_NVDLA_CACC NVDLA_CACC;
  
  function new(string name = "block_addrmap_NVDLA");
    super.new(name);
  endfunction: new
  
  virtual function void build();
    this.default_map = create_map("", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    this.set_rdl_address_map(1);
    this.set_rdl_address_map_hdl_path({`ADDRMAP_NVDLA_PIO_INSTANCE_PATH, ".pio_logic"});
    this.NVDLA_CACC = block_addrmap_NVDLA_NVDLA_CACC::type_id::create("NVDLA_CACC",, get_full_name());
    this.NVDLA_CACC.configure(this, "");
    this.NVDLA_CACC.set_rdl_tag("NVDLA_CACC_");
    this.NVDLA_CACC.build();
    this.default_map.add_submap(this.NVDLA_CACC.default_map, `UVM_REG_ADDR_WIDTH'h7000);
    set_hdl_path_root({`ADDRMAP_NVDLA_PIO_INSTANCE_PATH, ".pio_logic"});
    this.add_callbacks();
  endfunction: build
  
  `uvm_object_utils(block_addrmap_NVDLA)
endclass : block_addrmap_NVDLA
