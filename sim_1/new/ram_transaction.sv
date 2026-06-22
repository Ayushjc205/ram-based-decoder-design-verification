// Transaction for decoder RAM testbench

`ifndef RAM_TRANSACTION_SV
`define RAM_TRANSACTION_SV

typedef enum logic { WRITE = 1'b0, READ = 1'b1 } op_t;

class ram_transaction;

    rand op_t       op;         
    rand logic [6:0] addr;       
    rand logic [7:0] wdata;      
         logic [7:0] rdata;      
         logic       valid;      
	bit skip;
  
    // Full address range
    constraint addr_range_c {
        addr inside {[7'h00 : 7'h7F]};
    }

    // Data byte can be anything
    constraint data_range_c {
        wdata inside {[8'h00 : 8'hFF]};
    }

    function new();
        op    = WRITE;
        addr  = 7'h00;
        wdata = 8'h00;
        rdata = 8'h00;
        valid = 1'b0;
    endfunction
  
    // Deep copy
    function ram_transaction copy();
        copy       = new();
        copy.op    = this.op;
        copy.addr  = this.addr;
        copy.wdata = this.wdata;
        copy.rdata = this.rdata;
        copy.valid = this.valid;
    endfunction

    function void print(string tag = "");
        $display("[%0t] %s | op=%s addr=0x%02h wdata=0x%02h rdata=0x%02h valid=%0b",
                 $time, tag,
                 (op == WRITE) ? "WRITE" : "READ ",
                 addr, wdata, rdata, valid);
    endfunction

endclass : ram_transaction

`endif

