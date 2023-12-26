
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
`define PC                      2'b11