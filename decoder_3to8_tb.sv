module decoder_3to8_tb;

    logic a, b, c;
    wire [7:0] dec_out;

    // Instantiate decoder
    decoder_3to8 dut (
        .a(a),
        .b(b),
        .c(c),
        .dec_out(dec_out)
    );

    initial begin

        $display("Starting 3-to-8 decoder test");

        // 000
        a = 0;
        b = 0;
        c = 0;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 001
        a = 0;
        b = 0;
        c = 1;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 010
        a = 0;
        b = 1;
        c = 0;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 011
        a = 0;
        b = 1;
        c = 1;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 100
        a = 1;
        b = 0;
        c = 0;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 101
        a = 1;
        b = 0;
        c = 1;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 110
        a = 1;
        b = 1;
        c = 0;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        // 111
        a = 1;
        b = 1;
        c = 1;
        #1;

        $display("abc = %b%b%b, dec_out = %b",
                 a, b, c, dec_out);


        $display("Decoder test finished");

        $finish;

    end

endmodule
