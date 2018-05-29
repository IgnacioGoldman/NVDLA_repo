`define NVDLA_FEATURE_DATA_TYPE_INT8
`define NVDLA_BPE 8
`define NVDLA_WEIGHT_DATA_TYPE_INT8
`define NVDLA_WEIGHT_COMPRESSION_ENABLE
`define NVDLA_WINOGRAD_ENABLE
`define NVDLA_BATCH_ENABLE
`define NVDLA_SECONDARY_MEMIF_ENABLE
`define NVDLA_SDP_LUT_ENABLE
`define NVDLA_SDP_BS_ENABLE
`define NVDLA_SDP_BN_ENABLE
`define NVDLA_SDP_EW_ENABLE
`define NVDLA_BDMA_ENABLE
`define NVDLA_RUBIK_ENABLE
`define NVDLA_RUBIK_CONTRACT_ENABLE
`define NVDLA_RUBIK_RESHAPE_ENABLE
`define NVDLA_PDP_ENABLE
`define NVDLA_CDP_ENABLE
`define NVDLA_RETIMING_ENABLE
`define NVDLA_MAC_ATOMIC_C_SIZE 64
`define NVDLA_MAC_ATOMIC_K_SIZE 32
`define NVDLA_MEMORY_ATOMIC_SIZE 32
`define NVDLA_MAX_BATCH_SIZE 32
`define NVDLA_CBUF_BANK_NUMBER 16
`define NVDLA_CBUF_BANK_WIDTH 64
`define NVDLA_CBUF_BANK_DEPTH 512
`define NVDLA_SDP_BS_THROUGHPUT 16
`define NVDLA_SDP_BN_THROUGHPUT 16
`define NVDLA_SDP_EW_THROUGHPUT 4
`define NVDLA_SDP_MAX_THROUGHPUT 16
`define NVDLA_SDP2PDP_WIDTH 128
`define NVDLA_PDP_THROUGHPUT 8
`define NVDLA_CDP_THROUGHPUT 8
`define NVDLA_PRIMARY_MEMIF_LATENCY 1200
`define NVDLA_SECONDARY_MEMIF_LATENCY 128
`define NVDLA_PRIMARY_MEMIF_MAX_BURST_LENGTH 1
`define NVDLA_PRIMARY_MEMIF_WIDTH 512
`define NVDLA_SECONDARY_MEMIF_MAX_BURST_LENGTH 4
`define NVDLA_SECONDARY_MEMIF_WIDTH 512
`define NVDLA_MEM_ADDRESS_WIDTH 64
`define NVDLA_MEMIF_WIDTH 512
`define NVDLA_DMA_RD_SIZE 15
`define NVDLA_DMA_WR_SIZE 13
`define NVDLA_DMA_MASK_BIT 2
`define NVDLA_DMA_RD_RSP 514
`define NVDLA_DMA_WR_REQ 515
`define NVDLA_DMA_WR_CMD 78
`define NVDLA_DMA_RD_REQ 79
`define NVDLA_MEMORY_ATOMIC_LOG2 5
`define NVDLA_PRIMARY_MEMIF_WIDTH_LOG2 6
`define NVDLA_SECONDARY_MEMIF_WIDTH_LOG2 6
`define NVDLA_NUM_DMA_READ_CLIENTS 10
`define NVDLA_NUM_DMA_WRITE_CLIENTS 5
`define NVDLA_MAC_ATOMIC_C_SIZE_LOG2 6
`define NVDLA_MAC_ATOMIC_K_SIZE_LOG2 5
`define NVDLA_CBUF_BANK_NUMBER_LOG2 4
`define NVDLA_CBUF_BANK_WIDTH_LOG2 6
`define NVDLA_CBUF_BANK_DEPTH_LOG2 9
`define NVDLA_CBUF_DEPTH_LOG2 13
`define NVDLA_CBUF_ENTRY_WIDTH 512
`define NVDLA_CBUF_WIDTH_LOG2 9
`define NVDLA_CBUF_WIDTH_MUL2_LOG2 10
`define NVDLA_BPE_LOG2 3
`define NVDLA_MAC_RESULT_WIDTH 22
`define NVDLA_CC_ATOMC_DIV_ATOMK 2