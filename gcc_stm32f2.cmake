SET(CMAKE_C_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m3 -Wall -std=gnu99 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")
SET(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m3 -Wall -std=c++11 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")
SET(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m3" CACHE INTERNAL "asm compiler flags")

SET(CMAKE_EXE_LINKER_FLAGS "-nostartfiles -Wl,--gc-sections -mthumb -mcpu=cortex-m3 -mabi=aapcs" CACHE INTERNAL "executable linker flags")
SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m3 -mabi=aapcs" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m3 -mabi=aapcs" CACHE INTERNAL "shared linker flags")

SET(STM32_CHIP_TYPE_REGEXP "2[01][57][RVZI][BCEFG]")
SET(STM32_CHIP_TYPES "2xx" CACHE INTERNAL "stm32f2 chip types")
SET(STM32_CODES ${STM32_CHIP_TYPE_REGEXP})

MACRO(STM32_GET_CHIP_PARAMETERS CHIP FLASH_SIZE RAM_SIZE)
    STRING(REGEX REPLACE "^[sS][tT][mM]32[fF](2[01][57]..)" "\\1" STM32_CODE ${CHIP})
    STRING(REGEX REPLACE "^[sS][tT][mM]32[fF]2[01][57].(.)" "\\1" STM32_SIZE_CODE ${CHIP})

    STM32FX_GET_CHIP_FLASH_SIZE(${STM32_SIZE_CODE} ${FLASH_SIZE})
    
    IF(${STM32_CODE} MATCHES 205.B)
        SET(RAM "64K")
    ELSEIF(${STM32_CODE} MATCHES 205.C)
        SET(RAM "96K")
    ELSE()
        SET(RAM "128K")
    ENDIF()
    
    SET(${RAM_SIZE} ${RAM})
ENDMACRO()
