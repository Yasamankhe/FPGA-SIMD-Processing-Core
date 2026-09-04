
// 3 NOT gates 
// 8 AND gates

/*
one hot output
00000001
00000010
00000100
00001000
00010000
00100000
01000000
10000000
*/



module decoder_3to8(a,b,c,dec_out);

input a,b,c;
output [7:0] dec_out;

logic a_not, b_not, c_not;

not n0(a_not,a);
not n1(b_not,b);
not n2(c_not,c);

and z0(dec_out[0], a_not,b_not,c_not);    //000
and z1(dec_out[1], a_not,b_not,c);        //001
and z2(dec_out[2], a_not, b,c_not);       //010
and z3(dec_out[3], a_not,b,c);            //011
and z4(dec_out[4], a,b_not,c_not);        //100
and z5(dec_out[5], a,b_not,c);            //101
and z6(dec_out[6], a,b,c_not);            //110
and z7(dec_out[7], a,b,c);                //111


endmodule