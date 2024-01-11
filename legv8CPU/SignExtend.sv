`include "headers/bus.svh"
`include "headers/sign_extend.svh"

module SignExtend(
input logic[`INSTRSIZE-1:0] instr,
input logic[4:0] imm_op,
output logic[`REGDATASIZE-1:0] immediate
);
 
 always_comb begin
	 casex(imm_op)
		//immediate for b type, lsl(2) to word_adress -> byte_adress 
		`IMMOP_B     : immediate = {{36{instr[25]}}, instr[25:0], 2'b0};
		//immediate for cb, lsl(2) to word_adress -> byte_adress 
		`IMMOP_CB    : immediate = {{43{instr[23]}}, instr[23:5], 2'b0};
		`IMMOP_I     : immediate = {52'b0, instr[21:10]};
		`IMMOP_SHIFT : immediate = {58'b0, instr[15:10]};
		`IMMOP_D     : immediate = {{55{instr[20]}}, instr[20:12]};
		 default  : immediate = 64'bx;
	 endcase
 end
endmodule : SignExtend