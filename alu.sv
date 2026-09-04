
`define sum 3'b000
`define sub 3'b001
`define AND 3'b010
`define OR  3'b011

module alu(Ain,Bin,ALUop,out,z);  // dont forget ; for moudle

input [15:0] Ain;   // two 16 bit reg
input [15:0] Bin;
input [2:0] ALUop;

output [15:0] out;
output z; // zero flag


reg [15:0] out;
reg z;

/*Does this block just CALCULATE from its current inputs?
? always_comb

Does this block need to REMEMBER something between clock cycles?
? always_ff @(posedge clk)*/

always_comb begin

case (ALUop)
`sum : out= Ain + Bin;
`sub : out= Ain - Bin;
`AND : out= Ain & Bin; 
`OR  : out= Ain | Bin;
default: out = 16'b0; 
endcase // ALUop case



if (out == 16'b0000_0000_0000_0000)  // zero flag
     z=1'b1; 
     
else  
     z=1'b0;
      
end // always_comb



endmodule
