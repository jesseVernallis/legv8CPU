`include "headers/control.svh"
`include "headers/bus.svh"
`include "headers/aluop.svh"
`include "headers/opcode.svh"


module tbControlUnit();
logic [`OPCODESIZE - 1:0] opcode;
logic [`CONTROLSIZE - 1:0] control;
logic [`ALUOPSIZE - 1:0] alu_op;
logic [5:0] branch_op;
logic [4:0] imm_op;
 
ControlUnit DUT(
.opcode(opcode),
.control(control),
.alu_op(alu_op),
.branch_op(branch_op),
.imm_op(imm_op)
);

initial begin
opcode = 11'b100_0101_1000;//ADD
#100ns;
opcode = 11'b100_1000_1000;//ADDI
#100ns;
opcode = 11'b010_1010_0101;//BCOND
#100ns;
opcode = 11'b100_1011_1010;//BL
#100ns;
opcode = 11'b110_1001_1011;//LSL
#100ns;
opcode = 11'b111_0101_1000;//SUBS
#100ns;
$finish();
end
endmodule