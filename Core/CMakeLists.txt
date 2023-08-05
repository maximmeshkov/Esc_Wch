add_library(Core INTERFACE)
add_library(Firmware::Core ALIAS Core )

#Includes
target_include_directories(Core INTERFACE ".")

target_sources(Core 
INTERFACE
	core_riscv.c
    core_riscv.h
)

target_include_directories(Core 
INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)