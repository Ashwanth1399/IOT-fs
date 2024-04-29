class vsequencer extends uvm_sequencer;
  `uvm_component_utils(vsequencer)

  write_sequencer sqnr1;
  read_sequencer  sqnr2;
  clear_sequencer sqnr3;

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass
