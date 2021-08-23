# 定时变量
PREFIX=arm-linux-gnueabihf-
# 交叉编译器
CC=$(PREFIX)gcc
# 链接器
LD=$(PREFIX)ld
# 静态库归档工具
AR=$(PREFIX)ar
# 目标拷贝工具
OBJCOPY=$(PREFIX)objcopy
# 反汇编工具
OBJDUMP=$(PREFIX)objdump

# 目标文件
led.img : start.S  main.c
	$(CC) -nostdlib -g -c -o start.o start.S
	$(CC) -nostdlib -g -c -o main.o main.c	
	# 根据链接脚本.lds生成.elf可执行程序
	$(LD) -T imx6ull.lds -g start.o main.o -o led.elf 
	# 将elf文件内容复制到bin文件,且不复制重定位信息 和 符号信息;
	$(OBJCOPY) -O binary -S led.elf  led.bin
	# 生成反汇编.dis
	$(OBJDUMP) -D -m arm  led.elf  > led.dis	
	# 使用mkimage工具制作.imx镜像文件,输入bin文件,指定入口地址0x80100000
	mkimage -n ./tools/imximage.cfg.cfgtmp -T imximage -e 0x80100000 -d led.bin led.imx
	# 制作img镜像
	dd if=/dev/zero of=1k.bin bs=1024 count=1
	cat 1k.bin led.imx > led.img

clean:
	rm -f led.dis  led.bin led.elf led.imx led.img *.o


	
