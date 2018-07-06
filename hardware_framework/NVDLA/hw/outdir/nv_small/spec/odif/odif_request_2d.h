#if !defined(_request_2d_iface_H_)
#define _request_2d_iface_H_

#include <stdint.h>
typedef struct request_2d_s {
    sc_int<12> addr ;
    sc_int<1> write ;
    sc_int<32> data[2] ;
} request_2d_t;

#endif // !defined(_request_2d_iface_H_)
