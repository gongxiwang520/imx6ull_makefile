SECTIONS {
    . = 0x80100000;		/* 链接地址 */

    . = ALIGN(4);
    .text      :		/* 所有文件的.text段 */
    {
      *(.text)
    }

    . = ALIGN(4);
    .rodata : { *(.rodata) }	/* 所有文件的.rodata段 */

    . = ALIGN(4);
    .data : { *(.data) }		/* 所有文件的.data段 */

    . = ALIGN(4);
    __bss_start = .;				/* bss段起始地址 */		
    .bss : { *(.bss) *(.COMMON) }	/* 所有文件的.bss段 和 .COMMON段 */
    __bss_end = .;					/* bss段结束地址 */
}
