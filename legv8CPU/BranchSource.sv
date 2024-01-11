`include "headers/branch.svh"

module BranchSource(input logic [`BRANCHOP_SIZE-1:0] branch_op,
input logic[`FLAGSIZE-1:0] flags,
input logic[4:0] cond,
input clk,
input reset,
input setflags,
output logic [1:0]branch);

	logic [`FLAGSIZE-1:0] flags_reg;
	logic n_eq_v;
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
		// negitive flag == overflow flag in flag_reg
		n_eq_v = flags_reg[`NEGATIVE] == flags_reg[`OVERFLOW];
		casex(branch_op)
			`BRANCHOP_B     : branch = `PCBRANCH;
			`BRANCHOP_BR    : branch = `PCALUOUT;
			`BRANCHOP_BL    : branch = `PCBRANCH;
			`BRANCHOP_CBZ   : branch = {1'b0, flags[`ZERO]};
			`BRANCHOP_CBNZ  : branch = {1'b0, ~(flags[`ZERO])};	
			`BRANCHOP_BCOND : begin
									case(cond)
										`BCOND_EQ: branch = {1'b0,flags_reg[`ZERO]}; 
										`BCOND_NE: branch = {1'b0,~flags_reg[`ZERO]};
										`BCOND_HS: branch = {1'b0,flags_reg[`CARRY]};
										`BCOND_LO: branch = {1'b0,~flags_reg[`CARRY]};
										`BCOND_MI: branch = {1'b0,flags_reg[`NEGATIVE]};
										`BCOND_PL: branch = {1'b0,~flags_reg[`NEGATIVE]};
										`BCOND_VS: branch = {1'b0,flags_reg[`OVERFLOW]};
										`BCOND_VC: branch = {1'b0,~flags_reg[`OVERFLOW]};
										`BCOND_HI: branch = {1'b0,~flags_reg[`ZERO] & flags_reg[`CARRY]};
										`BCOND_LS: branch = {1'b0,~flags_reg[`ZERO] | (~flags_reg[`CARRY])};
										`BCOND_GE: branch = {1'b0, n_eq_v};
										`BCOND_LT: branch = {1'b0, ~n_eq_v};
										`BCOND_GT: branch = {1'b0, (~flags_reg[`ZERO]) & n_eq_v};
										`BCOND_LE: branch = {1'b0, (flags_reg[`ZERO]) & (~n_eq_v)};
										`BCOND_NV: branch = `PCPLUS4;
										`BCOND_AL: branch = `PCBRANCH;
										 default : branch = `PCPLUS4;
									endcase
			end
			default         : branch = `PCPLUS4;
		endcase
	end
endmodule : BranchSource