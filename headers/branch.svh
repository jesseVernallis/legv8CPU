
`define BRANCHOP_SIZE          6

`define BRANCHOP_B              6'b1x_xxxx
`define BRANCHOP_BR             6'b01_xxxx
`define BRANCHOP_BL             6'b00_1xxx
`define BRANCHOP_CBZ            6'b00_01xx
`define BRANCHOP_CBNZ           6'b00_001x
`define BRANCHOP_BCOND          6'b00_0001
`define BRANCHOP_NONE           6'b00_0000

`define BRANCHCTRL_B            5   
`define BRANCHCTRL_BR           4
`define BRANCHCTRL_BL           3
`define BRANCHCTRL_CBZ          2  
`define BRANCHCTRL_CBNZ         1    
`define BRANCHCTRL_BCOND        0  

`define PCPLUS4                 2'b00
`define PCBRANCH                2'b01
`define PCALUOUT                2'b10
`define NOOP                    2'b11

`define BCOND_NV                5'b00000
`define BCOND_EQ                5'b00001
`define BCOND_NE                5'b00010
`define BCOND_HS                5'b00011
`define BCOND_LE                5'b00100
`define BCOND_LO                5'b00101
`define BCOND_MI                5'b00111
`define BCOND_PL                5'b01000
`define BCOND_VS                5'b01001
`define BCOND_VC                5'b01010
`define BCOND_HI                5'b01011
`define BCOND_LS                5'b01100
`define BCOND_GE                5'b01101
`define BCOND_LT                5'b01110
`define BCOND_GT                5'b01111
`define BCOND_AL                5'b11111