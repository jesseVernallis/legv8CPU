`include "headers/bus.svh"
`include "headers/aluop.svh"
`include "headers/flags.svh"

module Alu(
input logic[`ALUOPSIZE-1:0] alu_op,
input  logic[`REGDATASIZE-1:0] operand1,
operand2,
output logic[`FLAGSIZE-1:0] flags,
output  logic[`REGDATASIZE-1:0] result);

 //intermediary wires
 logic same_sign_op, diff_sign_res; 
 //perform operation
 always_comb begin
	casex(alu_op)
		`ALUOP_SUB    : result = operand1 - operand2;
		`ALUOP_LSHIFT : result = operand1 << operand2;
		`ALUOP_RSHIFT : result = operand1 >> operand2;
		`ALUOP_XOR    : result = operand1 ^ operand2;
		`ALUOP_ADD    : result = operand1 + operand2;
		`ALUOP_ORR    : result = operand1 | operand2;
		`ALUOP_AND    : result = operand1 & operand2;
		default       : result = operand1 + operand2;
	endcase
	
	//set flags
	flags[`NEGATIVE] = result[`REGDATASIZE-1];
	flags[`ZERO]     = (result == 0);
	flags[`CARRY]    = (operand1 > operand2);
	// operand1 same sign as operand2
	same_sign_op  = (operand1[`REGDATASIZE-1] == operand2[`REGDATASIZE-1]);
	//operand1 different sign as result
	diff_sign_res = (operand1[`REGDATASIZE-1] != result[`REGDATASIZE-1]);
	//case ADD or SUB
	case(alu_op[`ALUOPSIZE-1])
		1'b0 : flags[`OVERFLOW] =  same_sign_op & diff_sign_res; 
		1'b1 : flags[`OVERFLOW] = ~same_sign_op & diff_sign_res;
	endcase
 end
endmodule : Alu