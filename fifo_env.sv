
class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)

  write_agent ag1;
  read_agent ag2;
  clear_agent ag3;
  fifo_scoreboard sb;
  fifo_subscriber sub;
  vsequencer  vs;

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    ag1 = write_agent::type_id::create("ag1", this);
    ag2 = read_agent::type_id::create("ag2", this);
    ag3 = clear_agent::type_id::create("ag3",this);
    sb=fifo_scoreboard::type_id::create("sb",this);
    sub=fifo_subscriber::type_id::create("sub",this);
    vs  = vsequencer::type_id::create("vs", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    ag1.mon1.item_collected_port_1.connect(sb.ap_exp_data_export);
    ag2.mon2.item_collected_port_2.connect(sb.ap_act_data_export);
    ag3.mon3.item_collected_port_3.connect(sb.ap_clr_data_export);
    ag2.mon2.mon2c_put_port_2.connect(sub.mon2c_put_export);
    vs.sqnr1 = ag1.sqnr1;
    vs.sqnr2 = ag2.sqnr2;
    vs.sqnr3 = ag3.sqnr3;
  endfunction

endclass
