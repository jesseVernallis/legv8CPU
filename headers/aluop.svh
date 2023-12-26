// size of aluop bus 
`define ALUOPSIZE       5

// last two bits of ALU operation code 
`define ALUOP_AND       5'b00000
`define ALUOP_ORR       5'b00001
`define ALUOP_ADD       5'b00010
`define ALUOP_XOR       5'b00011
`define ALUOP_RSHIFT    5'b001xx
`define ALUOP_LSHIFT    5'b01xxx
`define ALUOP_SUB       5'b1xxxx

`define ALUCTRL_AND       2'b00
`define ALUCTRL_ORR       2'b01
`define ALUCTRL_ADD       2'b10
`define ALUCTRL_XOR       2'b11
