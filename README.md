# Decoder Based RAM Verification using SystemVerilog

<p align="center">
  <img src="sim_1/architecture.png" alt="Decoder Based RAM Verification Architecture" width="850"/>
</p>

# Verification Plan

| Test ID | Test | Purpose |
|:------:|------|---------|
| TC01 | Random Read/Write | Verify basic RAM functionality using random accesses |
| TC02 | Block Boundary | Verify decoder block boundaries |
| TC03 | Full Address Sweep | Access all 128 memory locations |
| TC04 | Walking-1 Data | Verify each data bit independently |
| TC05 | Walking-0 Data | Detect stuck-at faults on data bus |
| TC06 | Walking-1 Address | Verify each address line |
| TC07 | Walking-0 Address | Verify inverted address patterns |
| TC08 | Same Address Overwrite | Verify latest write updates memory |
| TC09 | Toggle Address | Alternate write/read on same location |
| TC10 | Checkerboard Pattern | Detect coupling faults using AA/55 |
| TC11 | Block Isolation | Ensure writes do not affect other blocks |
| TC12 | All-Zero Data | Verify storing 0x00 across RAM |
| TC13 | All-One Data | Verify storing 0xFF across RAM |
| TC14 | Read Before Write | Verify default memory contents |
| TC15 | Constrained Random | Improve functional coverage |
| TC16 | Boundary Pattern Cross | Close boundary × pattern cross coverage |

---

# Repository Structure

```text
Decoder-Based-RAM-Verification/
│
├── sources_1/
│   └── decoder_ram.sv                 # RTL Design
│
├── sim_1/
│   ├── ram_base_test.sv               # All verification testcases
│   ├── ram_env.sv                     # Verification environment
│   ├── ram_generator.sv               # Transaction generator
│   ├── ram_if.sv                      # Interface & clocking blocks
│   ├── ram_read_driver.sv             # Read driver
│   ├── ram_write_driver.sv            # Write driver
│   ├── ram_read_monitor.sv            # Read monitor
│   ├── ram_write_monitor.sv           # Write monitor + Functional Coverage
│   ├── ram_ref_model.sv               # Reference model
│   ├── ram_scoreboard.sv              # Scoreboard
│   ├── ram_transaction.sv             # Transaction class
│   ├── ram_tb_top.sv                  # Testbench top
│   └── regression_tb_top.sv           # Regression top
│
├── tcl_script.sh                      # Simulation script
│
└── README.md
```

---

