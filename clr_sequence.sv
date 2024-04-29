class clear_sequence extends uvm_sequence #(fifo_clear_sequence_item);

  `uvm_object_utils(clear_sequence)
  
  int unsigned clear_1=20;
  int unsigned clear_2=50;
  function new(string name = "clear_sequence");
    super.new(name);
  endfunction

  
  task body();
    repeat (clear_1) begin
      fifo_clear_sequence_item item;
      item = fifo_clear_sequence_item::type_id::create("item");
      if (!item.randomize()) begin
        `uvm_info("", $sformatf("Random error from seq"), UVM_LOW);
      end
      start_item(item);
      finish_item(item);
    end
    repeat (clear_2) begin
      fifo_clear_sequence_item item;
      item = fifo_clear_sequence_item::type_id::create("item");
      if (!item.randomize()) begin
        `uvm_info("", $sformatf("Random error from seq"), UVM_LOW);
      end
      start_item(item);
      finish_item(item);
    end
  endtask

endclass

