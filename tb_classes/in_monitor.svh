virtual class in_monitor extends uvm_monitor;
  `uvm_component_utils(in_monitor)
  
  virtual port_in_if bfm;
  uvm_analysis_port #(packet) ap;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);    
    if (!uvm_config_db #(virtual port_in_if)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR", "Failed to get VIF");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    forever begin : monitor_block
      @(vif.get_status);
      fork
        get_input();
      join_none
    end
  endtask : run_phase
  
  pure virtual task monitor_task();
endclass : in_monitor
