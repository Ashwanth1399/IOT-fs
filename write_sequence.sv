class write_sequence extends uvm_sequence #(fifo_write_sequence_item);

  `uvm_object_utils(write_sequence)
  
  int unsigned write_1=50;  
  int unsigned write_2=20;

function new(string name = "write_sequence");
    super.new(name);
    void'($value$plusargs("write_1=%0d", write_1));
    void'($value$plusargs("write_2=%0d",write_2));
  endfunction

  
  task body();
   repeat (write_1) begin
      fifo_write_sequence_item_more_write write_item;
      write_item = fifo_write_sequence_item_more_write::type_id::create("write_item");
      if (!write_item.randomize()) begin
        `uvm_info("", $sformatf("Random error from seq"), UVM_LOW);
      end
      start_item(write_item);
      finish_item(write_item);
    end
    repeat (write_2) begin
      fifo_write_sequence_item_less_write write_item;
      write_item = fifo_write_sequence_item_less_write::type_id::create("write_item");
      if (!write_item.randomize()) begin
        `uvm_info("", $sformatf("Random error from seq"), UVM_LOW);
      end
      start_item(write_item);
      finish_item(write_item);
    end

  endtask


 virtual task post_body();
  `uvm_info(get_type_name(), $sformatf("Number of write_1: %0d", write_1), UVM_LOW);
   `uvm_info(get_type_name(), $sformatf("Number of write_2: %0d", write_2), UVM_LOW);
 endtask

endclass




