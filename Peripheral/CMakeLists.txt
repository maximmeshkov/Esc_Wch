add_library(Peripheral INTERFACE)
add_library(Firmware::Peripheral ALIAS Peripheral )

#Includes
target_include_directories(Peripheral INTERFACE ".")

target_sources(Peripheral 
INTERFACE
	inc/ch32v30x_adc.h
    inc/ch32v30x_bkp.h
    inc/ch32v30x_can.h
    inc/ch32v30x_crc.h
    inc/ch32v30x_dac.h
    inc/ch32v30x_dbgmcu.h
    inc/ch32v30x_dma.h
    inc/ch32v30x_dvp.h
    inc/ch32v30x_eth.h
    inc/ch32v30x_exti.h
    inc/ch32v30x_flash.h
    inc/ch32v30x_fsmc.h
    inc/ch32v30x_gpio.h
    inc/ch32v30x_i2c.h
    inc/ch32v30x_iwdg.h
    inc/ch32v30x_misc.h
    inc/ch32v30x_opa.h
    inc/ch32v30x_pwr.h
    inc/ch32v30x_rcc.h
    inc/ch32v30x_rng.h
    inc/ch32v30x_rtc.h
    inc/ch32v30x_sdio.h
    inc/ch32v30x_spi.h
    inc/ch32v30x_tim.h
    inc/ch32v30x_usart.h
    inc/ch32v30x_wwdg.h
    inc/ch32v30x.h

    src/ch32v30x_adc.c
    src/ch32v30x_bkp.c
    src/ch32v30x_can.c
    src/ch32v30x_crc.c
    src/ch32v30x_dac.c
    src/ch32v30x_dbgmcu.c
    src/ch32v30x_dma.c
    src/ch32v30x_dvp.c
    src/ch32v30x_eth.c
    src/ch32v30x_exti.c
    src/ch32v30x_flash.c
    src/ch32v30x_fsmc.c
    src/ch32v30x_gpio.c
    src/ch32v30x_i2c.c
    src/ch32v30x_iwdg.c
    src/ch32v30x_misc.c
    src/ch32v30x_opa.c
    src/ch32v30x_pwr.c
    src/ch32v30x_rcc.c
    src/ch32v30x_rng.c
    src/ch32v30x_rtc.c
    src/ch32v30x_sdio.c
    src/ch32v30x_spi.c
    src/ch32v30x_tim.c
    src/ch32v30x_usart.c
    src/ch32v30x_wwdg.c
)

target_include_directories(Peripheral
INTERFACE
    "inc"
)