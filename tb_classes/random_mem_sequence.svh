class random_mem_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(random_mem_sequence)
  
  mem_transaction address_command;
  
  function new (string name = "random_sequence");
    super.new(name);
  endfunction : new
  
  task body();
    for(int i = 0; i < 4; i++) begin : random_loop
      `uvm_do_with(address_command, { port == i; })
    end : random_loop
  endtask : body
endclass : random_mem_sequence
