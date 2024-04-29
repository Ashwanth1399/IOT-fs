class write_agent extends uvm_agent;
  `uvm_component_utils(write_agent)

  write_sequencer sqnr1;
  write_monitor mon1;
  write_driver drv1;


  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    mon1  = write_monitor::type_id::create("mon1", this);
    sqnr1 = write_sequencer::type_id::create("sqnr1", this);
    drv1  = write_driver::type_id::create("drv1", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv1.seq_item_port.connect(sqnr1.seq_item_export);
  endfunction
endclass


