class read_sequencer extends uvm_sequencer #(fifo_read_sequence_item);

  `uvm_component_utils(read_sequencer)

  function new(string name = "read_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass
