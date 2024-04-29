class fifo_clear_sequence_item extends uvm_sequence_item;

  
  rand bit clear;

  `uvm_object_utils_begin(fifo_clear_sequence_item)
  `uvm_field_int(clear,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "fifo_clear_sequence_item");
    super.new(name);
  endfunction

endclass



class fifo_clear_sequence_item_more_clear extends fifo_clear_sequence_item;

  `uvm_object_utils(fifo_clear_sequence_item_more_clear)  
  
  constraint c {
    clear dist {
      0 := 2,
      1 := 8
    };
  }

  function new(string name = "fifo_clear_sequence_item_more_clear");
    super.new(name);
  endfunction
endclass

class fifo_clear_sequence_item_less_clear extends fifo_clear_sequence_item;

  `uvm_object_utils(fifo_clear_sequence_item_less_clear)

  constraint c {
    clear dist {
      0 := 8,
      1 := 2
    };
  }

  function new(string name = "fifo_clear_sequence_item_less_clear");
    super.new(name);
  endfunction

endclass


