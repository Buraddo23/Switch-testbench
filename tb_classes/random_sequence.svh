class random_sequence extends uvm_sequence #(packet);
  `uvm_object_utils(random_sequence)
  
  packet command;
  
  function new (string name = "random_sequence");
    super.new(name);
  endfunction : new
  
  task body();
    repeat (1) begin : random_loop
      command = packet::type_id::create("command");
      start_item(command);
      assert(command.randomize());
      //`uvm_info("RANDOM", $sformatf("random command: %s", command.convert2string), UVM_FULL);
      finish_item(command);
    end : random_loop
  endtask : body
endclass : random_sequence
