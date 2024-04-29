`include "uvm_macros.svh"
module top;
  import uvm_pkg::*;

  `include "fifo_write_sequenceitem.sv"
  `include "fifo_if.sv"
  `include "fifo_read_sequenceitem.sv"
  `include "clr_sequence_item.sv"
  `include "write_sequence.sv"
  `include "read_sequence.sv"
  `include "clr_sequence.sv"
  `include "write_sequencer.sv"
  `include "read_sequencer.sv"
  `include "clr_sequencer.sv"
  `include "write_driver.sv"
  `include "read_driver.sv"
  `include "clr_driver.sv"
  `include "write_monitor.sv"
  `include "read_monitor.sv"
  `include "clr_monitor.sv"
  `include "write_agent.sv"
  `include "read_agent.sv"
  `include "clr_agent.sv"
  `include "fifo_scoreboard.sv"
  `include "fifo_vsequencer.sv"
  `include "fifo_coverage.sv"
  `include "fifo_env.sv"
  `include "fifo_vsequence.sv"
  `include "fifo_test.sv"
 

interf dut_if ();

  sync_fifo dut (.dif(dut_if));

  initial begin
    dut_if.clk = 0;
    forever #5 dut_if.clk = ~dut_if.clk;
  end

  initial begin
    uvm_config_db#(virtual interf)::set(uvm_root::get(), "*", "vintf", dut_if);
    run_test("fifo_test");
  end

  initial begin
    // Dump waves
    $dumpvars(0, top);
  end

endmodule
