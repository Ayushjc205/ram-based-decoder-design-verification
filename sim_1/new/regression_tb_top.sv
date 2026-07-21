`timescale 1ns/1ps

`include "ram_base_test.sv"

module ram_tb_top;

    // clock generation
    logic clk;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // INTERFACE
    ram_if ramif(clk);


    // DUT
    decoder_ram dut (
        .clk   (clk),
        .rst_n (ramif.rst_n),

        .we    (ramif.we),
        .re    (ramif.re),

        .addr  (ramif.addr),

        .wdata (ramif.wdata),
        .rdata (ramif.rdata),

        .valid (ramif.valid)
    );


    // TEST HANDLES

    ram_random_test                 t1;
    ram_block_boundary_test         t2;
    ram_full_sweep_test             t3;
    ram_walking1_data_test          t4;
    ram_walking0_data_test          t5;
    ram_walking1_addr_test          t6;
    ram_walking0_addr_test          t7;
    ram_same_addr_overwrite_test    t8;
    ram_toggle_addr_test            t9;
    ram_checkerboard_test           t10;
    ram_block_isolation_test        t11;
    ram_allzero_test                t12;
    ram_allone_test                 t13;
    ram_read_before_write_test      t14;
    ram_constrained_weighted_test   t15;
    ram_boundary_pattern_test       t16;



    initial begin


        $display("\n==============================================");
        $display("       STARTING RAM REGRESSION TEST");
        $display("==============================================\n");


        // CREATE ALL TEST OBJECTS

        t1  = new(ramif,ramif,ramif,ramif);
        t2  = new(ramif,ramif,ramif,ramif);
        t3  = new(ramif,ramif,ramif,ramif);
        t4  = new(ramif,ramif,ramif,ramif);
        t5  = new(ramif,ramif,ramif,ramif);
        t6  = new(ramif,ramif,ramif,ramif);
        t7  = new(ramif,ramif,ramif,ramif);
        t8  = new(ramif,ramif,ramif,ramif);
        t9  = new(ramif,ramif,ramif,ramif);
        t10 = new(ramif,ramif,ramif,ramif);
        t11 = new(ramif,ramif,ramif,ramif);
        t12 = new(ramif,ramif,ramif,ramif);
        t13 = new(ramif,ramif,ramif,ramif);
        t14 = new(ramif,ramif,ramif,ramif);
        t15 = new(ramif,ramif,ramif,ramif);
        t16 = new(ramif,ramif,ramif,ramif);



        // RUN REGRESSION


        $display("\n[REGRESSION] ram_random_test");
        t1.run();


        $display("\n[REGRESSION] ram_block_boundary_test");
        t2.run();


        $display("\n[REGRESSION] ram_full_sweep_test");
        t3.run();


        $display("\n[REGRESSION] ram_walking1_data_test");
        t4.run();


        $display("\n[REGRESSION] ram_walking0_data_test");
        t5.run();


        $display("\n[REGRESSION] ram_walking1_addr_test");
        t6.run();


        $display("\n[REGRESSION] ram_walking0_addr_test");
        t7.run();


        $display("\n[REGRESSION] ram_same_addr_overwrite_test");
        t8.run();


        $display("\n[REGRESSION] ram_toggle_addr_test");
        t9.run();


        $display("\n[REGRESSION] ram_checkerboard_test");
        t10.run();


        $display("\n[REGRESSION] ram_block_isolation_test");
        t11.run();


        $display("\n[REGRESSION] ram_allzero_test");
        t12.run();


        $display("\n[REGRESSION] ram_allone_test");
        t13.run();


        $display("\n[REGRESSION] ram_read_before_write_test");
        t14.run();


        $display("\n[REGRESSION] ram_constrained_weighted_test");
        t15.run();

        $display("\n[REGRESSION] ram_boundary_pattern_test");
        t116.run();



        $display("\n==============================================");
        $display("       RAM REGRESSION TEST COMPLETE");
        $display("==============================================\n");


        #50;
        $finish;


    end

endmodule
