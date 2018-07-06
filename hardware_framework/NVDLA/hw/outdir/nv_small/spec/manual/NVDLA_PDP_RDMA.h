// Register NVDLA_PDP_RDMA_S_STATUS_0
#define NVDLA_PDP_RDMA_S_STATUS_0			_MK_ADDR_CONST(0xa000)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_0_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_0_FIELD			_MK_FIELD_CONST(0x3, NVDLA_PDP_RDMA_S_STATUS_0_STATUS_0_SHIFT)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_0_IDLE			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_0_RUNNING			_MK_ENUM_CONST(0x1)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_0_PENDING			_MK_ENUM_CONST(0x2)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_1_SHIFT			_MK_SHIFT_CONST(16)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_1_FIELD			_MK_FIELD_CONST(0x3, NVDLA_PDP_RDMA_S_STATUS_0_STATUS_1_SHIFT)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_1_IDLE			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_1_RUNNING			_MK_ENUM_CONST(0x1)
#define NVDLA_PDP_RDMA_S_STATUS_0_STATUS_1_PENDING			_MK_ENUM_CONST(0x2)


// Register NVDLA_PDP_RDMA_S_POINTER_0
#define NVDLA_PDP_RDMA_S_POINTER_0			_MK_ADDR_CONST(0xa004)
#define NVDLA_PDP_RDMA_S_POINTER_0_PRODUCER_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_S_POINTER_0_PRODUCER_FIELD			_MK_FIELD_CONST(0x1, NVDLA_PDP_RDMA_S_POINTER_0_PRODUCER_SHIFT)
#define NVDLA_PDP_RDMA_S_POINTER_0_PRODUCER_GROUP_0			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_S_POINTER_0_PRODUCER_GROUP_1			_MK_ENUM_CONST(0x1)
#define NVDLA_PDP_RDMA_S_POINTER_0_CONSUMER_SHIFT			_MK_SHIFT_CONST(16)
#define NVDLA_PDP_RDMA_S_POINTER_0_CONSUMER_FIELD			_MK_FIELD_CONST(0x1, NVDLA_PDP_RDMA_S_POINTER_0_CONSUMER_SHIFT)
#define NVDLA_PDP_RDMA_S_POINTER_0_CONSUMER_GROUP_0			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_S_POINTER_0_CONSUMER_GROUP_1			_MK_ENUM_CONST(0x1)


// Register NVDLA_PDP_RDMA_D_OP_ENABLE_0
#define NVDLA_PDP_RDMA_D_OP_ENABLE_0			_MK_ADDR_CONST(0xa008)
#define NVDLA_PDP_RDMA_D_OP_ENABLE_0_OP_EN_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_OP_ENABLE_0_OP_EN_FIELD			_MK_FIELD_CONST(0x1, NVDLA_PDP_RDMA_D_OP_ENABLE_0_OP_EN_SHIFT)
#define NVDLA_PDP_RDMA_D_OP_ENABLE_0_OP_EN_DISABLE			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_D_OP_ENABLE_0_OP_EN_ENABLE			_MK_ENUM_CONST(0x1)


// Register NVDLA_PDP_RDMA_D_DATA_CUBE_IN_WIDTH_0
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_WIDTH_0			_MK_ADDR_CONST(0xa00c)
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_WIDTH_0_CUBE_IN_WIDTH_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_WIDTH_0_CUBE_IN_WIDTH_FIELD			_MK_FIELD_CONST(0x1fff, NVDLA_PDP_RDMA_D_DATA_CUBE_IN_WIDTH_0_CUBE_IN_WIDTH_SHIFT)


// Register NVDLA_PDP_RDMA_D_DATA_CUBE_IN_HEIGHT_0
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_HEIGHT_0			_MK_ADDR_CONST(0xa010)
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_HEIGHT_0_CUBE_IN_HEIGHT_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_HEIGHT_0_CUBE_IN_HEIGHT_FIELD			_MK_FIELD_CONST(0x1fff, NVDLA_PDP_RDMA_D_DATA_CUBE_IN_HEIGHT_0_CUBE_IN_HEIGHT_SHIFT)


// Register NVDLA_PDP_RDMA_D_DATA_CUBE_IN_CHANNEL_0
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_CHANNEL_0			_MK_ADDR_CONST(0xa014)
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_CHANNEL_0_CUBE_IN_CHANNEL_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_DATA_CUBE_IN_CHANNEL_0_CUBE_IN_CHANNEL_FIELD			_MK_FIELD_CONST(0x1fff, NVDLA_PDP_RDMA_D_DATA_CUBE_IN_CHANNEL_0_CUBE_IN_CHANNEL_SHIFT)


// Register NVDLA_PDP_RDMA_D_FLYING_MODE_0
#define NVDLA_PDP_RDMA_D_FLYING_MODE_0			_MK_ADDR_CONST(0xa018)
#define NVDLA_PDP_RDMA_D_FLYING_MODE_0_FLYING_MODE_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_FLYING_MODE_0_FLYING_MODE_FIELD			_MK_FIELD_CONST(0x1, NVDLA_PDP_RDMA_D_FLYING_MODE_0_FLYING_MODE_SHIFT)
#define NVDLA_PDP_RDMA_D_FLYING_MODE_0_FLYING_MODE_ON_FLYING			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_D_FLYING_MODE_0_FLYING_MODE_OFF_FLYING			_MK_ENUM_CONST(0x1)


// Register NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_LOW_0
#define NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_LOW_0			_MK_ADDR_CONST(0xa01c)
#define NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_LOW_0_SRC_BASE_ADDR_LOW_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_LOW_0_SRC_BASE_ADDR_LOW_FIELD			_MK_FIELD_CONST(0xffffffff, NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_LOW_0_SRC_BASE_ADDR_LOW_SHIFT)


// Register NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_HIGH_0
#define NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_HIGH_0			_MK_ADDR_CONST(0xa020)
#define NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_HIGH_0_SRC_BASE_ADDR_HIGH_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_HIGH_0_SRC_BASE_ADDR_HIGH_FIELD			_MK_FIELD_CONST(0xffffffff, NVDLA_PDP_RDMA_D_SRC_BASE_ADDR_HIGH_0_SRC_BASE_ADDR_HIGH_SHIFT)


// Register NVDLA_PDP_RDMA_D_SRC_LINE_STRIDE_0
#define NVDLA_PDP_RDMA_D_SRC_LINE_STRIDE_0			_MK_ADDR_CONST(0xa024)
#define NVDLA_PDP_RDMA_D_SRC_LINE_STRIDE_0_SRC_LINE_STRIDE_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_SRC_LINE_STRIDE_0_SRC_LINE_STRIDE_FIELD			_MK_FIELD_CONST(0xffffffff, NVDLA_PDP_RDMA_D_SRC_LINE_STRIDE_0_SRC_LINE_STRIDE_SHIFT)


// Register NVDLA_PDP_RDMA_D_SRC_SURFACE_STRIDE_0
#define NVDLA_PDP_RDMA_D_SRC_SURFACE_STRIDE_0			_MK_ADDR_CONST(0xa028)
#define NVDLA_PDP_RDMA_D_SRC_SURFACE_STRIDE_0_SRC_SURFACE_STRIDE_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_SRC_SURFACE_STRIDE_0_SRC_SURFACE_STRIDE_FIELD			_MK_FIELD_CONST(0xffffffff, NVDLA_PDP_RDMA_D_SRC_SURFACE_STRIDE_0_SRC_SURFACE_STRIDE_SHIFT)


// Register NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0
#define NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0			_MK_ADDR_CONST(0xa02c)
#define NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0_SRC_RAM_TYPE_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0_SRC_RAM_TYPE_FIELD			_MK_FIELD_CONST(0x1, NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0_SRC_RAM_TYPE_SHIFT)
#define NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0_SRC_RAM_TYPE_CV			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_D_SRC_RAM_CFG_0_SRC_RAM_TYPE_MC			_MK_ENUM_CONST(0x1)


// Register NVDLA_PDP_RDMA_D_DATA_FORMAT_0
#define NVDLA_PDP_RDMA_D_DATA_FORMAT_0			_MK_ADDR_CONST(0xa030)
#define NVDLA_PDP_RDMA_D_DATA_FORMAT_0_INPUT_DATA_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_DATA_FORMAT_0_INPUT_DATA_FIELD			_MK_FIELD_CONST(0x3, NVDLA_PDP_RDMA_D_DATA_FORMAT_0_INPUT_DATA_SHIFT)
#define NVDLA_PDP_RDMA_D_DATA_FORMAT_0_INPUT_DATA_INT8			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_D_DATA_FORMAT_0_INPUT_DATA_INT16			_MK_ENUM_CONST(0x1)
#define NVDLA_PDP_RDMA_D_DATA_FORMAT_0_INPUT_DATA_FP16			_MK_ENUM_CONST(0x2)


// Register NVDLA_PDP_RDMA_D_OPERATION_MODE_CFG_0
#define NVDLA_PDP_RDMA_D_OPERATION_MODE_CFG_0			_MK_ADDR_CONST(0xa034)
#define NVDLA_PDP_RDMA_D_OPERATION_MODE_CFG_0_SPLIT_NUM_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_OPERATION_MODE_CFG_0_SPLIT_NUM_FIELD			_MK_FIELD_CONST(0xff, NVDLA_PDP_RDMA_D_OPERATION_MODE_CFG_0_SPLIT_NUM_SHIFT)


// Register NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0			_MK_ADDR_CONST(0xa038)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_FIELD			_MK_FIELD_CONST(0xf, NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_SHIFT)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_1			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_2			_MK_ENUM_CONST(0x1)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_3			_MK_ENUM_CONST(0x2)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_4			_MK_ENUM_CONST(0x3)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_5			_MK_ENUM_CONST(0x4)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_6			_MK_ENUM_CONST(0x5)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_7			_MK_ENUM_CONST(0x6)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_WIDTH_KERNEL_WIDTH_8			_MK_ENUM_CONST(0x7)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_STRIDE_WIDTH_SHIFT			_MK_SHIFT_CONST(4)
#define NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_STRIDE_WIDTH_FIELD			_MK_FIELD_CONST(0xf, NVDLA_PDP_RDMA_D_POOLING_KERNEL_CFG_0_KERNEL_STRIDE_WIDTH_SHIFT)


// Register NVDLA_PDP_RDMA_D_POOLING_PADDING_CFG_0
#define NVDLA_PDP_RDMA_D_POOLING_PADDING_CFG_0			_MK_ADDR_CONST(0xa03c)
#define NVDLA_PDP_RDMA_D_POOLING_PADDING_CFG_0_PAD_WIDTH_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_POOLING_PADDING_CFG_0_PAD_WIDTH_FIELD			_MK_FIELD_CONST(0xf, NVDLA_PDP_RDMA_D_POOLING_PADDING_CFG_0_PAD_WIDTH_SHIFT)


// Register NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0			_MK_ADDR_CONST(0xa040)
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_FIRST_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_FIRST_FIELD			_MK_FIELD_CONST(0x3ff, NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_FIRST_SHIFT)
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_LAST_SHIFT			_MK_SHIFT_CONST(10)
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_LAST_FIELD			_MK_FIELD_CONST(0x3ff, NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_LAST_SHIFT)
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_MID_SHIFT			_MK_SHIFT_CONST(20)
#define NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_MID_FIELD			_MK_FIELD_CONST(0x3ff, NVDLA_PDP_RDMA_D_PARTIAL_WIDTH_IN_0_PARTIAL_WIDTH_IN_MID_SHIFT)


// Register NVDLA_PDP_RDMA_D_PERF_ENABLE_0
#define NVDLA_PDP_RDMA_D_PERF_ENABLE_0			_MK_ADDR_CONST(0xa044)
#define NVDLA_PDP_RDMA_D_PERF_ENABLE_0_DMA_EN_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_PERF_ENABLE_0_DMA_EN_FIELD			_MK_FIELD_CONST(0x1, NVDLA_PDP_RDMA_D_PERF_ENABLE_0_DMA_EN_SHIFT)
#define NVDLA_PDP_RDMA_D_PERF_ENABLE_0_DMA_EN_DISABLE			_MK_ENUM_CONST(0x0)
#define NVDLA_PDP_RDMA_D_PERF_ENABLE_0_DMA_EN_ENABLE			_MK_ENUM_CONST(0x1)


// Register NVDLA_PDP_RDMA_D_PERF_READ_STALL_0
#define NVDLA_PDP_RDMA_D_PERF_READ_STALL_0			_MK_ADDR_CONST(0xa048)
#define NVDLA_PDP_RDMA_D_PERF_READ_STALL_0_PERF_READ_STALL_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_PERF_READ_STALL_0_PERF_READ_STALL_FIELD			_MK_FIELD_CONST(0xffffffff, NVDLA_PDP_RDMA_D_PERF_READ_STALL_0_PERF_READ_STALL_SHIFT)


// Register NVDLA_PDP_RDMA_D_CYA_0
#define NVDLA_PDP_RDMA_D_CYA_0			_MK_ADDR_CONST(0xa04c)
#define NVDLA_PDP_RDMA_D_CYA_0_CYA_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_PDP_RDMA_D_CYA_0_CYA_FIELD			_MK_FIELD_CONST(0xffffffff, NVDLA_PDP_RDMA_D_CYA_0_CYA_SHIFT)



// To satisfy various compilers and platforms,
// we let users control the types and syntax of certain constants, using macros.
#ifndef _MK_SHIFT_CONST
  #define _MK_SHIFT_CONST(_constant_) _constant_
#endif
#ifndef _MK_MASK_CONST
  #define _MK_MASK_CONST(_constant_) _constant_
#endif
#ifndef _MK_ENUM_CONST
  #define _MK_ENUM_CONST(_constant_) (_constant_ ## UL)
#endif
#ifndef _MK_ADDR_CONST
  #define _MK_ADDR_CONST(_constant_) _constant_
#endif
#ifndef _MK_FIELD_CONST
  #define _MK_FIELD_CONST(_mask_, _shift_) (_MK_MASK_CONST(_mask_) << _MK_SHIFT_CONST(_shift_))
#endif



//
// ADDRESS SPACES
//

#define BASE_ADDRESS_NVDLA_PDP_RDMA	0xa000
