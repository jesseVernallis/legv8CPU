// mask and bitset for branch return instructions
`define BR_BITSET       11'b110_1011_0000

// mask and bitset of opcodes for flag-based branch instructions 
`define BCOND_MASK      11'b111_1111_1000
`define BCOND_BITSET    11'b010_1010_0000

// mask and bitset for branch link instuction
`define BL_MASK         11'b111_1111_0000
`define BL_BITSET       11'b100_1010_0000

// mask and bitset of opcodes for conditional branch instructions 
`define CBZ_MASK         11'b111_1111_1000
`define CBZ_BITSET       11'b101_1010_0000

// mask and bitset of opcodes for conditional branch instructions 
`define CBNZ_MASK         11'b111_1111_1000
`define CBNZ_BITSET       11'b101_1010_1000

//mask and bitset for offset branch instructions 
`define B_MASK          11'b011_1110_0000
`define B_BITSET        11'b000_1010_0000

//mask and bitset of opcodes for R-format instructions 
`define R_MASK          11'b100_1111_0001
`define R_BITSET        11'b100_0101_0000

// mask and bitset of opcodes for shift instructions 
`define SHIFT_MASK      11'b111_1111_1110
`define SHIFT_BITSET    11'b110_1001_1010

//mask and bitset for I-format instructions 
`define I_MASK          11'b100_1110_0110
`define I_BITSET        11'b100_1000_0000

// mask and bitset of opcodes for memory-load instructions 
`define LDUR_MASK       11'b001_1111_1111
`define LDUR_BITSET     11'b001_1100_0010

// mask and bitset of opcodes for memory-store instructions 
`define STUR_MASK       11'b001_1111_1111
`define STUR_BITSET     11'b001_1100_0000

`define ANDS            6'b111000
`define ADDS            6'b101100
`define SUBS            6'b111100
