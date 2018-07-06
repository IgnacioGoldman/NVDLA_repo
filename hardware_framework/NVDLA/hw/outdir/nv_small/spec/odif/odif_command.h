#if !defined(_command_iface_H_)
#define _command_iface_H_

#include <stdint.h>
#ifndef _Write_struct_H_
#define _Write_struct_H_

typedef struct Write_s {
    sc_int<12> addr ;
    sc_int<32> data ;
} Write_t;

#endif
#ifndef _Read_struct_H_
#define _Read_struct_H_

typedef struct Read_s {
    sc_int<12> addr ;
    sc_int<4> size ;
} Read_t;

#endif
#ifndef _Flush_struct_H_
#define _Flush_struct_H_

typedef struct Flush_s {
    sc_int<1> addr_start ;
    sc_int<1> addr_end ;
} Flush_t;

#endif
union command_u {
    Write_t Write;
    Read_t Read;
    Flush_t Flush;
};
typedef struct command_s {
    union command_u pd ;
} command_t;

#endif // !defined(_command_iface_H_)
