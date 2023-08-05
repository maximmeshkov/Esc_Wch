add_library(Startup INTERFACE)
add_library(Firmware::Startup ALIAS Startup )

#Includes
target_include_directories(Startup INTERFACE ".")

target_sources(Startup 
INTERFACE
    startup_ch32v30x_D8C.S
)