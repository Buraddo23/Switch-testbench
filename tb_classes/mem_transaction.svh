class mem_transaction extends uvm_sequence_item;
  `uvm_object_utils(mem_transaction);

  rand logic [1:0] port;
  rand byte        address;
  
  function new(string name = "");
    super.new(name);
  endfunction : new
endclass : mem_transaction
