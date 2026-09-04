
// 3 NOT gates 
// 8 AND gates
`define s0 3'b000
`define s1 3'b001
`define s2 3'b010
`define s3 3'b011
`define s4 3'b100
`define s5 3'b101
`define s6 3'b110
`define s7 3'b111

module decoder_3to8(a,b,c,dec_out);

input a,b,c;
output [7:0] dec_out;

logic a_not, b_not, c_not;

not n0(a_not,a);
not n1(b_not,b);
not n2(c_not,c);

and z0(dec_out[0], a_not,b_not,c_not);
and z1(dec_out[1], a_not,b_not,c);
and z2(dec_out[2], a_not, b,c_not);
and z3(dec_out[3], a_not,b,c);
and z4(dec_out[4], a,b_not,c_not);
and z5(dec_out[5], a,b,c_not);
and z6(dec-out[6], a,b_not,c);
and z7(dec_out[7], a,b,c);


endmodule