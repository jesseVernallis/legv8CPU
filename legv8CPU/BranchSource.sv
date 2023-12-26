`include "headers/branch.svh"

module BranchSource(input logic [`BRANCHOP_SIZE-1:0] branch_op,
input logic[`FLAGSIZE-1:0] flags,
input logic[4:0] COND,
input clk,
input reset,
input setflags,
output logic [1:0]branch);

	logic [`FLAGSIZE-1:0] flags_reg;
	always_ff @(posedge clk, posedge reset) begin
		if(reset) begin
			flags_reg <= 0;
		end
		else if(setflags) begin
		
			flags_reg[`NEGATIVE] = flags[`NEGATIVE];
			flags_reg[`ZERO]     = flags[`ZERO];
			flags_reg[`CARRY]    = flags[`CARRY];
			flags_reg[`OVERFLOW] = flags[`OVERFLOW];
		end
		else begin
			flags_reg[`NEGATIVE] = flags_reg[`NEGATIVE];
			flags_reg[`ZERO]     = flags_reg[`ZERO];
			flags_reg[`CARRY]    = flags_reg[`CARRY];
			flags_reg[`OVERFLOW] = flags_reg[`OVERFLOW];
		end
	end
	
	always_comb begin
		casex(branch_op)
			`BRANCHOP_B     : branch = `PCBRANCH;
			`BRANCHOP_BR    : branch = `PCALUOUT;
			`BRANCHOP_BL    : branch = `PCBRANCH;
			`BRANCHOP_CBZ   : branch = {1'b0, flags[`ZERO]};`
			`BRANCHOP_CBNZ  : branch = {1'b0, ~(flags[`ZERO])};	
			`BRANCHOP_BCOND : branch = ;
			default         : branch = `NOOP;
		endcase
	end
endmodule : BranchSource