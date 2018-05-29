#if !defined(_command_IFACE)
#define _command_IFACE

#define PKT_Write_addr_WIDTH 12
#define PKT_Write_addr_LSB 0
#define PKT_Write_addr_MSB 11
#define PKT_Write_addr_FIELD 11:0
#define PKT_Write_data_WIDTH 32
#define PKT_Write_data_LSB 12
#define PKT_Write_data_MSB 43
#define PKT_Write_data_FIELD 43:12
#define PKT_Write_WIDTH 44

#define PKT_Read_addr_WIDTH 12
#define PKT_Read_addr_LSB 0
#define PKT_Read_addr_MSB 11
#define PKT_Read_addr_FIELD 11:0
#define PKT_Read_size_WIDTH 4
#define PKT_Read_size_LSB 12
#define PKT_Read_size_MSB 15
#define PKT_Read_size_FIELD 15:12
#define PKT_Read_WIDTH 16

#define PKT_Flush_addr_start_WIDTH 1
#define PKT_Flush_addr_start_LSB 0
#define PKT_Flush_addr_start_MSB 0
#define PKT_Flush_addr_start_FIELD 0:0
#define PKT_Flush_addr_end_WIDTH 1
#define PKT_Flush_addr_end_LSB 1
#define PKT_Flush_addr_end_MSB 1
#define PKT_Flush_addr_end_FIELD 1:1
#define PKT_Flush_WIDTH 2

#define FLOW_command valid_ready

#define SIG_command_PD_WIDTH 46
#define SIG_command_PD_FIELD 45:0

#define PKT_command_PAYLOAD_WIDTH    44
#define PKT_command_PAYLOAD_FIELD    43:0
#define PKT_command_ID_WIDTH    2
#define PKT_command_ID_FIELD    45:44
#define PKT_command_Write_FIELD    43:0
#define PKT_command_Write_ID       2'd0
#define PKT_command_Write_int_ID   0
#define PKT_command_Read_FIELD    15:0
#define PKT_command_Read_ID       2'd1
#define PKT_command_Read_int_ID   1
#define PKT_command_Flush_FIELD    1:0
#define PKT_command_Flush_ID       2'd2
#define PKT_command_Flush_int_ID   2

#endif // !defined(_command_IFACE)
