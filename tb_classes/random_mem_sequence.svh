class random_mem_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(random_mem_sequence)
  
  mem_transaction address_command;
  rand logic [1:0] mem_port;
  rand byte        mem_addr;
  
  function new (string name = "random_sequence");
    super.new(name);
  endfunction : new
  
  task body();
    `uvm_do_with(address_command, { port == mem_port; write == 1; enable == 1; address == mem_addr; })
    `uvm_do_with(address_command, { port == 0; write == 0; enable == 0; address == 0; })
  endtask : body
endclass : random_mem_sequence
