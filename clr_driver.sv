class clear_driver extends uvm_driver #(fifo_clear_sequence_item);

  fifo_clear_sequence_item clrseqitem;

  `uvm_component_utils(clear_driver)

  virtual interf vintf;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    clrseqitem = fifo_clear_sequence_item::type_id::create("clrseqitem", this);
    if (!uvm_config_db#(virtual interf)::get(this, "", "vintf", vintf)) begin
      `uvm_error("", "iDriver:uvm_get_config interface failed\n");
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    begin
      forever begin
        seq_item_port.get_next_item(clrseqitem);
        @(negedge vintf.clk);
        vintf.clear = clrseqitem.clear;
        `uvm_info("", $sformatf("Driver:Received clear=%d", vintf.clear), UVM_MEDIUM)
        seq_item_port.item_done();
      end
    end
  endtask

endclass
