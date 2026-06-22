// Passively observes the read bus and forwards to SB/RM
`ifndef RAM_READ_MONITOR_SV
`define RAM_READ_MONITOR_SV

`include "ram_transaction.sv"

class ram_read_monitor;

    virtual ram_if.RD_MON vif;

    mailbox #(ram_transaction) rd_done_mbx; // from read driver
    mailbox #(ram_transaction) sb_rd_mbx;   // to scoreboard
    mailbox #(ram_transaction) rm_rd_mbx;   // to reference model

    int unsigned observed_count;

    function new(virtual ram_if.RD_MON vif,
                 mailbox #(ram_transaction) rd_done_mbx,
                 mailbox #(ram_transaction) sb_rd_mbx,
                 mailbox #(ram_transaction) rm_rd_mbx);
        this.vif            = vif;
        this.rd_done_mbx    = rd_done_mbx;
        this.sb_rd_mbx      = sb_rd_mbx;
        this.rm_rd_mbx      = rm_rd_mbx;
        this.observed_count = 0;
    endfunction

    task run();
        ram_transaction txn;
        $display("[RD-MON] Started");

        forever begin
            rd_done_mbx.get(txn);      
          
           // Additional bus-level sanity: valid must be 1 on a read
            if (txn.valid !== 1'b1) begin
                $warning("[RD-MON] valid not asserted for READ addr=0x%02h", txn.addr);
            end

            observed_count++;
            txn.print("[RD-MON]");

            sb_rd_mbx.put(txn.copy());
            rm_rd_mbx.put(txn.copy());
        end
    endtask

endclass : ram_read_monitor

`endif 
