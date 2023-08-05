add_library(FreeRTOS INTERFACE)
add_library(Firmware::FreeRTOS ALIAS FreeRTOS )

#Includes
target_include_directories(FreeRTOS INTERFACE ".")

target_sources(FreeRTOS 
INTERFACE
    include/atomic.h
    include/croutine.h
    include/deprecated_definitions.h
    include/event_groups.h
    include/FreeRTOS.h
    include/list.h
    include/message_buffer.h
    include/mpu_prototypes.h
    include/mpu_wrappers.h
    include/portable.h
    include/projdefs.h
    include/queue.h

    # portable/Common/mpu_wrappers.c
    
    portable/GCC/RISC-V/chip_specific_extensions/RV32I_PFIC_no_extensions/freertos_risc_v_chip_specific_extensions.h
    
    portable/GCC/RISC-V/port.c
    portable/GCC/RISC-V/portASM.S
    portable/GCC/RISC-V/portmacro.h
    
    portable/MemMang/heap_4.c

    croutine.c
    event_groups.c
    list.c
    queue.c
    stream_buffer.c
    tasks.c
    timers.c
)
target_include_directories(FreeRTOS
INTERFACE
    "include"

    "portable/GCC/RISC-V/chip_specific_extensions/RV32I_PFIC_no_extensions"
    "portable/GCC/RISC-V"

)