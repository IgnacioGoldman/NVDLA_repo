//   Ordt 171103.01 autogenerated file 
//   Input: NVDLA_SDP.rdl
//   Parms: opendla.parms
//   Date: Tue May 29 01:10:23 CEST 2018
//

#ifndef __ORDT_PIO_HPP_INCLUDED__
#define __ORDT_PIO_HPP_INCLUDED__

#include <vector>
#include <iostream>
#include <memory>
#include <cstdint>
#include <algorithm>
#include <string>
#include <sstream>
#include <mutex>
#include <atomic>
#define quote(x) #x

enum ordt_read_mode_t : uint8_t {r_none, r_std, r_clr};
enum ordt_write_mode_t : uint8_t {w_none, w_std, w_1clr, w_1set};
class ordt_addr_elem {
  protected:
    uint64_t m_startaddress;
    uint64_t m_endaddress;
  public:
    ordt_addr_elem(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata) = 0;
    virtual int read(const uint64_t &addr, ordt_data &rdata) = 0;
    bool containsAddress(const uint64_t &addr);
    bool isBelowAddress(const uint64_t &addr);
    bool isAboveAddress(const uint64_t &addr);
    bool hasStartAddress(const uint64_t &addr);
    virtual void update_child_ptrs();
};

class ordt_regset : public ordt_addr_elem {
  private:
    ordt_addr_elem* childElem;
    ordt_addr_elem* findAddrElem(const uint64_t &addr);
  protected:
    std::vector<ordt_addr_elem *>  m_children;
  public:
    ordt_regset(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
};


template<typename T>
class ordt_addr_elem_array : public std::vector<T>, public ordt_addr_elem {
  protected:
    std::vector<T> vec;
    uint64_t m_stride;
  public:
    ordt_addr_elem_array(uint64_t _m_startaddress, uint64_t _m_endaddress, int _reps, uint64_t _m_stride);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
};

template<typename T>
ordt_addr_elem_array<T>::ordt_addr_elem_array(uint64_t _m_startaddress, uint64_t _m_endaddress, int _reps, uint64_t _m_stride)
   : ordt_addr_elem(_m_startaddress, _m_endaddress + (_m_stride * _reps)), m_stride(_m_stride) {
   this->reserve(_reps);
   uint64_t el_startaddress = _m_startaddress;
   uint64_t el_endaddress = _m_endaddress;
   for(int idx=0; idx<_reps; idx++) {
      std::unique_ptr<T> new_elem(new T(el_startaddress, el_endaddress));
      this->push_back(*new_elem);
      this->back().update_child_ptrs();
      el_startaddress += _m_stride;
      el_endaddress += _m_stride;
   }
}

template<typename T>
int ordt_addr_elem_array<T>::write(const uint64_t &addr, const ordt_data &wdata) {
   if (this->containsAddress(addr)) {
      int idx = (addr - m_startaddress) / m_stride;
      if (idx < this->size()) return this->at(idx).write(addr, wdata);
   }
#ifdef ORDT_PIO_VERBOSE
   std::cout << "--> write to invalid address " << addr << " in arrayed regset\n";
#endif
   return 8;
}

template<typename T>
int ordt_addr_elem_array<T>::read(const uint64_t &addr, ordt_data &rdata) {
   if (this->containsAddress(addr)) {
      int idx = (addr - m_startaddress) / m_stride;
      if (idx < this->size()) return this->at(idx).read(addr, rdata);
   }
#ifdef ORDT_PIO_VERBOSE
   std::cout << "--> read to invalid address " << addr << " in arrayed regset\n";
#endif
   rdata.clear();
   return 8;
}

class ordt_reg : public ordt_addr_elem {
  public:
    std::mutex  m_mutex;
    ordt_reg(uint64_t _m_startaddress, uint64_t _m_endaddress);
    ordt_reg(const ordt_reg &_old);
    virtual void write(const ordt_data &wdata);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void read(ordt_data &rdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
};


template<typename T>
class ordt_field {
  public:
    int lobit, size;
    T data;
    ordt_read_mode_t r_mode;
    ordt_write_mode_t w_mode;
    ordt_field(int _lobit, int _size, int _vsize, uint32_t _data, ordt_read_mode_t _r_mode, ordt_write_mode_t _w_mode);
    ordt_field(int _lobit, int _size, T _init_data, ordt_read_mode_t _r_mode, ordt_write_mode_t _w_mode);
    void write(const ordt_data &wdata);
    void read(ordt_data &rdata);
    void clear();
};

template<typename T>
ordt_field<T>::ordt_field(int _lobit, int _size, int _vsize, uint32_t _data, ordt_read_mode_t _r_mode, ordt_write_mode_t _w_mode)
   : lobit(_lobit), size(_size), data(_vsize, _data), r_mode(_r_mode), w_mode(_w_mode) {
}

template<typename T>
ordt_field<T>::ordt_field(int _lobit, int _size, T _init_data, ordt_read_mode_t _r_mode, ordt_write_mode_t _w_mode)
   : lobit(_lobit), size(_size), data(_init_data), r_mode(_r_mode), w_mode(_w_mode) {
}

template<typename T>
void ordt_field<T>::write(const ordt_data &wdata) {
   if (w_mode == w_std) wdata.get_slice(lobit, size, data);
   else if (w_mode == w_1set) {
      T mask_data;
      wdata.get_slice(lobit, size, mask_data);
      data = data | mask_data;
   }
   else if (w_mode == w_1clr) {
      T mask_data;
      wdata.get_slice(lobit, size, mask_data);
      data = data & ~mask_data;
   }
}

template<typename T>
void ordt_field<T>::read(ordt_data &rdata) {
   rdata.set_slice(lobit, size, data);
   if (r_mode == r_clr) clear();
}

template<typename T>
void ordt_field<T>::clear() {
    data = 0;
}

class ordt_rg_NVDLA_SDP_S_STATUS : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> STATUS_0;
    ordt_field<uint_fast8_t> STATUS_1;
    ordt_rg_NVDLA_SDP_S_STATUS(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_POINTER : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PRODUCER;
    ordt_field<uint_fast8_t> CONSUMER;
    ordt_rg_NVDLA_SDP_S_POINTER(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_ACCESS_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_ADDR;
    ordt_field<uint_fast8_t> LUT_TABLE_ID;
    ordt_field<uint_fast8_t> LUT_ACCESS_TYPE;
    ordt_rg_NVDLA_SDP_S_LUT_ACCESS_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_ACCESS_DATA : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_DATA;
    ordt_rg_NVDLA_SDP_S_LUT_ACCESS_DATA(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> LUT_LE_FUNCTION;
    ordt_field<uint_fast8_t> LUT_UFLOW_PRIORITY;
    ordt_field<uint_fast8_t> LUT_OFLOW_PRIORITY;
    ordt_field<uint_fast8_t> LUT_HYBRID_PRIORITY;
    ordt_rg_NVDLA_SDP_S_LUT_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_INFO : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> LUT_LE_INDEX_OFFSET;
    ordt_field<uint_fast8_t> LUT_LE_INDEX_SELECT;
    ordt_field<uint_fast8_t> LUT_LO_INDEX_SELECT;
    ordt_rg_NVDLA_SDP_S_LUT_INFO(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LE_START : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LE_START;
    ordt_rg_NVDLA_SDP_S_LUT_LE_START(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LE_END : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LE_END;
    ordt_rg_NVDLA_SDP_S_LUT_LE_END(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LO_START : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LO_START;
    ordt_rg_NVDLA_SDP_S_LUT_LO_START(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LO_END : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LO_END;
    ordt_rg_NVDLA_SDP_S_LUT_LO_END(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LE_SLOPE_SCALE : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LE_SLOPE_UFLOW_SCALE;
    ordt_field<uint32_t> LUT_LE_SLOPE_OFLOW_SCALE;
    ordt_rg_NVDLA_SDP_S_LUT_LE_SLOPE_SCALE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LE_SLOPE_SHIFT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> LUT_LE_SLOPE_UFLOW_SHIFT;
    ordt_field<uint_fast8_t> LUT_LE_SLOPE_OFLOW_SHIFT;
    ordt_rg_NVDLA_SDP_S_LUT_LE_SLOPE_SHIFT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LO_SLOPE_SCALE : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LO_SLOPE_UFLOW_SCALE;
    ordt_field<uint32_t> LUT_LO_SLOPE_OFLOW_SCALE;
    ordt_rg_NVDLA_SDP_S_LUT_LO_SLOPE_SCALE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_S_LUT_LO_SLOPE_SHIFT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> LUT_LO_SLOPE_UFLOW_SHIFT;
    ordt_field<uint_fast8_t> LUT_LO_SLOPE_OFLOW_SHIFT;
    ordt_rg_NVDLA_SDP_S_LUT_LO_SLOPE_SHIFT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_OP_ENABLE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> OP_EN;
    ordt_rg_NVDLA_SDP_D_OP_ENABLE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DATA_CUBE_WIDTH : public ordt_reg {
  public:
    ordt_field<uint32_t> WIDTH;
    ordt_rg_NVDLA_SDP_D_DATA_CUBE_WIDTH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DATA_CUBE_HEIGHT : public ordt_reg {
  public:
    ordt_field<uint32_t> HEIGHT;
    ordt_rg_NVDLA_SDP_D_DATA_CUBE_HEIGHT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DATA_CUBE_CHANNEL : public ordt_reg {
  public:
    ordt_field<uint32_t> CHANNEL;
    ordt_rg_NVDLA_SDP_D_DATA_CUBE_CHANNEL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DST_BASE_ADDR_LOW : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_BASE_ADDR_LOW;
    ordt_rg_NVDLA_SDP_D_DST_BASE_ADDR_LOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DST_BASE_ADDR_HIGH : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_BASE_ADDR_HIGH;
    ordt_rg_NVDLA_SDP_D_DST_BASE_ADDR_HIGH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DST_LINE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_LINE_STRIDE;
    ordt_rg_NVDLA_SDP_D_DST_LINE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DST_SURFACE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_SURFACE_STRIDE;
    ordt_rg_NVDLA_SDP_D_DST_SURFACE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BS_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BS_BYPASS;
    ordt_field<uint_fast8_t> BS_ALU_BYPASS;
    ordt_field<uint_fast8_t> BS_ALU_ALGO;
    ordt_field<uint_fast8_t> BS_MUL_BYPASS;
    ordt_field<uint_fast8_t> BS_MUL_PRELU;
    ordt_field<uint_fast8_t> BS_RELU_BYPASS;
    ordt_rg_NVDLA_SDP_D_DP_BS_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BS_ALU_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BS_ALU_SRC;
    ordt_field<uint_fast8_t> BS_ALU_SHIFT_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BS_ALU_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BS_ALU_SRC_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> BS_ALU_OPERAND;
    ordt_rg_NVDLA_SDP_D_DP_BS_ALU_SRC_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BS_MUL_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BS_MUL_SRC;
    ordt_field<uint_fast8_t> BS_MUL_SHIFT_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BS_MUL_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BS_MUL_SRC_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> BS_MUL_OPERAND;
    ordt_rg_NVDLA_SDP_D_DP_BS_MUL_SRC_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BN_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BN_BYPASS;
    ordt_field<uint_fast8_t> BN_ALU_BYPASS;
    ordt_field<uint_fast8_t> BN_ALU_ALGO;
    ordt_field<uint_fast8_t> BN_MUL_BYPASS;
    ordt_field<uint_fast8_t> BN_MUL_PRELU;
    ordt_field<uint_fast8_t> BN_RELU_BYPASS;
    ordt_rg_NVDLA_SDP_D_DP_BN_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BN_ALU_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BN_ALU_SRC;
    ordt_field<uint_fast8_t> BN_ALU_SHIFT_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BN_ALU_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BN_ALU_SRC_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> BN_ALU_OPERAND;
    ordt_rg_NVDLA_SDP_D_DP_BN_ALU_SRC_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BN_MUL_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BN_MUL_SRC;
    ordt_field<uint_fast8_t> BN_MUL_SHIFT_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BN_MUL_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_BN_MUL_SRC_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> BN_MUL_OPERAND;
    ordt_rg_NVDLA_SDP_D_DP_BN_MUL_SRC_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> EW_BYPASS;
    ordt_field<uint_fast8_t> EW_ALU_BYPASS;
    ordt_field<uint_fast8_t> EW_ALU_ALGO;
    ordt_field<uint_fast8_t> EW_MUL_BYPASS;
    ordt_field<uint_fast8_t> EW_MUL_PRELU;
    ordt_field<uint_fast8_t> EW_LUT_BYPASS;
    ordt_rg_NVDLA_SDP_D_DP_EW_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> EW_ALU_SRC;
    ordt_field<uint_fast8_t> EW_ALU_CVT_BYPASS;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_ALU_SRC_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_ALU_OPERAND;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_SRC_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_OFFSET_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_ALU_CVT_OFFSET;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_OFFSET_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_SCALE_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_ALU_CVT_SCALE;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_SCALE_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_TRUNCATE_VALUE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> EW_ALU_CVT_TRUNCATE;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_TRUNCATE_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> EW_MUL_SRC;
    ordt_field<uint_fast8_t> EW_MUL_CVT_BYPASS;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_MUL_SRC_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_MUL_OPERAND;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_SRC_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_OFFSET_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_MUL_CVT_OFFSET;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_OFFSET_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_SCALE_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_MUL_CVT_SCALE;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_SCALE_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_TRUNCATE_VALUE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> EW_MUL_CVT_TRUNCATE;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_TRUNCATE_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DP_EW_TRUNCATE_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> EW_TRUNCATE;
    ordt_rg_NVDLA_SDP_D_DP_EW_TRUNCATE_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_FEATURE_MODE_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> FLYING_MODE;
    ordt_field<uint_fast8_t> OUTPUT_DST;
    ordt_field<uint_fast8_t> WINOGRAD;
    ordt_field<uint_fast8_t> NAN_TO_ZERO;
    ordt_field<uint_fast8_t> BATCH_NUMBER;
    ordt_rg_NVDLA_SDP_D_FEATURE_MODE_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DST_DMA_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DST_RAM_TYPE;
    ordt_rg_NVDLA_SDP_D_DST_DMA_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DST_BATCH_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_BATCH_STRIDE;
    ordt_rg_NVDLA_SDP_D_DST_BATCH_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_DATA_FORMAT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PROC_PRECISION;
    ordt_field<uint_fast8_t> OUT_PRECISION;
    ordt_rg_NVDLA_SDP_D_DATA_FORMAT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_CVT_OFFSET : public ordt_reg {
  public:
    ordt_field<uint32_t> CVT_OFFSET;
    ordt_rg_NVDLA_SDP_D_CVT_OFFSET(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_CVT_SCALE : public ordt_reg {
  public:
    ordt_field<uint32_t> CVT_SCALE;
    ordt_rg_NVDLA_SDP_D_CVT_SCALE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_CVT_SHIFT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> CVT_SHIFT;
    ordt_rg_NVDLA_SDP_D_CVT_SHIFT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_STATUS : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> STATUS_UNEQUAL;
    ordt_rg_NVDLA_SDP_D_STATUS(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_STATUS_NAN_INPUT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> STATUS_NAN_INPUT_NUM;
    ordt_rg_NVDLA_SDP_D_STATUS_NAN_INPUT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_STATUS_INF_INPUT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> STATUS_INF_INPUT_NUM;
    ordt_rg_NVDLA_SDP_D_STATUS_INF_INPUT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_STATUS_NAN_OUTPUT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> STATUS_NAN_OUTPUT_NUM;
    ordt_rg_NVDLA_SDP_D_STATUS_NAN_OUTPUT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_ENABLE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PERF_DMA_EN;
    ordt_field<uint_fast8_t> PERF_LUT_EN;
    ordt_field<uint_fast8_t> PERF_SAT_EN;
    ordt_field<uint_fast8_t> PERF_NAN_INF_COUNT_EN;
    ordt_rg_NVDLA_SDP_D_PERF_ENABLE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_WDMA_WRITE_STALL : public ordt_reg {
  public:
    ordt_field<uint32_t> WDMA_STALL;
    ordt_rg_NVDLA_SDP_D_PERF_WDMA_WRITE_STALL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_LUT_UFLOW : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_UFLOW;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_UFLOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_LUT_OFLOW : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_OFLOW;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_OFLOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_OUT_SATURATION : public ordt_reg {
  public:
    ordt_field<uint32_t> OUT_SATURATION;
    ordt_rg_NVDLA_SDP_D_PERF_OUT_SATURATION(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_LUT_HYBRID : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_HYBRID;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_HYBRID(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_LUT_LE_HIT : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LE_HIT;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_LE_HIT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_SDP_D_PERF_LUT_LO_HIT : public ordt_reg {
  public:
    ordt_field<uint32_t> LUT_LO_HIT;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_LO_HIT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rset_NVDLA_SDP : public ordt_regset {
  public:
    ordt_rg_NVDLA_SDP_S_STATUS S_STATUS;
    ordt_rg_NVDLA_SDP_S_POINTER S_POINTER;
    ordt_rg_NVDLA_SDP_S_LUT_ACCESS_CFG S_LUT_ACCESS_CFG;
    ordt_rg_NVDLA_SDP_S_LUT_ACCESS_DATA S_LUT_ACCESS_DATA;
    ordt_rg_NVDLA_SDP_S_LUT_CFG S_LUT_CFG;
    ordt_rg_NVDLA_SDP_S_LUT_INFO S_LUT_INFO;
    ordt_rg_NVDLA_SDP_S_LUT_LE_START S_LUT_LE_START;
    ordt_rg_NVDLA_SDP_S_LUT_LE_END S_LUT_LE_END;
    ordt_rg_NVDLA_SDP_S_LUT_LO_START S_LUT_LO_START;
    ordt_rg_NVDLA_SDP_S_LUT_LO_END S_LUT_LO_END;
    ordt_rg_NVDLA_SDP_S_LUT_LE_SLOPE_SCALE S_LUT_LE_SLOPE_SCALE;
    ordt_rg_NVDLA_SDP_S_LUT_LE_SLOPE_SHIFT S_LUT_LE_SLOPE_SHIFT;
    ordt_rg_NVDLA_SDP_S_LUT_LO_SLOPE_SCALE S_LUT_LO_SLOPE_SCALE;
    ordt_rg_NVDLA_SDP_S_LUT_LO_SLOPE_SHIFT S_LUT_LO_SLOPE_SHIFT;
    ordt_rg_NVDLA_SDP_D_OP_ENABLE D_OP_ENABLE;
    ordt_rg_NVDLA_SDP_D_DATA_CUBE_WIDTH D_DATA_CUBE_WIDTH;
    ordt_rg_NVDLA_SDP_D_DATA_CUBE_HEIGHT D_DATA_CUBE_HEIGHT;
    ordt_rg_NVDLA_SDP_D_DATA_CUBE_CHANNEL D_DATA_CUBE_CHANNEL;
    ordt_rg_NVDLA_SDP_D_DST_BASE_ADDR_LOW D_DST_BASE_ADDR_LOW;
    ordt_rg_NVDLA_SDP_D_DST_BASE_ADDR_HIGH D_DST_BASE_ADDR_HIGH;
    ordt_rg_NVDLA_SDP_D_DST_LINE_STRIDE D_DST_LINE_STRIDE;
    ordt_rg_NVDLA_SDP_D_DST_SURFACE_STRIDE D_DST_SURFACE_STRIDE;
    ordt_rg_NVDLA_SDP_D_DP_BS_CFG D_DP_BS_CFG;
    ordt_rg_NVDLA_SDP_D_DP_BS_ALU_CFG D_DP_BS_ALU_CFG;
    ordt_rg_NVDLA_SDP_D_DP_BS_ALU_SRC_VALUE D_DP_BS_ALU_SRC_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BS_MUL_CFG D_DP_BS_MUL_CFG;
    ordt_rg_NVDLA_SDP_D_DP_BS_MUL_SRC_VALUE D_DP_BS_MUL_SRC_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BN_CFG D_DP_BN_CFG;
    ordt_rg_NVDLA_SDP_D_DP_BN_ALU_CFG D_DP_BN_ALU_CFG;
    ordt_rg_NVDLA_SDP_D_DP_BN_ALU_SRC_VALUE D_DP_BN_ALU_SRC_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_BN_MUL_CFG D_DP_BN_MUL_CFG;
    ordt_rg_NVDLA_SDP_D_DP_BN_MUL_SRC_VALUE D_DP_BN_MUL_SRC_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_CFG D_DP_EW_CFG;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CFG D_DP_EW_ALU_CFG;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_SRC_VALUE D_DP_EW_ALU_SRC_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_OFFSET_VALUE D_DP_EW_ALU_CVT_OFFSET_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_SCALE_VALUE D_DP_EW_ALU_CVT_SCALE_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_ALU_CVT_TRUNCATE_VALUE D_DP_EW_ALU_CVT_TRUNCATE_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CFG D_DP_EW_MUL_CFG;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_SRC_VALUE D_DP_EW_MUL_SRC_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_OFFSET_VALUE D_DP_EW_MUL_CVT_OFFSET_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_SCALE_VALUE D_DP_EW_MUL_CVT_SCALE_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_MUL_CVT_TRUNCATE_VALUE D_DP_EW_MUL_CVT_TRUNCATE_VALUE;
    ordt_rg_NVDLA_SDP_D_DP_EW_TRUNCATE_VALUE D_DP_EW_TRUNCATE_VALUE;
    ordt_rg_NVDLA_SDP_D_FEATURE_MODE_CFG D_FEATURE_MODE_CFG;
    ordt_rg_NVDLA_SDP_D_DST_DMA_CFG D_DST_DMA_CFG;
    ordt_rg_NVDLA_SDP_D_DST_BATCH_STRIDE D_DST_BATCH_STRIDE;
    ordt_rg_NVDLA_SDP_D_DATA_FORMAT D_DATA_FORMAT;
    ordt_rg_NVDLA_SDP_D_CVT_OFFSET D_CVT_OFFSET;
    ordt_rg_NVDLA_SDP_D_CVT_SCALE D_CVT_SCALE;
    ordt_rg_NVDLA_SDP_D_CVT_SHIFT D_CVT_SHIFT;
    ordt_rg_NVDLA_SDP_D_STATUS D_STATUS;
    ordt_rg_NVDLA_SDP_D_STATUS_NAN_INPUT_NUM D_STATUS_NAN_INPUT_NUM;
    ordt_rg_NVDLA_SDP_D_STATUS_INF_INPUT_NUM D_STATUS_INF_INPUT_NUM;
    ordt_rg_NVDLA_SDP_D_STATUS_NAN_OUTPUT_NUM D_STATUS_NAN_OUTPUT_NUM;
    ordt_rg_NVDLA_SDP_D_PERF_ENABLE D_PERF_ENABLE;
    ordt_rg_NVDLA_SDP_D_PERF_WDMA_WRITE_STALL D_PERF_WDMA_WRITE_STALL;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_UFLOW D_PERF_LUT_UFLOW;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_OFLOW D_PERF_LUT_OFLOW;
    ordt_rg_NVDLA_SDP_D_PERF_OUT_SATURATION D_PERF_OUT_SATURATION;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_HYBRID D_PERF_LUT_HYBRID;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_LE_HIT D_PERF_LUT_LE_HIT;
    ordt_rg_NVDLA_SDP_D_PERF_LUT_LO_HIT D_PERF_LUT_LO_HIT;
    ordt_rset_NVDLA_SDP(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual void update_child_ptrs();
};

class ordt_root : public ordt_regset {
  public:
    ordt_rset_NVDLA_SDP NVDLA_SDP;
    ordt_root();
    ordt_root(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual void update_child_ptrs();
};

#endif // __ORDT_PIO_HPP_INCLUDED__
