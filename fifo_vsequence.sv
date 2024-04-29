class vsequence extends uvm_sequence;

  `uvm_object_utils(vsequence)


  write_sequence w;
  read_sequence  r;
  clear_sequence c;

  `uvm_declare_p_sequencer(vsequencer)

  function new(string name = "");
    super.new(name);
  endfunction

  task body();
    w = write_sequence::type_id::create("w");
    r = read_sequence::type_id::create("r");
    c = clear_sequence::type_id::create("c");
    fork
      w.start(p_sequencer.sqnr1);
      r.start(p_sequencer.sqnr2);
      c.start(p_sequencer.sqnr3);
    join
  endtask
endclass





