class fifo_test extends uvm_test;

  `uvm_component_utils(fifo_test)

  fifo_env ev;
  vsequence vseq;                  // write and read parallely 
  read_sequence rseq;             //read sequence to drive the fifo empty 

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    ev   = fifo_env::type_id::create("ev", this);
    vseq = vsequence::type_id::create("vseq", this);
    rseq = read_sequence::type_id::create("rseq", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    begin
      `uvm_info("", $sformatf("inside test"), UVM_LOW);
      vseq.start(ev.vs);              // Virtual sequencer should start both same time
    end
    phase.drop_objection(this);
  endtask

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass


