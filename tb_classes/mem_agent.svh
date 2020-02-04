class mem_agent extends uvm_agent;
  `uvm_component_utils(mem_agent)
  
  mem_sequencer sequencer_h;
  mem_driver    driver_h;
  mem_monitor   monitor_h;
  
  uvm_analysis_port #(mem_transaction) mon_ap;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);   
    mem_agent_config agent_config_h; 
    super.build_phase(phase);
    
    if(!uvm_config_db #(mem_agent_config)::get(this, "", "config", agent_config_h))
      `uvm_fatal("AGENT", "Failed to get config")

    sequencer_h = mem_sequencer::type_id::create("sequencer_h", this);
    driver_h    = mem_driver   ::type_id::create("driver_h",    this);
    monitor_h   = mem_monitor  ::type_id::create("monitor_h",   this);
    
    uvm_config_db #(virtual mem_if)::set(this, "driver_h*", "vif",  agent_config_h.vif);
    uvm_config_db #(virtual mem_if)::set(this, "monitor_h*", "vif", agent_config_h.vif);
    
    mon_ap = new("mon_ap", this);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
    monitor_h.ap.connect(mon_ap);
  endfunction : connect_phase
endclass : mem_agent
