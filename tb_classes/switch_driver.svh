virtual class switch_driver #(type if_type) extends uvm_driver #(packet);
  `uvm_component_param_utils(switch_driver #(if_type))
  
  if_type vif;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(if_type)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Failed to get VIF");
  endfunction : build_phase
  
  /*task shutdown_phase(uvm_phase phase);
    super.shutdown_phase(phase);
    
    phase.raise_objection(this);
    @(bfm.driver_cb);
    phase.drop_objection(this);
  endtask : shutdown_phase*/
endclass : switch_driver
