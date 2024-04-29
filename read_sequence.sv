class read_sequence extends uvm_sequence #(fifo_read_sequence_item);

  `uvm_object_utils(read_sequence)
   int unsigned read_1=20;
   int unsigned read_2=50;
  function new(string name = "read_sequence");
    super.new(name);
    void'($value$plusargs("read_1=%0d", read_1));
    void'($value$plusargs("read_2=%0d", read_2));
  endfunction

  virtual task body();
    repeat (read_1) begin
      fifo_read_sequence_item_less_read read_item;
      read_item = fifo_read_sequence_item_less_read::type_id::create("read_item");
      if (!read_item.randomize()) begin
        `uvm_info("", $sformatf("Random error from seq"), UVM_LOW);
      end
      start_item(read_item);
      finish_item(read_item);
    end

    repeat (read_2) begin
      fifo_read_sequence_item_more_read read_item;
      read_item = fifo_read_sequence_item_more_read::type_id::create("read_item");
      if (!read_item.randomize()) begin
        `uvm_info("", $sformatf("Random error from seq"), UVM_LOW);
      end
      start_item(read_item);
      finish_item(read_item);
    end
    
  endtask
 
 virtual task post_body();
  `uvm_info(get_type_name(), $sformatf("Number of read_1: %0d", read_1), UVM_LOW);
  `uvm_info(get_type_name(), $sformatf("Number of read_2: %0d", read_2), UVM_LOW);
 endtask

endclass
