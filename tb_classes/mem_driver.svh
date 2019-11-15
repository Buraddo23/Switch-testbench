class mem_driver extends uvm_driver #(mem_transaction);
  `uvm_component_utils(mem_driver)
  
  virtual mem_if vif;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual mem_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Failed to get VIF");
  endfunction : build_phase
  
  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    
    forever begin
      mem_transaction cmd;
      
      seq_item_port.get_next_item(cmd);
      vif.set_mem_addr(cmd.enable, cmd.write, cmd.port, cmd.address);
      seq_item_port.item_done();
    end
  endtask : configure_phase
endclass : mem_driver
