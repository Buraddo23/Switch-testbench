class virtual_sequence_base extends uvm_sequence;
  `uvm_object_utils(virtual_sequence_base)
  
  mem_sequencer    mem_sqr;
  packet_sequencer pack_sqr;
  
  function new (string name = "virtual_sequence_base");
    super.new(name);
  endfunction : new
endclass : virtual_sequence_base
