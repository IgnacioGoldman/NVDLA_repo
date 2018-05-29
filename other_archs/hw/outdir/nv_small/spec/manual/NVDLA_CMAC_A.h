// Register NVDLA_CMAC_A_S_STATUS_0
#define NVDLA_CMAC_A_S_STATUS_0			_MK_ADDR_CONST(0x5000)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_0_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_0_FIELD			_MK_FIELD_CONST(0x3, NVDLA_CMAC_A_S_STATUS_0_STATUS_0_SHIFT)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_0_IDLE			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_0_RUNNING			_MK_ENUM_CONST(0x1)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_0_PENDING			_MK_ENUM_CONST(0x2)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_1_SHIFT			_MK_SHIFT_CONST(16)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_1_FIELD			_MK_FIELD_CONST(0x3, NVDLA_CMAC_A_S_STATUS_0_STATUS_1_SHIFT)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_1_IDLE			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_1_RUNNING			_MK_ENUM_CONST(0x1)
#define NVDLA_CMAC_A_S_STATUS_0_STATUS_1_PENDING			_MK_ENUM_CONST(0x2)


// Register NVDLA_CMAC_A_S_POINTER_0
#define NVDLA_CMAC_A_S_POINTER_0			_MK_ADDR_CONST(0x5004)
#define NVDLA_CMAC_A_S_POINTER_0_PRODUCER_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_CMAC_A_S_POINTER_0_PRODUCER_FIELD			_MK_FIELD_CONST(0x1, NVDLA_CMAC_A_S_POINTER_0_PRODUCER_SHIFT)
#define NVDLA_CMAC_A_S_POINTER_0_PRODUCER_GROUP_0			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_S_POINTER_0_PRODUCER_GROUP_1			_MK_ENUM_CONST(0x1)
#define NVDLA_CMAC_A_S_POINTER_0_CONSUMER_SHIFT			_MK_SHIFT_CONST(16)
#define NVDLA_CMAC_A_S_POINTER_0_CONSUMER_FIELD			_MK_FIELD_CONST(0x1, NVDLA_CMAC_A_S_POINTER_0_CONSUMER_SHIFT)
#define NVDLA_CMAC_A_S_POINTER_0_CONSUMER_GROUP_0			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_S_POINTER_0_CONSUMER_GROUP_1			_MK_ENUM_CONST(0x1)


// Register NVDLA_CMAC_A_D_OP_ENABLE_0
#define NVDLA_CMAC_A_D_OP_ENABLE_0			_MK_ADDR_CONST(0x5008)
#define NVDLA_CMAC_A_D_OP_ENABLE_0_OP_EN_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_CMAC_A_D_OP_ENABLE_0_OP_EN_FIELD			_MK_FIELD_CONST(0x1, NVDLA_CMAC_A_D_OP_ENABLE_0_OP_EN_SHIFT)
#define NVDLA_CMAC_A_D_OP_ENABLE_0_OP_EN_DISABLE			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_D_OP_ENABLE_0_OP_EN_ENABLE			_MK_ENUM_CONST(0x1)


// Register NVDLA_CMAC_A_D_MISC_CFG_0
#define NVDLA_CMAC_A_D_MISC_CFG_0			_MK_ADDR_CONST(0x500c)
#define NVDLA_CMAC_A_D_MISC_CFG_0_CONV_MODE_SHIFT			_MK_SHIFT_CONST(0)
#define NVDLA_CMAC_A_D_MISC_CFG_0_CONV_MODE_FIELD			_MK_FIELD_CONST(0x1, NVDLA_CMAC_A_D_MISC_CFG_0_CONV_MODE_SHIFT)
#define NVDLA_CMAC_A_D_MISC_CFG_0_CONV_MODE_DIRECT			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_D_MISC_CFG_0_CONV_MODE_WINOGRAD			_MK_ENUM_CONST(0x1)
#define NVDLA_CMAC_A_D_MISC_CFG_0_PROC_PRECISION_SHIFT			_MK_SHIFT_CONST(12)
#define NVDLA_CMAC_A_D_MISC_CFG_0_PROC_PRECISION_FIELD			_MK_FIELD_CONST(0x3, NVDLA_CMAC_A_D_MISC_CFG_0_PROC_PRECISION_SHIFT)
#define NVDLA_CMAC_A_D_MISC_CFG_0_PROC_PRECISION_INT8			_MK_ENUM_CONST(0x0)
#define NVDLA_CMAC_A_D_MISC_CFG_0_PROC_PRECISION_INT16			_MK_ENUM_CONST(0x1)
#define NVDLA_CMAC_A_D_MISC_CFG_0_PROC_PRECISION_FP16			_MK_ENUM_CONST(0x2)



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

#define BASE_ADDRESS_NVDLA_CMAC_A	0x5000