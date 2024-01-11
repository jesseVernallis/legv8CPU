module DataMemory #(parameter INSTRPATH =`MEM_FILE,
						  parameter INSTRNUM  = 1024)(
input logic mem_clk,
reset,
read_enable,
write_enable,
input logic [`REGDATASIZE-1:0] addr,
write_data,
output logic [`REGDATASIZE-1:0] read_data
);

 logic [`REGDATASIZE-1:0] mem_data[INSTRNUM];
 logic [`REGDATASIZE-1:0] mem_wire;

 initial begin
	 $readmemb(INSTRPATH,mem_data);
 end
 
 always_ff @(posedge mem_clk, posedge reset) begin
	 if(reset) begin
		 mem_wire <= 0;
	 end
	 else begin
		 //read from memory if LDUR
		 if(read_enable) begin
			 mem_wire <= mem_data[addr/8];
		 end
		 //write to memory if STUR
		 if(write_enable) begin
			 mem_data[addr/8] <= write_data;
		 end
	 end
 end
 
 assign read_data = mem_wire;
endmodule : DataMemory

