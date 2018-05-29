//#define NV_SMALL 1
#define FEATURE_DATA_TYPE_INT8
#define WEIGHT_DATA_TYPE_INT8
#define WEIGHT_COMPRESSION_DISABLE
#define WINOGRAD_DISABLE 
#define BATCH_DISABLE
#define SECONDARY_MEMIF_DISABLE
#define SDP_LUT_DISABLE
#define SDP_BS_ENABLE
#define SDP_BN_ENABLE
#define SDP_EW_DISABLE
#define BDMA_DISABLE
#define RUBIK_DISABLE
#define RUBIK_CONTRACT_DISABLE
#define RUBIK_RESHAPE_DISABLE
#define PDP_ENABLE
#define CDP_ENABLE
#define RETIMING_DISABLE
#define MAC_ATOMIC_C_SIZE_32
#define MAC_ATOMIC_K_SIZE_8
#define MEMORY_ATOMIC_SIZE_8
#define MAX_BATCH_SIZE_x
#define CBUF_BANK_NUMBER_32
#define CBUF_BANK_WIDTH_32
#define CBUF_BANK_DEPTH_128
#define SDP_BS_THROUGHPUT_1
#define SDP_BN_THROUGHPUT_1
#define SDP_EW_THROUGHPUT_x
#define PDP_THROUGHPUT_1
#define CDP_THROUGHPUT_1
#define PRIMARY_MEMIF_LATENCY_50
#define SECONDARY_MEMIF_LATENCY_x
//#define PRIMARY_MEMIF_MAX_BURST_LENGTH_4
#define PRIMARY_MEMIF_MAX_BURST_LENGTH_1
#define PRIMARY_MEMIF_WIDTH_64
#define SECONDARY_MEMIF_MAX_BURST_LENGTH_x
#define SECONDARY_MEMIF_WIDTH_512
#define MEM_ADDRESS_WIDTH_32
#define NUM_DMA_READ_CLIENTS_7
#define NUM_DMA_WRITE_CLIENTS_3



#include "projects.spec"
