#if !defined(_request_iface_H_)
#define _request_iface_H_

#include <stdint.h>
typedef struct request_s {
    sc_int<12> addr ;
    sc_int<1> write ;
    sc_int<32> data ;
} request_t;

#endif // !defined(_request_iface_H_)
