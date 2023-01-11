
#include <stdio.h>
#include <stdint.h>
#include <io.h>
#include <unistd.h>

#define REG_READ_BASE 0x00000000
#define OFFSET 0x00000000

#define REG_READ_SELECT_BASE 0x00000010

int i = 0;

int main(void)
{ 
    int reg_read = 0;

    while( 1 ) 
    {
    	i = 0;
    	while(i < 7){
    		IOWR_8DIRECT(REG_READ_SELECT_BASE,OFFSET,i);
    		reg_read = IORD_32DIRECT(REG_READ_BASE,OFFSET);
    		printf("Register %lx : %lx | ", i, reg_read);
    		i++;

    	}
    	IOWR_8DIRECT(REG_READ_SELECT_BASE,OFFSET,7);
		reg_read = IORD_32DIRECT(REG_READ_BASE,OFFSET);
		printf("PC : %lx | ", reg_read);

		IOWR_8DIRECT(REG_READ_SELECT_BASE,OFFSET,8);
		reg_read = IORD_32DIRECT(REG_READ_BASE,OFFSET);
		printf("INST : %lx | ", reg_read);
    	usleep(100000);

    	printf("\n");

    }

    return 0;
}
