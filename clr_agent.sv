class clear_agent extends uvm_agent;
  `uvm_component_utils(clear_agent)

  clear_sequencer sqnr3;
  clear_monitor  mon3;
  clear_driver  drv3;


  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    mon3  = clear_monitor::type_id::create("mon3", this);
    sqnr3 = clear_sequencer::type_id::create("sqnr3", this);
    drv3  = clear_driver::type_id::create("drv3", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv3.seq_item_port.connect(sqnr3.seq_item_export);
  endfunction
endclass