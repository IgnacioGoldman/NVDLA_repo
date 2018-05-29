//   Ordt 171103.01 autogenerated file 
//   Input: NVDLA_PDP.rdl
//   Parms: opendla.parms
//   Date: Sat May 26 21:40:47 CEST 2018
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

class ordt_rg_NVDLA_PDP_S_STATUS : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> STATUS_0;
    ordt_field<uint_fast8_t> STATUS_1;
    ordt_rg_NVDLA_PDP_S_STATUS(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_S_POINTER : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PRODUCER;
    ordt_field<uint_fast8_t> CONSUMER;
    ordt_rg_NVDLA_PDP_S_POINTER(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_OP_ENABLE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> OP_EN;
    ordt_rg_NVDLA_PDP_D_OP_ENABLE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_WIDTH : public ordt_reg {
  public:
    ordt_field<uint32_t> CUBE_IN_WIDTH;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_WIDTH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_HEIGHT : public ordt_reg {
  public:
    ordt_field<uint32_t> CUBE_IN_HEIGHT;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_HEIGHT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_CHANNEL : public ordt_reg {
  public:
    ordt_field<uint32_t> CUBE_IN_CHANNEL;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_CHANNEL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_WIDTH : public ordt_reg {
  public:
    ordt_field<uint32_t> CUBE_OUT_WIDTH;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_WIDTH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_HEIGHT : public ordt_reg {
  public:
    ordt_field<uint32_t> CUBE_OUT_HEIGHT;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_HEIGHT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_CHANNEL : public ordt_reg {
  public:
    ordt_field<uint32_t> CUBE_OUT_CHANNEL;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_CHANNEL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_OPERATION_MODE_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> POOLING_METHOD;
    ordt_field<uint_fast8_t> FLYING_MODE;
    ordt_field<uint_fast8_t> SPLIT_NUM;
    ordt_rg_NVDLA_PDP_D_OPERATION_MODE_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_NAN_FLUSH_TO_ZERO : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> NAN_TO_ZERO;
    ordt_rg_NVDLA_PDP_D_NAN_FLUSH_TO_ZERO(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_PARTIAL_WIDTH_IN : public ordt_reg {
  public:
    ordt_field<uint32_t> PARTIAL_WIDTH_IN_FIRST;
    ordt_field<uint32_t> PARTIAL_WIDTH_IN_LAST;
    ordt_field<uint32_t> PARTIAL_WIDTH_IN_MID;
    ordt_rg_NVDLA_PDP_D_PARTIAL_WIDTH_IN(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_PARTIAL_WIDTH_OUT : public ordt_reg {
  public:
    ordt_field<uint32_t> PARTIAL_WIDTH_OUT_FIRST;
    ordt_field<uint32_t> PARTIAL_WIDTH_OUT_LAST;
    ordt_field<uint32_t> PARTIAL_WIDTH_OUT_MID;
    ordt_rg_NVDLA_PDP_D_PARTIAL_WIDTH_OUT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_KERNEL_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> KERNEL_WIDTH;
    ordt_field<uint_fast8_t> KERNEL_HEIGHT;
    ordt_field<uint_fast8_t> KERNEL_STRIDE_WIDTH;
    ordt_field<uint_fast8_t> KERNEL_STRIDE_HEIGHT;
    ordt_rg_NVDLA_PDP_D_POOLING_KERNEL_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_RECIP_KERNEL_WIDTH : public ordt_reg {
  public:
    ordt_field<uint32_t> RECIP_KERNEL_WIDTH;
    ordt_rg_NVDLA_PDP_D_RECIP_KERNEL_WIDTH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_RECIP_KERNEL_HEIGHT : public ordt_reg {
  public:
    ordt_field<uint32_t> RECIP_KERNEL_HEIGHT;
    ordt_rg_NVDLA_PDP_D_RECIP_KERNEL_HEIGHT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PAD_LEFT;
    ordt_field<uint_fast8_t> PAD_TOP;
    ordt_field<uint_fast8_t> PAD_RIGHT;
    ordt_field<uint_fast8_t> PAD_BOTTOM;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_1_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_1X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_1_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_2_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_2X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_2_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_3_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_3X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_3_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_4_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_4X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_4_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_5_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_5X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_5_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_6_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_6X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_6_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_7_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE_7X;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_7_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_SRC_BASE_ADDR_LOW : public ordt_reg {
  public:
    ordt_field<uint32_t> SRC_BASE_ADDR_LOW;
    ordt_rg_NVDLA_PDP_D_SRC_BASE_ADDR_LOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_SRC_BASE_ADDR_HIGH : public ordt_reg {
  public:
    ordt_field<uint32_t> SRC_BASE_ADDR_HIGH;
    ordt_rg_NVDLA_PDP_D_SRC_BASE_ADDR_HIGH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_SRC_LINE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> SRC_LINE_STRIDE;
    ordt_rg_NVDLA_PDP_D_SRC_LINE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_SRC_SURFACE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> SRC_SURFACE_STRIDE;
    ordt_rg_NVDLA_PDP_D_SRC_SURFACE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DST_BASE_ADDR_LOW : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_BASE_ADDR_LOW;
    ordt_rg_NVDLA_PDP_D_DST_BASE_ADDR_LOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DST_BASE_ADDR_HIGH : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_BASE_ADDR_HIGH;
    ordt_rg_NVDLA_PDP_D_DST_BASE_ADDR_HIGH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DST_LINE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_LINE_STRIDE;
    ordt_rg_NVDLA_PDP_D_DST_LINE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DST_SURFACE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> DST_SURFACE_STRIDE;
    ordt_rg_NVDLA_PDP_D_DST_SURFACE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DST_RAM_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DST_RAM_TYPE;
    ordt_rg_NVDLA_PDP_D_DST_RAM_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_DATA_FORMAT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> INPUT_DATA;
    ordt_rg_NVDLA_PDP_D_DATA_FORMAT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_INF_INPUT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> INF_INPUT_NUM;
    ordt_rg_NVDLA_PDP_D_INF_INPUT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_NAN_INPUT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> NAN_INPUT_NUM;
    ordt_rg_NVDLA_PDP_D_NAN_INPUT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_NAN_OUTPUT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> NAN_OUTPUT_NUM;
    ordt_rg_NVDLA_PDP_D_NAN_OUTPUT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_PERF_ENABLE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DMA_EN;
    ordt_rg_NVDLA_PDP_D_PERF_ENABLE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_PERF_WRITE_STALL : public ordt_reg {
  public:
    ordt_field<uint32_t> PERF_WRITE_STALL;
    ordt_rg_NVDLA_PDP_D_PERF_WRITE_STALL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_PDP_D_CYA : public ordt_reg {
  public:
    ordt_field<uint32_t> CYA;
    ordt_rg_NVDLA_PDP_D_CYA(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rset_NVDLA_PDP : public ordt_regset {
  public:
    ordt_rg_NVDLA_PDP_S_STATUS S_STATUS;
    ordt_rg_NVDLA_PDP_S_POINTER S_POINTER;
    ordt_rg_NVDLA_PDP_D_OP_ENABLE D_OP_ENABLE;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_WIDTH D_DATA_CUBE_IN_WIDTH;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_HEIGHT D_DATA_CUBE_IN_HEIGHT;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_IN_CHANNEL D_DATA_CUBE_IN_CHANNEL;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_WIDTH D_DATA_CUBE_OUT_WIDTH;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_HEIGHT D_DATA_CUBE_OUT_HEIGHT;
    ordt_rg_NVDLA_PDP_D_DATA_CUBE_OUT_CHANNEL D_DATA_CUBE_OUT_CHANNEL;
    ordt_rg_NVDLA_PDP_D_OPERATION_MODE_CFG D_OPERATION_MODE_CFG;
    ordt_rg_NVDLA_PDP_D_NAN_FLUSH_TO_ZERO D_NAN_FLUSH_TO_ZERO;
    ordt_rg_NVDLA_PDP_D_PARTIAL_WIDTH_IN D_PARTIAL_WIDTH_IN;
    ordt_rg_NVDLA_PDP_D_PARTIAL_WIDTH_OUT D_PARTIAL_WIDTH_OUT;
    ordt_rg_NVDLA_PDP_D_POOLING_KERNEL_CFG D_POOLING_KERNEL_CFG;
    ordt_rg_NVDLA_PDP_D_RECIP_KERNEL_WIDTH D_RECIP_KERNEL_WIDTH;
    ordt_rg_NVDLA_PDP_D_RECIP_KERNEL_HEIGHT D_RECIP_KERNEL_HEIGHT;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_CFG D_POOLING_PADDING_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_1_CFG D_POOLING_PADDING_VALUE_1_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_2_CFG D_POOLING_PADDING_VALUE_2_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_3_CFG D_POOLING_PADDING_VALUE_3_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_4_CFG D_POOLING_PADDING_VALUE_4_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_5_CFG D_POOLING_PADDING_VALUE_5_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_6_CFG D_POOLING_PADDING_VALUE_6_CFG;
    ordt_rg_NVDLA_PDP_D_POOLING_PADDING_VALUE_7_CFG D_POOLING_PADDING_VALUE_7_CFG;
    ordt_rg_NVDLA_PDP_D_SRC_BASE_ADDR_LOW D_SRC_BASE_ADDR_LOW;
    ordt_rg_NVDLA_PDP_D_SRC_BASE_ADDR_HIGH D_SRC_BASE_ADDR_HIGH;
    ordt_rg_NVDLA_PDP_D_SRC_LINE_STRIDE D_SRC_LINE_STRIDE;
    ordt_rg_NVDLA_PDP_D_SRC_SURFACE_STRIDE D_SRC_SURFACE_STRIDE;
    ordt_rg_NVDLA_PDP_D_DST_BASE_ADDR_LOW D_DST_BASE_ADDR_LOW;
    ordt_rg_NVDLA_PDP_D_DST_BASE_ADDR_HIGH D_DST_BASE_ADDR_HIGH;
    ordt_rg_NVDLA_PDP_D_DST_LINE_STRIDE D_DST_LINE_STRIDE;
    ordt_rg_NVDLA_PDP_D_DST_SURFACE_STRIDE D_DST_SURFACE_STRIDE;
    ordt_rg_NVDLA_PDP_D_DST_RAM_CFG D_DST_RAM_CFG;
    ordt_rg_NVDLA_PDP_D_DATA_FORMAT D_DATA_FORMAT;
    ordt_rg_NVDLA_PDP_D_INF_INPUT_NUM D_INF_INPUT_NUM;
    ordt_rg_NVDLA_PDP_D_NAN_INPUT_NUM D_NAN_INPUT_NUM;
    ordt_rg_NVDLA_PDP_D_NAN_OUTPUT_NUM D_NAN_OUTPUT_NUM;
    ordt_rg_NVDLA_PDP_D_PERF_ENABLE D_PERF_ENABLE;
    ordt_rg_NVDLA_PDP_D_PERF_WRITE_STALL D_PERF_WRITE_STALL;
    ordt_rg_NVDLA_PDP_D_CYA D_CYA;
    ordt_rset_NVDLA_PDP(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual void update_child_ptrs();
};

class ordt_root : public ordt_regset {
  public:
    ordt_rset_NVDLA_PDP NVDLA_PDP;
    ordt_root();
    ordt_root(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual void update_child_ptrs();
};

#endif // __ORDT_PIO_HPP_INCLUDED__
