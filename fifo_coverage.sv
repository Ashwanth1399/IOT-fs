
class fifo_subscriber extends uvm_subscriber #(fifo_read_sequence_item);
  `uvm_component_utils(fifo_subscriber)

  uvm_analysis_imp #(fifo_read_sequence_item, fifo_subscriber) mon2c_put_export;

  fifo_read_sequence_item tx;

  bit full;
  bit empty1;
  bit wr_en;
  bit rd_en;
  bit [7:0] din;
  bit [7:0] dout;
  bit [2:0] wr_ptr;
  bit [2:0] rd_ptr;
  bit clear;
  covergroup cg_group;
    option.per_instance = 1;
    c1: cross full, wr_en;
    c2: cross empty1, rd_en;
    c3: cross rd_en, wr_en;
    c4: coverpoint wr_ptr;
    c5: coverpoint rd_ptr;
    c6: coverpoint wr_ptr {bins rollover = (7 => 0);}
    c7: coverpoint rd_ptr {bins rollover = (7 => 0);}
    c8: coverpoint din;
    c9: coverpoint dout;
    c10: coverpoint wr_en;
    c11: coverpoint empty1;
    c12: coverpoint full;
    c13: coverpoint rd_en;
    c14: coverpoint clear;
    crs1: cross clear , wr_en , rd_en;
    crs2: cross clear , full ;
    crs3: cross clear , empty1;
  endgroup : cg_group

  function new(string name = "fifo_subscriber", uvm_component parent = null);
    super.new(name, parent);
    cg_group = new();
  endfunction

  virtual function void build_phase(uvm_phase phase);
    mon2c_put_export = new("mon2c_put_export", this);
  endfunction

  virtual function void write(fifo_read_sequence_item t);
    tx = t;
    cg_group.sample();
    `uvm_info("Coverage", "------Coverage PASSED-------", UVM_MEDIUM)
  endfunction
endclass
