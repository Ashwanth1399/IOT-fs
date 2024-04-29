class write_driver extends uvm_driver #(fifo_write_sequence_item);

  fifo_write_sequence_item wrseqitem;

  `uvm_component_utils(write_driver)

  virtual interf vintf;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wrseqitem = fifo_write_sequence_item::type_id::create("wrseqitem", this);
    if (!uvm_config_db#(virtual interf)::get(this, "", "vintf", vintf)) begin
      `uvm_error("", "iDriver:uvm_get_config interface failed\n");
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    begin
      vintf.reset = 1;
      @(posedge vintf.clk);
      vintf.reset = 0;
      forever begin
        seq_item_port.get_next_item(wrseqitem);
        @(negedge vintf.clk);
        vintf.din   = wrseqitem.din;
        vintf.wr_en = wrseqitem.wr_en;
        `uvm_info("", $sformatf("Driver:Received din=%d", vintf.din), UVM_MEDIUM)
        seq_item_port.item_done();
      end
    end
  endtask

endclass

