set(MCU_ARCH rv32imafc )
set(MCU_FLOAT_ABI ilp32f )
# set(MCU_FPU fpv4-sp-d16)
#-mno-save-restore
set(COMMON_COMPILE_FLAGS -march=${MCU_ARCH}  -mabi=${MCU_FLOAT_ABI} -msmall-data-limit=8 )
set(C_CXX_COMPILE_FLAGS  -ffunction-sections -fdata-sections -fsigned-char -g -fmessage-length=0)

if(NOT (TARGET CH32::V307))
    add_library(CH32::V307 INTERFACE IMPORTED)

    target_compile_options(CH32::V307 INTERFACE 
        --sysroot="${TOOLCHAIN_SYSROOT}"
        ${COMMON_COMPILE_FLAGS}
    )

    target_compile_options(CH32::V307 INTERFACE $<$<COMPILE_LANGUAGE:C>:${C_CXX_COMPILE_FLAGS}>)
    target_compile_options(CH32::V307 INTERFACE $<$<COMPILE_LANGUAGE:CXX>:${C_CXX_COMPILE_FLAGS}>)
    target_compile_options(CH32::V307 INTERFACE $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics>)


    target_compile_options(CH32::V307 INTERFACE $<$<COMPILE_LANGUAGE:ASM>:-x assembler-with-cpp>)
    

    target_link_options(CH32::V307 INTERFACE 
        --sysroot="${TOOLCHAIN_SYSROOT}"
        ${COMMON_COMPILE_FLAGS}
        ${C_CXX_COMPILE_FLAGS} 
        LINKER:-gc-sections 
        -nostartfiles
    )
    
    # target_link_options(CH32::V307 INTERFACE $<$<CONFIG:RELEASE>:LINKER:--undefined=vTaskSwitchContext,--undefined=HardFault_HandlerC,-undefined=_realloc_r>)

    target_compile_definitions(CH32::V307 INTERFACE 
        # STM32F4
        "__weak=__attribute__((weak))"
        "__packed=__attribute__((__packed__))"
    )
endif()
