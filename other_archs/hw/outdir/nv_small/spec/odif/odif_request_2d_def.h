#if !defined(_request_2d_IFACE)
#define _request_2d_IFACE

#define FLOW_request_2d valid_ready

#define SIG_request_2d_addr_WIDTH 12
#define SIG_request_2d_addr_FIELD 11:0
#define SIG_request_2d_write_WIDTH 1
#define SIG_request_2d_write_FIELD 0:0
#define SIG_request_2d_data0_WIDTH 32
#define SIG_request_2d_data0_FIELD 31:0
#define SIG_request_2d_data1_WIDTH 32
#define SIG_request_2d_data1_FIELD 31:0

#endif // !defined(_request_2d_IFACE)