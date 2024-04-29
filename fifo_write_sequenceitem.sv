`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_write_sequence_item extends uvm_sequence_item;

  
  rand bit wr_en;
  rand bit [7:0] din;

  `uvm_object_utils_begin(fifo_write_sequence_item)
  `uvm_field_int(wr_en,UVM_ALL_ON)
  `uvm_field_int(din,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "fifo_write_sequence_item");
    super.new(name);
  endfunction

endclass

class fifo_write_sequence_item_more_write extends fifo_write_sequence_item;

  `uvm_object_utils(fifo_write_sequence_item_more_write)  
  
  constraint c {
    wr_en dist {
      0 := 2,
      1 := 8
    };
  }

  function new(string name = "fifo_write_sequence_item_more_write");
    super.new(name);
  endfunction
endclass

class fifo_write_sequence_item_less_write extends fifo_write_sequence_item;

  `uvm_object_utils(fifo_write_sequence_item_less_write)

  constraint c {
    wr_en dist {
      0 := 7,
      1 := 3
    };
  }

  function new(string name = "fifo_write_sequence_item_less_write");
    super.new(name);
  endfunction

endclass
