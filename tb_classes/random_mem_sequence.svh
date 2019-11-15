class random_mem_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(random_mem_sequence)
  
  mem_transaction address_command;
  
  function new (string name = "random_sequence");
    super.new(name);
  endfunction : new
  
  task body();
    for(int i = 0; i < 4; i++) begin : random_loop
      `uvm_do_with(address_command, { port == i; write == 1; enable == 1; })
    end : random_loop
    `uvm_do_with(address_command, { enable == 0; write == 0; port == 0; address == 0; })
  endtask : body
endclass : random_mem_sequence
