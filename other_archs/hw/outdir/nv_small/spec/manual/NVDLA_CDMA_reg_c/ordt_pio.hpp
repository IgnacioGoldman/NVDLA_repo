//   Ordt 171103.01 autogenerated file 
//   Input: NVDLA_CDMA.rdl
//   Parms: opendla.parms
//   Date: Tue May 29 01:10:18 CEST 2018
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

class ordt_rg_NVDLA_CDMA_S_STATUS : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> STATUS_0;
    ordt_field<uint_fast8_t> STATUS_1;
    ordt_rg_NVDLA_CDMA_S_STATUS(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_S_POINTER : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PRODUCER;
    ordt_field<uint_fast8_t> CONSUMER;
    ordt_rg_NVDLA_CDMA_S_POINTER(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_S_ARBITER : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> ARB_WEIGHT;
    ordt_field<uint_fast8_t> ARB_WMB;
    ordt_rg_NVDLA_CDMA_S_ARBITER(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_S_CBUF_FLUSH_STATUS : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> FLUSH_DONE;
    ordt_rg_NVDLA_CDMA_S_CBUF_FLUSH_STATUS(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_OP_ENABLE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> OP_EN;
    ordt_rg_NVDLA_CDMA_D_OP_ENABLE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_MISC_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> CONV_MODE;
    ordt_field<uint_fast8_t> IN_PRECISION;
    ordt_field<uint_fast8_t> PROC_PRECISION;
    ordt_field<uint_fast8_t> DATA_REUSE;
    ordt_field<uint_fast8_t> WEIGHT_REUSE;
    ordt_field<uint_fast8_t> SKIP_DATA_RLS;
    ordt_field<uint_fast8_t> SKIP_WEIGHT_RLS;
    ordt_rg_NVDLA_CDMA_D_MISC_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DATAIN_FORMAT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DATAIN_FORMAT;
    ordt_field<uint_fast8_t> PIXEL_FORMAT;
    ordt_field<uint_fast8_t> PIXEL_MAPPING;
    ordt_field<uint_fast8_t> PIXEL_SIGN_OVERRIDE;
    ordt_rg_NVDLA_CDMA_D_DATAIN_FORMAT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_0 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_WIDTH;
    ordt_field<uint32_t> DATAIN_HEIGHT;
    ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_0(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_1 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_CHANNEL;
    ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_1(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_EXT_0 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_WIDTH_EXT;
    ordt_field<uint32_t> DATAIN_HEIGHT_EXT;
    ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_EXT_0(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_PIXEL_OFFSET : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PIXEL_X_OFFSET;
    ordt_field<uint_fast8_t> PIXEL_Y_OFFSET;
    ordt_rg_NVDLA_CDMA_D_PIXEL_OFFSET(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DAIN_RAM_TYPE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DATAIN_RAM_TYPE;
    ordt_rg_NVDLA_CDMA_D_DAIN_RAM_TYPE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_HIGH_0 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_ADDR_HIGH_0;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_HIGH_0(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_LOW_0 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_ADDR_LOW_0;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_LOW_0(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_HIGH_1 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_ADDR_HIGH_1;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_HIGH_1(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_LOW_1 : public ordt_reg {
  public:
    ordt_field<uint32_t> DATAIN_ADDR_LOW_1;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_LOW_1(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_LINE_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> LINE_STRIDE;
    ordt_rg_NVDLA_CDMA_D_LINE_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_LINE_UV_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> UV_LINE_STRIDE;
    ordt_rg_NVDLA_CDMA_D_LINE_UV_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_SURF_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> SURF_STRIDE;
    ordt_rg_NVDLA_CDMA_D_SURF_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_DAIN_MAP : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> LINE_PACKED;
    ordt_field<uint_fast8_t> SURF_PACKED;
    ordt_rg_NVDLA_CDMA_D_DAIN_MAP(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_RESERVED_X_CFG : public ordt_reg {
  public:
    ordt_field<uint32_t> RSV_PER_LINE;
    ordt_field<uint32_t> RSV_PER_UV_LINE;
    ordt_rg_NVDLA_CDMA_D_RESERVED_X_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_RESERVED_Y_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> RSV_HEIGHT;
    ordt_field<uint_fast8_t> RSV_Y_INDEX;
    ordt_rg_NVDLA_CDMA_D_RESERVED_Y_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_BATCH_NUMBER : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> BATCHES;
    ordt_rg_NVDLA_CDMA_D_BATCH_NUMBER(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_BATCH_STRIDE : public ordt_reg {
  public:
    ordt_field<uint32_t> BATCH_STRIDE;
    ordt_rg_NVDLA_CDMA_D_BATCH_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_ENTRY_PER_SLICE : public ordt_reg {
  public:
    ordt_field<uint32_t> ENTRIES;
    ordt_rg_NVDLA_CDMA_D_ENTRY_PER_SLICE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_FETCH_GRAIN : public ordt_reg {
  public:
    ordt_field<uint32_t> GRAINS;
    ordt_rg_NVDLA_CDMA_D_FETCH_GRAIN(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_FORMAT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> WEIGHT_FORMAT;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_FORMAT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_SIZE_0 : public ordt_reg {
  public:
    ordt_field<uint32_t> BYTE_PER_KERNEL;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_SIZE_0(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_SIZE_1 : public ordt_reg {
  public:
    ordt_field<uint32_t> WEIGHT_KERNEL;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_SIZE_1(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_RAM_TYPE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> WEIGHT_RAM_TYPE;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_RAM_TYPE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_ADDR_HIGH : public ordt_reg {
  public:
    ordt_field<uint32_t> WEIGHT_ADDR_HIGH;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_ADDR_HIGH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_ADDR_LOW : public ordt_reg {
  public:
    ordt_field<uint32_t> WEIGHT_ADDR_LOW;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_ADDR_LOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WEIGHT_BYTES : public ordt_reg {
  public:
    ordt_field<uint32_t> WEIGHT_BYTES;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_BYTES(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WGS_ADDR_HIGH : public ordt_reg {
  public:
    ordt_field<uint32_t> WGS_ADDR_HIGH;
    ordt_rg_NVDLA_CDMA_D_WGS_ADDR_HIGH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WGS_ADDR_LOW : public ordt_reg {
  public:
    ordt_field<uint32_t> WGS_ADDR_LOW;
    ordt_rg_NVDLA_CDMA_D_WGS_ADDR_LOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WMB_ADDR_HIGH : public ordt_reg {
  public:
    ordt_field<uint32_t> WMB_ADDR_HIGH;
    ordt_rg_NVDLA_CDMA_D_WMB_ADDR_HIGH(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WMB_ADDR_LOW : public ordt_reg {
  public:
    ordt_field<uint32_t> WMB_ADDR_LOW;
    ordt_rg_NVDLA_CDMA_D_WMB_ADDR_LOW(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_WMB_BYTES : public ordt_reg {
  public:
    ordt_field<uint32_t> WMB_BYTES;
    ordt_rg_NVDLA_CDMA_D_WMB_BYTES(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_MEAN_FORMAT : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> MEAN_FORMAT;
    ordt_rg_NVDLA_CDMA_D_MEAN_FORMAT(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_MEAN_GLOBAL_0 : public ordt_reg {
  public:
    ordt_field<uint32_t> MEAN_RY;
    ordt_field<uint32_t> MEAN_GU;
    ordt_rg_NVDLA_CDMA_D_MEAN_GLOBAL_0(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_MEAN_GLOBAL_1 : public ordt_reg {
  public:
    ordt_field<uint32_t> MEAN_BV;
    ordt_field<uint32_t> MEAN_AX;
    ordt_rg_NVDLA_CDMA_D_MEAN_GLOBAL_1(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_CVT_CFG : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> CVT_EN;
    ordt_field<uint_fast8_t> CVT_TRUNCATE;
    ordt_rg_NVDLA_CDMA_D_CVT_CFG(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_CVT_OFFSET : public ordt_reg {
  public:
    ordt_field<uint32_t> CVT_OFFSET;
    ordt_rg_NVDLA_CDMA_D_CVT_OFFSET(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_CVT_SCALE : public ordt_reg {
  public:
    ordt_field<uint32_t> CVT_SCALE;
    ordt_rg_NVDLA_CDMA_D_CVT_SCALE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_CONV_STRIDE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> CONV_X_STRIDE;
    ordt_field<uint_fast8_t> CONV_Y_STRIDE;
    ordt_rg_NVDLA_CDMA_D_CONV_STRIDE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_ZERO_PADDING : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> PAD_LEFT;
    ordt_field<uint_fast8_t> PAD_RIGHT;
    ordt_field<uint_fast8_t> PAD_TOP;
    ordt_field<uint_fast8_t> PAD_BOTTOM;
    ordt_rg_NVDLA_CDMA_D_ZERO_PADDING(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_ZERO_PADDING_VALUE : public ordt_reg {
  public:
    ordt_field<uint32_t> PAD_VALUE;
    ordt_rg_NVDLA_CDMA_D_ZERO_PADDING_VALUE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_BANK : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DATA_BANK;
    ordt_field<uint_fast8_t> WEIGHT_BANK;
    ordt_rg_NVDLA_CDMA_D_BANK(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_NAN_FLUSH_TO_ZERO : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> NAN_TO_ZERO;
    ordt_rg_NVDLA_CDMA_D_NAN_FLUSH_TO_ZERO(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_NAN_INPUT_DATA_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> NAN_DATA_NUM;
    ordt_rg_NVDLA_CDMA_D_NAN_INPUT_DATA_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_NAN_INPUT_WEIGHT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> NAN_WEIGHT_NUM;
    ordt_rg_NVDLA_CDMA_D_NAN_INPUT_WEIGHT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_INF_INPUT_DATA_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> INF_DATA_NUM;
    ordt_rg_NVDLA_CDMA_D_INF_INPUT_DATA_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_INF_INPUT_WEIGHT_NUM : public ordt_reg {
  public:
    ordt_field<uint32_t> INF_WEIGHT_NUM;
    ordt_rg_NVDLA_CDMA_D_INF_INPUT_WEIGHT_NUM(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_PERF_ENABLE : public ordt_reg {
  public:
    ordt_field<uint_fast8_t> DMA_EN;
    ordt_rg_NVDLA_CDMA_D_PERF_ENABLE(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_PERF_DAT_READ_STALL : public ordt_reg {
  public:
    ordt_field<uint32_t> DAT_RD_STALL;
    ordt_rg_NVDLA_CDMA_D_PERF_DAT_READ_STALL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_PERF_WT_READ_STALL : public ordt_reg {
  public:
    ordt_field<uint32_t> WT_RD_STALL;
    ordt_rg_NVDLA_CDMA_D_PERF_WT_READ_STALL(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_PERF_DAT_READ_LATENCY : public ordt_reg {
  public:
    ordt_field<uint32_t> DAT_RD_LATENCY;
    ordt_rg_NVDLA_CDMA_D_PERF_DAT_READ_LATENCY(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_PERF_WT_READ_LATENCY : public ordt_reg {
  public:
    ordt_field<uint32_t> WT_RD_LATENCY;
    ordt_rg_NVDLA_CDMA_D_PERF_WT_READ_LATENCY(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rg_NVDLA_CDMA_D_CYA : public ordt_reg {
  public:
    ordt_field<uint32_t> CYA;
    ordt_rg_NVDLA_CDMA_D_CYA(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual int write(const uint64_t &addr, const ordt_data &wdata);
    virtual void write(const ordt_data &wdata);
    virtual int read(const uint64_t &addr, ordt_data &rdata);
    virtual void read(ordt_data &rdata);
};

class ordt_rset_NVDLA_CDMA : public ordt_regset {
  public:
    ordt_rg_NVDLA_CDMA_S_STATUS S_STATUS;
    ordt_rg_NVDLA_CDMA_S_POINTER S_POINTER;
    ordt_rg_NVDLA_CDMA_S_ARBITER S_ARBITER;
    ordt_rg_NVDLA_CDMA_S_CBUF_FLUSH_STATUS S_CBUF_FLUSH_STATUS;
    ordt_rg_NVDLA_CDMA_D_OP_ENABLE D_OP_ENABLE;
    ordt_rg_NVDLA_CDMA_D_MISC_CFG D_MISC_CFG;
    ordt_rg_NVDLA_CDMA_D_DATAIN_FORMAT D_DATAIN_FORMAT;
    ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_0 D_DATAIN_SIZE_0;
    ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_1 D_DATAIN_SIZE_1;
    ordt_rg_NVDLA_CDMA_D_DATAIN_SIZE_EXT_0 D_DATAIN_SIZE_EXT_0;
    ordt_rg_NVDLA_CDMA_D_PIXEL_OFFSET D_PIXEL_OFFSET;
    ordt_rg_NVDLA_CDMA_D_DAIN_RAM_TYPE D_DAIN_RAM_TYPE;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_HIGH_0 D_DAIN_ADDR_HIGH_0;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_LOW_0 D_DAIN_ADDR_LOW_0;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_HIGH_1 D_DAIN_ADDR_HIGH_1;
    ordt_rg_NVDLA_CDMA_D_DAIN_ADDR_LOW_1 D_DAIN_ADDR_LOW_1;
    ordt_rg_NVDLA_CDMA_D_LINE_STRIDE D_LINE_STRIDE;
    ordt_rg_NVDLA_CDMA_D_LINE_UV_STRIDE D_LINE_UV_STRIDE;
    ordt_rg_NVDLA_CDMA_D_SURF_STRIDE D_SURF_STRIDE;
    ordt_rg_NVDLA_CDMA_D_DAIN_MAP D_DAIN_MAP;
    ordt_rg_NVDLA_CDMA_D_RESERVED_X_CFG D_RESERVED_X_CFG;
    ordt_rg_NVDLA_CDMA_D_RESERVED_Y_CFG D_RESERVED_Y_CFG;
    ordt_rg_NVDLA_CDMA_D_BATCH_NUMBER D_BATCH_NUMBER;
    ordt_rg_NVDLA_CDMA_D_BATCH_STRIDE D_BATCH_STRIDE;
    ordt_rg_NVDLA_CDMA_D_ENTRY_PER_SLICE D_ENTRY_PER_SLICE;
    ordt_rg_NVDLA_CDMA_D_FETCH_GRAIN D_FETCH_GRAIN;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_FORMAT D_WEIGHT_FORMAT;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_SIZE_0 D_WEIGHT_SIZE_0;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_SIZE_1 D_WEIGHT_SIZE_1;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_RAM_TYPE D_WEIGHT_RAM_TYPE;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_ADDR_HIGH D_WEIGHT_ADDR_HIGH;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_ADDR_LOW D_WEIGHT_ADDR_LOW;
    ordt_rg_NVDLA_CDMA_D_WEIGHT_BYTES D_WEIGHT_BYTES;
    ordt_rg_NVDLA_CDMA_D_WGS_ADDR_HIGH D_WGS_ADDR_HIGH;
    ordt_rg_NVDLA_CDMA_D_WGS_ADDR_LOW D_WGS_ADDR_LOW;
    ordt_rg_NVDLA_CDMA_D_WMB_ADDR_HIGH D_WMB_ADDR_HIGH;
    ordt_rg_NVDLA_CDMA_D_WMB_ADDR_LOW D_WMB_ADDR_LOW;
    ordt_rg_NVDLA_CDMA_D_WMB_BYTES D_WMB_BYTES;
    ordt_rg_NVDLA_CDMA_D_MEAN_FORMAT D_MEAN_FORMAT;
    ordt_rg_NVDLA_CDMA_D_MEAN_GLOBAL_0 D_MEAN_GLOBAL_0;
    ordt_rg_NVDLA_CDMA_D_MEAN_GLOBAL_1 D_MEAN_GLOBAL_1;
    ordt_rg_NVDLA_CDMA_D_CVT_CFG D_CVT_CFG;
    ordt_rg_NVDLA_CDMA_D_CVT_OFFSET D_CVT_OFFSET;
    ordt_rg_NVDLA_CDMA_D_CVT_SCALE D_CVT_SCALE;
    ordt_rg_NVDLA_CDMA_D_CONV_STRIDE D_CONV_STRIDE;
    ordt_rg_NVDLA_CDMA_D_ZERO_PADDING D_ZERO_PADDING;
    ordt_rg_NVDLA_CDMA_D_ZERO_PADDING_VALUE D_ZERO_PADDING_VALUE;
    ordt_rg_NVDLA_CDMA_D_BANK D_BANK;
    ordt_rg_NVDLA_CDMA_D_NAN_FLUSH_TO_ZERO D_NAN_FLUSH_TO_ZERO;
    ordt_rg_NVDLA_CDMA_D_NAN_INPUT_DATA_NUM D_NAN_INPUT_DATA_NUM;
    ordt_rg_NVDLA_CDMA_D_NAN_INPUT_WEIGHT_NUM D_NAN_INPUT_WEIGHT_NUM;
    ordt_rg_NVDLA_CDMA_D_INF_INPUT_DATA_NUM D_INF_INPUT_DATA_NUM;
    ordt_rg_NVDLA_CDMA_D_INF_INPUT_WEIGHT_NUM D_INF_INPUT_WEIGHT_NUM;
    ordt_rg_NVDLA_CDMA_D_PERF_ENABLE D_PERF_ENABLE;
    ordt_rg_NVDLA_CDMA_D_PERF_DAT_READ_STALL D_PERF_DAT_READ_STALL;
    ordt_rg_NVDLA_CDMA_D_PERF_WT_READ_STALL D_PERF_WT_READ_STALL;
    ordt_rg_NVDLA_CDMA_D_PERF_DAT_READ_LATENCY D_PERF_DAT_READ_LATENCY;
    ordt_rg_NVDLA_CDMA_D_PERF_WT_READ_LATENCY D_PERF_WT_READ_LATENCY;
    ordt_rg_NVDLA_CDMA_D_CYA D_CYA;
    ordt_rset_NVDLA_CDMA(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual void update_child_ptrs();
};

class ordt_root : public ordt_regset {
  public:
    ordt_rset_NVDLA_CDMA NVDLA_CDMA;
    ordt_root();
    ordt_root(uint64_t _m_startaddress, uint64_t _m_endaddress);
    virtual void update_child_ptrs();
};

#endif // __ORDT_PIO_HPP_INCLUDED__
