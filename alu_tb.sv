module alu_tb;

    // signals going INTO your ALU
    logic [15:0] Ain;
    logic [15:0] Bin;
    logic [1:0] ALUop;

    // signals coming OUT
    logic [15:0] out;
    logic z;


    // instantiate your ALU here
    alu DUT (
        .Ain(Ain),
        .Bin(Bin),
        .ALUop(ALUop),
        .out(out),
        .z(z)
    );


    initial begin

        // TEST 1: ADD
        Ain = 16'd5;
        Bin = 16'd7;
        ALUop = 2'b01;

        #10;

      
        // TEST 2: SUB

        Ain = 16'd9;
        Bin = 16'd4;
        ALUop=2'b10;  //out 5

#10;

        // TEST 3: AND
       
Ain =16'b1001;
Bin =16'b1000;
ALUop=2'b11;

#10;

//OR
Ain =16'b1001;
Bin =16'b1000;
ALUop=2'b00;

#10;

//flag 
Ain =16'b1001;
Bin =16'b0110;
ALUop=2'b11;

#10;

    end

endmodule
