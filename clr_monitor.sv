class clear_monitor extends uvm_monitor;

  `uvm_component_utils(clear_monitor)

  uvm_analysis_port #(fifo_clear_sequence_item) item_collected_port_3;

  virtual interf vintf;
  fifo_clear_sequence_item fifo_trans;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    fifo_trans = new();
    item_collected_port_3 = new("item_collected_port_3", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fifo_trans = fifo_clear_sequence_item::type_id::create("fifo_trans");
    if (!uvm_config_db#(virtual interf)::get(this, "", "vintf", vintf)) begin
      `uvm_error("", "uvm_get_config interface failed\n");
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    begin
      forever begin
        @(posedge vintf.clk);
        fifo_trans.clear = vintf.clear;
        item_collected_port_3.write(fifo_trans);
        `uvm_info("", $sformatf("Monitor: clear is %x\n", vintf.clear), UVM_LOW)
      end
    end
  endtask
endclass

