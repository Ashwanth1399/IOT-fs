`uvm_analysis_imp_decl(_exp_data)
`uvm_analysis_imp_decl(_act_data)
`uvm_analysis_imp_decl(_clr_data)

class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  
  uvm_analysis_imp_exp_data #(fifo_write_sequence_item, fifo_scoreboard) ap_exp_data_export;
  uvm_analysis_imp_act_data #(fifo_read_sequence_item, fifo_scoreboard) ap_act_data_export;
  uvm_analysis_imp_clr_data #(fifo_clear_sequence_item, fifo_scoreboard) ap_clr_data_export;
  
  //fifo_write_sequence_item exp_que[$];
  bit [31:0] exp_que[$];
  fifo_read_sequence_item act_que[$];
  fifo_clear_sequence_item clr_que[$];  
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap_exp_data_export = new("ap_exp_data_export", this);
    ap_act_data_export = new("ap_act_data_export", this);
    ap_clr_data_export = new("ap_clr_data_export", this);
  endfunction
  
  function void write_exp_data(input fifo_write_sequence_item tr);
    exp_que.push_back(tr.din);
  endfunction
  
  function void write_act_data(input fifo_read_sequence_item tr);
    act_que.push_back(tr);
  endfunction
  
  function write_clr_data( input fifo_clear_sequence_item tr);
      clr_que.push_back(tr);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
      //fifo_write_sequence_item exp_tr;
      int exp_tr;
      fifo_read_sequence_item act_tr;
      fifo_clear_sequence_item clr_tr;
    forever begin
      #10
      
      clr_tr = clr_que.pop_front();
      if(clr_tr.clear==1) begin
        exp_que.delete();
        act_que.delete();
        `uvm_info(get_type_name(), "CLEARED", UVM_LOW)
      end
      if(act_que.size() > 0)
      begin
        act_tr = act_que.pop_front();
        exp_tr = exp_que.pop_front();
        if (act_tr.dout == exp_tr) begin
          `uvm_info(get_type_name(), $sformatf("MATCHED exp=%x act=%x",exp_tr,act_tr.dout), UVM_LOW)
        end else begin
          `uvm_error(get_type_name(),$sformatf("MISMATCH exp=%x act=%x",exp_tr,act_tr.dout))
        end
      end 
    end
  endtask

  
endclass



/*class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(fifo_scoreboard)


  uvm_tlm_analysis_fifo #(fifo_write_sequence_item) fifo_wr;
  uvm_tlm_analysis_fifo #(fifo_read_sequence_item) fifo_rd;

  fifo_write_sequence_item wr_data;
  fifo_read_sequence_item rd_data;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    fifo_wr = new("fifo_wr", this);
    fifo_rd = new("fifo_rd", this);
  endfunction

  task run_phase(uvm_phase phase);
	forever begin
   // fork
      begin
        fifo_wr.get(wr_data);

        `uvm_info("SCORE_BOARD", "write data", UVM_LOW)

        wr_data.print();
        check_data();
      end
      /*begin
        fifo_rd.get(rd_data);

        `uvm_info("SCORE_BOARD", "READ data", UVM_LOW)

        rd_data.print();

        //check_data();

      end

    //join
    end
  endtask

  task check_data();
    fifo_rd.get(rd_data);
    rd_data.print();
    if (wr_data.din == rd_data.dout) `uvm_info("SB", $sformatf("DATA is  MATCHED SUCCESSFULLY wr=%x rd=%x",wr_data.din,rd_data.dout), UVM_MEDIUM)
      else `uvm_error("SB", $sformatf("DATA COMAPRISTION FAILED wr=%x rd=%x",wr_data.din,rd_data.dout))

   endtask

endclass*/
 
