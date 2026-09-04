`define s0 3'b000
`define s1 3'b001
`define s2 3'b010
`define s3 3'b011
`define s4 3'b100
`define s5 3'b101
`define s6 3'b110
`define s7 3'b111



module regfile(read_addr1,read_addr2,read_data1,read_data2,write_addr,write_data,write_enable,clk);

input clk, write_enable;
output logic[15:0] read_data1, read_data2;
input [2:0]  read_addr1, read_addr2;

input [15:0] write_data;
input [2:0]  write_addr;

logic [15:0] R0,R1,R2,R3,R4,R5,R6,R7;
assign R0 = 16'b0;

always_comb begin

case(read_addr1)
`s0: read_data1=R0;
`s1: read_data1=R1;
`s2: read_data1=R2;
`s3: read_data1=R3;
`s4: read_data1=R4;
`s5: read_data1=R5;
`s6: read_data1=R6;
`s7: read_data1=R7;
default: read_data1=16'b0;
endcase

case(read_addr2)
`s0: read_data2=R0;
`s1: read_data2=R1;
`s2: read_data2=R2;
`s3: read_data2=R3;
`s4: read_data2=R4;
`s5: read_data2=R5;
`s6: read_data2=R6;
`s7: read_data2=R7;
default: read_data2=16'b0;
endcase

end// always 

always_ff@(posedge clk) begin

if (write_enable) begin
case(write_addr)
`s0: ;
`s1: R1<=write_data;
`s2: R2<=write_data;
`s3: R3<=write_data;
`s4: R4<=write_data;
`s5: R5<=write_data;
`s6: R6<=write_data;
`s7: R7<=write_data;
default:  ;
endcase

end// if
end//always_ff


endmodule
