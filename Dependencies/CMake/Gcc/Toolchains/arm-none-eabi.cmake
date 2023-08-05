if(NOT DEFINED TOOLCHAIN_DIR)

    if(CMAKE_HOST_UNIX)
        file(GLOB TOOLCHAIN_DIRS "/usr/local/gcc-arm-none-eabi-*")
    else()
        file(GLOB TOOLCHAIN_DIRS "C:/Program Files (x86)/GNU Arm Embedded Toolchain/*")
    endif()
   
    if(TOOLCHAIN_DIRS)
        list(GET TOOLCHAIN_DIRS 0 TOOLCHAIN_DIR)
        message("FOUND ARM GCC Toolchain Directory: ${TOOLCHAIN_DIR}")
    endif()
endif()

#GET_FILENAME_COMPONENT(STM32_CMAKE_DIR ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
#list(APPEND CMAKE_MODULE_PATH ${STM32_CMAKE_DIR})

#

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION 1)


set(TOOLCHAIN_TRIPLET "arm-none-eabi")
set(CMAKE_LIBRARY_ARCHITECTURE arm-none-eabi)

include(${CMAKE_CURRENT_LIST_DIR}/gcc-common.cmake)
