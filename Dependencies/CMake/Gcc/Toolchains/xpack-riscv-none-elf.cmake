if(NOT DEFINED TOOLCHAIN_DIR)

    if(CMAKE_HOST_UNIX)
        message(FATAL_ERROR "not implemented")
    else()
        file(GLOB TOOLCHAIN_DIRS "C:/xpack-riscv-none-elf-gcc-*")
        # https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases
    endif()
   
    if(TOOLCHAIN_DIRS)
        list(GET TOOLCHAIN_DIRS 0 TOOLCHAIN_DIR)
        message("FOUND xpack-riscv-none-elf-gcc Toolchain Directory: ${TOOLCHAIN_DIR}")
    endif()
endif()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR rv32imac)
set(CMAKE_SYSTEM_VERSION 1)


set(TOOLCHAIN_TRIPLET "riscv-none-elf")
set(CMAKE_LIBRARY_ARCHITECTURE riscv-none-elf)

include(${CMAKE_CURRENT_LIST_DIR}/gcc-common.cmake)
