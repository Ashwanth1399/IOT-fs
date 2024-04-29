class clear_sequencer extends uvm_sequencer #(fifo_clear_sequence_item);

  `uvm_component_utils(clear_sequencer)

  function new(string name = "clear_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass
