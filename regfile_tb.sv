`timescale 1ns/1ps

module regfile_tb;

    // Inputs to the register file
    logic clk;
    logic write_enable;

    logic [2:0] read_addr1;
    logic [2:0] read_addr2;
    logic [2:0] write_addr;

    logic [15:0] write_data;

    // Outputs from the register file
    logic [15:0] read_data1;
    logic [15:0] read_data2;


    // Instantiate your register file
    regfile dut (
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),

        .read_data1(read_data1),
        .read_data2(read_data2),

        .write_addr(write_addr),
        .write_data(write_data),

        .write_enable(write_enable),
        .clk(clk)
    );


    // Clock
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    initial begin

        // Starting values
        write_enable = 0;

        write_addr = 3'b000;
        write_data = 16'b0;

        read_addr1 = 3'b000;
        read_addr2 = 3'b000;

        #4;


        // ----------------------------------------------------
        // TEST 1:
        // R0 should always read as zero
        // ----------------------------------------------------

        $display("TEST 1: Reading R0");

        read_addr1 = 3'b000;
        read_addr2 = 3'b000;

        #1;

        $display("read_data1 = %d", read_data1);
        $display("read_data2 = %d", read_data2);


        // ----------------------------------------------------
        // TEST 2:
        // Write 42 into R3
        // ----------------------------------------------------

        $display("");
        $display("TEST 2: Writing 42 into R3");

        write_addr = 3'b011;
        write_data = 16'd42;
        write_enable = 1;

        // Wait for a rising clock edge
        @(posedge clk);

        // Give simulation a tiny amount of time
        // for nonblocking assignment to update
        #1;

        write_enable = 0;


        // ----------------------------------------------------
        // TEST 3:
        // Read R3 from BOTH read ports
        // ----------------------------------------------------

        $display("");
        $display("TEST 3: Reading R3 from both ports");

        read_addr1 = 3'b011;
        read_addr2 = 3'b011;

        #1;

        $display("read_data1 = %d", read_data1);
        $display("read_data2 = %d", read_data2);


        // ----------------------------------------------------
        // TEST 4:
        // Write different values into R2 and R5
        // ----------------------------------------------------

        $display("");
        $display("TEST 4: Writing 100 into R2");

        write_addr = 3'b010;
        write_data = 16'd100;
        write_enable = 1;

        @(posedge clk);
        #1;


        $display("Writing 250 into R5");

        write_addr = 3'b101;
        write_data = 16'd250;

        @(posedge clk);
        #1;

        write_enable = 0;


        // ----------------------------------------------------
        // TEST 5:
        // Read two DIFFERENT registers simultaneously
        // ----------------------------------------------------

        $display("");
        $display("TEST 5: Reading R2 and R5 simultaneously");

        read_addr1 = 3'b010;
        read_addr2 = 3'b101;

        #1;

        $display("R2 through port 1 = %d", read_data1);
        $display("R5 through port 2 = %d", read_data2);


        // ----------------------------------------------------
        // TEST 6:
        // write_enable = 0 should prevent writes
        // ----------------------------------------------------

        $display("");
        $display("TEST 6: Trying to overwrite R3 while write_enable = 0");

        write_addr = 3'b011;
        write_data = 16'd999;
        write_enable = 0;

        @(posedge clk);
        #1;

        read_addr1 = 3'b011;

        #1;

        $display("R3 should still be 42: %d", read_data1);


        // ----------------------------------------------------
        // TEST 7:
        // Trying to write R0 should do nothing
        // ----------------------------------------------------

        $display("");
        $display("TEST 7: Trying to write 555 into R0");

        write_addr = 3'b000;
        write_data = 16'd555;
        write_enable = 1;

        @(posedge clk);
        #1;

        write_enable = 0;

        read_addr1 = 3'b000;

        #1;

        $display("R0 should still be 0: %d", read_data1);


        // ----------------------------------------------------
        // End simulation
        // ----------------------------------------------------

        $display("");
        $display("TESTBENCH FINISHED");

        $stop;

    end

endmodule
