class out_driver extends switch_driver #(virtual port_out_if);
  `uvm_component_utils(out_driver)
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  task main_phase(uvm_phase phase);
    super.main_phase(phase);
    
    //forever begin : cmd_loop
      drive(0);
      vif.wait_for_ready();
      drive(1);
    //end : cmd_loop
  endtask : main_phase
  
  task drive(input logic rd); 
    vif.set_read(rd);
  endtask : drive
endclass : out_driver
