SET(CMAKE_C_FLAGS "-mthumb -mcpu=cortex-m0 -fno-builtin -Wall -std=gnu99 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")
SET(CMAKE_CXX_FLAGS "-mthumb -mcpu=cortex-m0 -fno-builtin -Wall -std=c++11 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")
SET(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m0" CACHE INTERNAL "asm compiler flags")

SET(CMAKE_EXE_LINKER_FLAGS "-nostartfiles -Wl,--gc-sections -mthumb -mcpu=cortex-m0 -mabi=aapcs" CACHE INTERNAL "executable linker flags")
SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m0 -mabi=aapcs" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m0 -mabi=aapcs" CACHE INTERNAL "shared linker flags")

SET(STM32_CHIP_TYPE_REGEXP "0[3457][012].[468B]")
SET(STM32_CHIP_TYPES 030 031 042 051 071 072 0xx CACHE INTERNAL "stm32f0 chip types")
SET(STM32_CODES "030.." "031.." "042.." "051.." "071.." "072.." "0....")

MACRO(STM32_GET_CHIP_PARAMETERS CHIP FLASH_SIZE RAM_SIZE)
    STRING(REGEX REPLACE "^[sS][tT][mM]32[fF](0[3457][012].[468B])" "\\1" STM32_CODE ${CHIP})
    STRING(REGEX REPLACE "^[sS][tT][mM]32[fF]0[3457][012].([468B])" "\\1" STM32_SIZE_CODE ${CHIP})
    
    STM32FX_GET_CHIP_FLASH_SIZE(${STM32_SIZE_CODE} ${FLASH_SIZE})
    
    IF(${STM32_CODE} MATCHES 042..)
        SET(RAM "6K")
    ELSEIF(${STM32_CODE} MATCHES 030[CR]8)
        SET(RAM "8K")
    ELSEIF(${STM32_CODE} MATCHES 051..)
        SET(RAM "8K")
    ELSEIF(${STM32_CODE} MATCHES 07[12]..)
        SET(RAM "16K")
    ELSE()
        SET(RAM "4K")
    ENDIF()
    
    SET(${RAM_SIZE} ${RAM})
ENDMACRO()
