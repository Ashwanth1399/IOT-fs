class read_driver extends uvm_driver #(fifo_read_sequence_item);

  `uvm_component_utils(read_driver)

  virtual interf vintf;
  fifo_read_sequence_item rdseqitem;


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rdseqitem = fifo_read_sequence_item::type_id::create("rdseqitem", this);
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
        seq_item_port.get_next_item(rdseqitem);
        @(negedge vintf.clk);
        vintf.rd_en = rdseqitem.rd_en;
        `uvm_info("", $sformatf("Driver:Received rd_en=%d", vintf.rd_en), UVM_MEDIUM)
        seq_item_port.item_done();
      end
    end
  endtask


endclass

