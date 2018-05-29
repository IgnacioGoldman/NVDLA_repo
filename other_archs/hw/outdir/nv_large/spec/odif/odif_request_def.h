#if !defined(_request_IFACE)
#define _request_IFACE

#define FLOW_request valid_ready

#define SIG_request_addr_WIDTH 12
#define SIG_request_addr_FIELD 11:0
#define SIG_request_write_WIDTH 1
#define SIG_request_write_FIELD 0:0
#define SIG_request_data_WIDTH 32
#define SIG_request_data_FIELD 31:0

#endif // !defined(_request_IFACE)