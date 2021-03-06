/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */ 
/** ThreadX Component                                                     */ 
/**                                                                       */
/**   Thread - Low Level SMP Support                                      */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/*
#define TX_SOURCE_CODE
#define TX_THREAD_SMP_SOURCE_CODE
*/

/* Include necessary system files.  */

/*
#include "tx_api.h"
#include "tx_thread.h"
#include "tx_timer.h"
*/

    .text
    .align 3
/**************************************************************************/ 
/*                                                                        */ 
/*  FUNCTION                                               RELEASE        */ 
/*                                                                        */ 
/*    _tx_thread_smp_core_get                          Cortex-A5x-SMP/GNU */ 
/*                                                           6.0.1        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    William E. Lamie, Microsoft Corporation                             */
/*                                                                        */
/*  DESCRIPTION                                                           */ 
/*                                                                        */ 
/*    This function gets the currently running core number and returns it.*/ 
/*                                                                        */ 
/*  INPUT                                                                 */ 
/*                                                                        */ 
/*    None                                                                */
/*                                                                        */ 
/*  OUTPUT                                                                */ 
/*                                                                        */ 
/*    Core ID                                                             */ 
/*                                                                        */ 
/*  CALLS                                                                 */ 
/*                                                                        */ 
/*    None                                                                */
/*                                                                        */ 
/*  CALLED BY                                                             */ 
/*                                                                        */ 
/*    ThreadX Source                                                      */
/*                                                                        */ 
/*  RELEASE HISTORY                                                       */ 
/*                                                                        */ 
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  06-30-2020     William E. Lamie         Initial Version 6.0.1         */
/*                                                                        */
/**************************************************************************/
    .global  _tx_thread_smp_core_get
    .type    _tx_thread_smp_core_get, @function
_tx_thread_smp_core_get:
    MRS     x0, MPIDR_EL1                       // Pickup the core ID
#if TX_THREAD_SMP_CLUSTERS > 1
    UBFX    x1, x0, #8, #8                      // Isolate cluster ID
#endif
    UBFX    x0, x0, #0, #8                      // Isolate core ID
#if TX_THREAD_SMP_CLUSTERS > 1
    ADDS    x0, x0, x1, LSL #2                  // Calculate CPU ID
#endif
    RET
    
    
