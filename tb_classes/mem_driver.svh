class mem_driver extends switch_driver #(virtual mem_if);
  `uvm_component_utils(mem_driver)
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    phase.raise_objection(this);
    vif.set_mem_addr(2'b00, 8'he4);
    vif.set_mem_addr(2'b01, 8'h45);
    vif.set_mem_addr(2'b10, 8'h23);
    vif.set_mem_addr(2'b11, 8'h01);
    phase.drop_objection(this);
  endtask : configure_phase
endclass : mem_driver
