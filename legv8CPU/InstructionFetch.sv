`include "headers/bus.svh"
`include "headers/files.svh"

module InstructionFetch #(parameter INSTRPATH=`INSTUCTION_FILE,
								  parameter INSTRNUM=1024)(
input logic clk,
reset,
input logic[`REGDATASIZE-1:0] addr,
output logic[`INSTRSIZE-1:0] instr
);

 logic[`INSTRSIZE-1:0] instr_data [INSTRNUM];
 
 initial begin
	 $readmemb(INSTRPATH,instr_data);
 end
 
 always_ff @(posedge clk, posedge reset) begin
	 if(reset) begin
		 instr <= `INSTRSIZE'b0;
	 end else begin
		 instr <= instr_data[addr/4];
	 end
 end
 
endmodule : InstructionFetch