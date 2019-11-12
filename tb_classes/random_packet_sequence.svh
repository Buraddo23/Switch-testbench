class random_packet_sequence extends uvm_sequence #(packet);
  `uvm_object_utils(random_packet_sequence)
  
  packet command;
  
  function new (string name = "random_packet_sequence");
    super.new(name);
  endfunction : new
  
  task body();
    repeat (1) begin : random_loop
      command = packet::type_id::create("command");
      start_item(command);
      assert(command.randomize());
      finish_item(command);
    end : random_loop
  endtask : body
endclass : random_packet_sequence
