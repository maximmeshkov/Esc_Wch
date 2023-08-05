add_library(Debug INTERFACE)
add_library(Firmware::Debug ALIAS Debug )

#Includes
target_include_directories(Debug INTERFACE ".")

target_sources(Debug 
INTERFACE
	debug.c
    debug.h
)

target_include_directories(Debug 
INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)