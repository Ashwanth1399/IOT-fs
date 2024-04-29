class read_agent extends uvm_agent;
  `uvm_component_utils(read_agent)

  read_sequencer sqnr2;
  read_monitor  mon2;
  read_driver  drv2;


  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    mon2  = read_monitor::type_id::create("mon2", this);
    sqnr2 = read_sequencer::type_id::create("sqnr2", this);
    drv2  = read_driver::type_id::create("drv2", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv2.seq_item_port.connect(sqnr2.seq_item_export);
  endfunction
endclass