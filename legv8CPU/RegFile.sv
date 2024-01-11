`include "headers/bus.svh"

module RegFile(
input logic[`REGADDRSIZE-1:0] addr_read_reg1,
addr_read_reg2,
addr_write_reg,
input logic clk,
reset,
enable_write,
input logic[`REGDATASIZE-1:0] data_write_reg,
output logic[`REGDATASIZE-1:0] data_read_reg1,
data_read_reg2   
);

logic[`REGDATASIZE-1:0] reg_file [32];
//logic for writing to regester
always_ff @(posedge clk, posedge reset) begin
    if(reset) begin
		  // reset regesters
		  //set XZR = 0
        reg_file <= '{default:0};
    end
    else if(enable_write && (addr_write_reg != 31)) begin
        reg_file[addr_write_reg] <= data_write_reg;
    end
    else begin
        reg_file <= reg_file;
    end
end
//Read the data at both read adresses
always_comb begin
    data_read_reg1 = reg_file[addr_read_reg1];
    data_read_reg2 = reg_file[addr_read_reg2];
end
endmodule : RegFile
