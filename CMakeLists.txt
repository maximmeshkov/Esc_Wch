set(CMAKE_VERBOSE_MAKEFILE ON)
CMAKE_MINIMUM_REQUIRED(VERSION 3.16)


set(CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR}/Dependencies/CMake)

#Set toolchain
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
	set(ToolchainFilePath "${CMAKE_DIR}/Gcc/Toolchains/xpack-riscv-none-elf.cmake")
	if(EXISTS ${ToolchainFilePath})
		set(CMAKE_TOOLCHAIN_FILE "${ToolchainFilePath}" CACHE PATH "toolchain file" FORCE)
		message("Toolchain file found and set to ${ToolchainFilePath}")
	else()
		message(FATAL_ERROR "Unable to resolve '${ToolchainFilePath}' for setting toolchain file.")
	endif()
endif()


list(APPEND CMAKE_MODULE_PATH "${CMAKE_DIR}")
include(Gcc/CH32/V307)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 17)

project(ESC_WCH C CXX ASM)

add_library(FirmwareCommonSource INTERFACE)

#Defines
# target_compile_definitions(FirmwareCommonSource 
# INTERFACE

# )

#Includes
target_include_directories(FirmwareCommonSource 
INTERFACE 
	"Firmware"
)

target_sources(FirmwareCommonSource
INTERFACE
	Firmware/main.cpp
	Firmware/ch32v30x_conf.h
	Firmware/ch32v30x_it.c
	Firmware/ch32v30x_it.h
	Firmware/FreeRTOSConfig.h
	Firmware/system_ch32v30x.c
	Firmware/system_ch32v30x.h
)

#Subdirs
# add_subdirectory(Dependencies/alContainer)

add_subdirectory(Core)
add_subdirectory(Debug)
add_subdirectory(FreeRTOS)
add_subdirectory(Peripheral)
add_subdirectory(Startup)

#Link libraries
target_link_libraries(FirmwareCommonSource
INTERFACE
	Firmware::Debug
	Firmware::Core
	Firmware::FreeRTOS
	Firmware::Peripheral
	Firmware::Startup
	CH32::V307
	GCC::Specs::NoSys
	GCC::Specs::Nano

)

set(LINKER_SCRIPT_NO_BOOTLOADER "${CMAKE_CURRENT_LIST_DIR}/Ld/Link.ld")



add_executable(Firmware)
# target_compile_definitions(1.0.0 PRIVATE
# 	NO_ANTILATENCY_DEVICE_DESCRIPTOR
# 	COMMON_SOCKET_FIRMWARE_NO_MAIN
# 	HARDWARE_VERSION_1_0_0	
# )
target_link_libraries(Firmware FirmwareCommonSource)
gcc_add_linker_script(Firmware PRIVATE ${LINKER_SCRIPT_NO_BOOTLOADER})
gcc_print_target_size(Firmware)
gcc_generate_bin_file(Firmware)
gcc_generate_hex_file(Firmware)
