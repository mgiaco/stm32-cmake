SET(CMAKE_C_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -Wall -std=gnu99 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")
SET(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -Wall -std=c++11 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")
SET(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m4" CACHE INTERNAL "asm compiler flags")

SET(CMAKE_EXE_LINKER_FLAGS "-nostartfiles -Wl,--gc-sections -mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "executable linker flags")
SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "shared linker flags")

SET(STM32_CHIP_TYPE_REGEXP "4[0123][1579].[BCEGI]")
SET(STM32_CHIP_TYPES 401xx 40_41xxx 427_437xx 429_439xx CACHE INTERNAL "stm32f4 chip types")
SET(STM32_CODES "401.[BC]" "4[01][57].[EG]" "4[23]7.[EGI]" "4[23]9.[EGI]")

MACRO(STM32_GET_CHIP_PARAMETERS CHIP FLASH_SIZE RAM_SIZE)
    STRING(REGEX REPLACE "^[sS][tT][mM]32[fF](4[0123][1579].[BCEGI])" "\\1" STM32_CODE ${CHIP})
    STRING(REGEX REPLACE "^[sS][tT][mM]32[fF]4[0123][1579].([BCEGI])" "\\1" STM32_SIZE_CODE ${CHIP})

    STM32FX_GET_CHIP_FLASH_SIZE(${STM32_SIZE_CODE} ${FLASH_SIZE})
    
    STM32_GET_CHIP_TYPE(${CHIP} TYPE)
    
    IF(${TYPE} STREQUAL "401xx")
        SET(RAM "64K")
    ELSEIF(${TYPE} STREQUAL "40_41xxx")
        SET(RAM "128K")
    ELSEIF(${TYPE} STREQUAL "427_437xx")
        SET(RAM "192K")
    ELSEIF(${TYPE} STREQUAL "429_439xx")
        SET(RAM "192K")
    ENDIF()
    
    SET(${RAM_SIZE} ${RAM})
ENDMACRO()
