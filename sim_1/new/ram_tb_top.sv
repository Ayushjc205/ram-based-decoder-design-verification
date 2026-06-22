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

    // TEST HANDLE
    string testname;
    ram_base_test test;

    // TEST SELECTION
    initial begin

        // GET TESTNAME
        if(!$value$plusargs("TESTNAME=%s", testname)) begin

            testname = "ram_random_test";

            $display("\n================================================");
            $display("[TOP] TESTNAME NOT PROVIDED");
            $display("[TOP] Using default test : %s", testname);
            $display("================================================");

        end

        // DISPLAY TEST
        $display("\n================================================");
        $display("[TOP] RUNNING TEST : %s", testname);
        $display("================================================\n");

        // CREATE TEST
        case(testname)

            "ram_random_test":
                test = ram_random_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_block_boundary_test":
                test = ram_block_boundary_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_full_sweep_test":
                test = ram_full_sweep_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_walking1_data_test":
                test = ram_walking1_data_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_walking0_data_test":
                test = ram_walking0_data_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_walking1_addr_test":
                test = ram_walking1_addr_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_walking0_addr_test":
                test = ram_walking0_addr_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_same_addr_overwrite_test":
                test = ram_same_addr_overwrite_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_toggle_addr_test":
                test = ram_toggle_addr_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_checkerboard_test":
                test = ram_checkerboard_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_block_isolation_test":
                test = ram_block_isolation_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_allzero_test":
                test = ram_allzero_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_allone_test":
                test = ram_allone_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_read_before_write_test":
                test = ram_read_before_write_test::new(
                    ramif, ramif, ramif, ramif);

            "ram_constrained_weighted_test":
                test = ram_constrained_weighted_test::new(
                    ramif, ramif, ramif, ramif);

        default: begin
    $display("================================================");
    $display("[TOP] ERROR : UNKNOWN TEST");
    $display("[TOP] TESTNAME = %s", testname);
    $display("================================================");
    $fatal;
end

endcase

        // CHECK TEST HANDLE
       if(test == null) begin
         $display("================================================");
         $display("[TOP] ERROR : Test object was not created");
         $display("================================================");
         $fatal;
end

        // RUN TEST
        test.run();
        
        // FINISH
        $display("\n================================================");
        $display("[TOP] TEST COMPLETED : %s", testname);
        $display("================================================\n");

        #20;

        $display("\n================================================");
        $display("[TOP] ALL TESTS COMPLETED");
        $display("================================================\n");

        $finish;

    end

endmodule
