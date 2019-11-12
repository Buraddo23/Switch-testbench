class out_driver extends uvm_driver #(packet);
  `uvm_component_utils(out_driver)
  
  virtual port_out_if vif;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual port_out_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Failed to get VIF");
  endfunction : build_phase
  
  task main_phase(uvm_phase phase);
    super.main_phase(phase);

    vif.set_read(1);
  endtask : main_phase
endclass : out_driver
