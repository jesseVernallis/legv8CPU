`include "headers/bus.svh"
`include "headers/aluop.svh"
`include "headers/flags.svh"

module tbAlu();
 logic[`ALUOPSIZE-1:0] alu_op;
 logic[`REGDATASIZE-1:0] operand1, operand2, result;
 logic[`FLAGSIZE-1:0] flags;
 Alu DUT(.alu_op(alu_op),
 .operand1(operand1),
 .operand2(operand2),
 .flags(flags),
 .result(result)
 );

 initial begin
    //SUB
    alu_op   = 5'b10000;
    operand1 = 64'd20;
    operand2 =64'd4;
    #100ns;    
    //LSSHIFT
	alu_op   = 5'b01000;
    operand1 = 64'd3;
    operand2 =64'd3;
    #100ns; 
    //RSHIFT
	alu_op   = 5'b00100;
    operand1 = 64'd16;
    operand2 =64'd2;
    #100ns; 
    //XOR
	alu_op   = 5'b00011;
    operand1 = 64'd31;
    operand2 =64'd16;
    #100ns;
    //ADD    
	alu_op   = 5'b00010;
    operand1 = 64'd4;
    operand2 =-64'd20;
    #100ns;
    //ORR    
	alu_op   = 5'b00001;
    operand1 = 64'd31;
    operand2 =64'd16;
    #100ns;
    //AND    
	alu_op   = 5'b00000;
    operand1 = 64'd31;
    operand2 =64'd64; 
    #100ns;
    $finish();
 end
endmodule : tbAlu