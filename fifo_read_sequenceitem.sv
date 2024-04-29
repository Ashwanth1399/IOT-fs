`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_read_sequence_item extends uvm_sequence_item;

  rand bit rd_en;
  bit [7:0] dout;
  `uvm_object_utils_begin(fifo_read_sequence_item)
  `uvm_field_int(rd_en,UVM_ALL_ON)
  `uvm_field_int(dout,UVM_ALL_ON)
  `uvm_object_utils_end
  function new(string name = "fifo_read_sequence_item");
    super.new(name);
  endfunction

endclass

class fifo_read_sequence_item_less_read extends fifo_read_sequence_item;

  `uvm_object_utils(fifo_read_sequence_item_less_read)

  constraint c1 {
    rd_en dist {
      0 := 7,
      1 := 3
    };
  }

  function new(string name = "fifo_read_sequence_item_less_read");
    super.new(name);
  endfunction

endclass

class fifo_read_sequence_item_more_read extends fifo_read_sequence_item;

  `uvm_object_utils(fifo_read_sequence_item_more_read)

  constraint c1 {
    rd_en dist {
      0 := 2,
      1 := 8
    };
  }

  function new(string name = "fifo_read_sequence_item_more_read");
    super.new(name);
  endfunction

endclass