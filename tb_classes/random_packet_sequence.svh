class random_packet_sequence extends uvm_sequence #(packet);
  `uvm_object_utils(random_packet_sequence)
  
  packet command;
  rand int  cnt;
  rand byte valid_addresses[4];
  
  constraint c1 {
    cnt inside {[2:10]};
  }
  
  function new (string name = "random_packet_sequence");
    super.new(name);
  endfunction : new
  
  task body();
    repeat (cnt) begin : random_loop
      `uvm_do_with(
        command, {
          da inside {valid_addresses};
        }
      )
    end : random_loop
  endtask : body
endclass : random_packet_sequence
