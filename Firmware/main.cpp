/********************************** (C) COPYRIGHT *******************************
* File Name          : main.c
* Author             : WCH
* Version            : V1.0.0
* Date               : 2021/06/06
* Description        : Main program body.
*********************************************************************************
* Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
* Attention: This software (modified or not) and binary are used for 
* microcontroller manufactured by Nanjing Qinheng Microelectronics.
*******************************************************************************/

/*
 *@Note
 task1 and task2 alternate printing
*/

#include "debug.h"
#include "FreeRTOS.h"
#include "task.h"

/* Global define */
#define TASK1_TASK_PRIO     5
#define TASK1_STK_SIZE      256
#define TASK2_TASK_PRIO     5
#define TASK2_STK_SIZE      256

/* Global Variable */
TaskHandle_t Task1Task_Handler;
TaskHandle_t Task2Task_Handler;


/*********************************************************************
 * @fn      GPIO_Toggle_INIT
 *
 * @brief   Initializes GPIOA.0/1
 *
 * @return  none
 */
void GPIO_Toggle_INIT(void)
{
  GPIO_InitTypeDef  GPIO_InitStructure={0};

  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0|GPIO_Pin_1;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
  GPIO_InitStructure.GPIO_Speed=GPIO_Speed_50MHz;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
}


/*********************************************************************
 * @fn      task1_task
 *
 * @brief   task1 program.
 *
 * @param  *pvParameters - Parameters point of task1
 *
 * @return  none
 */
void task1_task(void *pvParameters)
{
    while(1)
    {
        printf("task1 entry\r\n");
        GPIO_SetBits(GPIOA, GPIO_Pin_0);
        vTaskDelay(900);
        GPIO_ResetBits(GPIOA, GPIO_Pin_0);
        vTaskDelay(100);
    }
}

/*********************************************************************
 * @fn      task2_task
 *
 * @brief   task2 program.
 *
 * @param  *pvParameters - Parameters point of task2
 *
 * @return  none
 */
void task2_task(void *pvParameters)
{
    while(1)
    {
        printf("task2 entry\r\n");
        GPIO_ResetBits(GPIOA, GPIO_Pin_1);
        vTaskDelay(100);
        GPIO_SetBits(GPIOA, GPIO_Pin_1);
        vTaskDelay(100);
    }
}

/*********************************************************************
 * @fn      main
 *
 * @brief   Main program.
 *
 * @return  none
 */
int main(void)
{

	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
	SystemCoreClockUpdate();
	Delay_Init();
	USART_Printf_Init(115200);
		
	printf("SystemClk:%d\r\n",SystemCoreClock);
	printf( "ChipID:%08x\r\n", DBGMCU_GetCHIPID() );
	printf("FreeRTOS Kernel Version:%s\r\n",tskKERNEL_VERSION_NUMBER);

	GPIO_Toggle_INIT();
	/* create two task */
    xTaskCreate((TaskFunction_t )task2_task,
                        (const char*    )"task2",
                        (uint16_t       )TASK2_STK_SIZE,
                        (void*          )NULL,
                        (UBaseType_t    )TASK2_TASK_PRIO,
                        (TaskHandle_t*  )&Task2Task_Handler);

    xTaskCreate((TaskFunction_t )task1_task,
                    (const char*    )"task1",
                    (uint16_t       )TASK1_STK_SIZE,
                    (void*          )NULL,
                    (UBaseType_t    )TASK1_TASK_PRIO,
                    (TaskHandle_t*  )&Task1Task_Handler);
    vTaskStartScheduler();

	while(1)
	{
	    printf("shouldn't run at here!!\n");
	}
}

extern "C" {
	int _fstat(int fd, struct stat *st) {
		(void) fd, (void) st;
		return -1;
	}

	int _close(int fd) {
		(void) fd;
		return 0;
	}

	int _isatty(int fd) {
		(void) fd;
		return 1;
	}

	int _lseek(int fd, int offset, int whence) {
		(void) fd;
		(void) offset;
		(void) whence;
		return -1;
	}

	int _read(int fd, char *ptr, int len) {
		if (fd < 3) {
			return len;
		} else {
			return -1;
		}
	}

    void _fini(){}
    void _init(){}
}