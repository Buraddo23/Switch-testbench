class mem_transaction extends uvm_sequence_item;
  rand logic       enable, write;
  rand logic [1:0] port;
  rand byte        address;
  
  `uvm_object_utils_begin(mem_transaction)
    `uvm_field_int(enable,  UVM_DEFAULT)
    `uvm_field_int(write,   UVM_DEFAULT)
    `uvm_field_int(port,    UVM_DEFAULT)
    `uvm_field_int(address, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "");
    super.new(name);
  endfunction : new
endclass : mem_transaction
