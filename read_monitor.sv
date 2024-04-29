class read_monitor extends uvm_monitor;

  `uvm_component_utils(read_monitor)
  uvm_analysis_port #(fifo_read_sequence_item) mon2c_put_port_2;
  uvm_analysis_port #(fifo_read_sequence_item) item_collected_port_2;

  virtual interf vintf;
  fifo_read_sequence_item rd_seqitem;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    rd_seqitem = new();
    item_collected_port_2 = new("item_collected_port_2", this);
   mon2c_put_port_2 = new("mon2_put_port_2",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rd_seqitem = fifo_read_sequence_item::type_id::create("rd_seqitem");
    if (!uvm_config_db#(virtual interf)::get(this, "", "vintf", vintf)) begin
      `uvm_error("", "uvm_get_config interface failed\n");
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    begin
      forever begin
        @(posedge vintf.clk);
        if(vintf.rd_en && !vintf.empty1) begin
        rd_seqitem.rd_en = vintf.rd_en;
        #1;
        rd_seqitem.dout = vintf.dout;
        item_collected_port_2.write(rd_seqitem);
        mon2c_put_port_2.write(rd_seqitem);
        end
      end
    end
  endtask
endclass

