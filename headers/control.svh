//number of masks used in the control unit
//size of control bus
`define CONTROLSIZE             9

//ID Control Bits
`define REG1ZERO                8
`define REG2LOC                 7
//EX control bits
`define ALUSRC                  6
//DM control bits
`define SETFLAGS                5
`define MEMREAD                 4
`define MEMWRITE                3
//WB control bits               
`define PCTOREG                 2
`define MEMTOREG                1
`define REGWRITE                0

`define BRANCH_B                6'b1x_xxxx
`define BRANCH_BR               6'b01_xxxx
`define BRANCH_BL               6'b00_1xxx
`define BRANCH_CBZ              6'b00_01xx
`define BRANCH_CBNZ             6'b00_001x
`define BRANCH_BCOND            6'b00_0001
`define BRANCH_NONE             6'b00_0000

`define BRANCHCTRL_B            5   
`define BRANCHCTRL_BR           4
`define BRANCHCTRL_BL           3
`define BRANCHCTRL_CBZ          2  
`define BRANCHCTRL_CBNZ         1    
`define BRANCHCTRL_BCOND        0   
