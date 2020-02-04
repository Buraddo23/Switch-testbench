/*class reconfig_test extends random_test;
  `uvm_component_utils(reconfig_test);
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
        
    set_type_override_by_type(virtual_random_sequence::get_type(), virtual_sequence_mem_reconfig::get_type());
  endfunction : build_phase
endclass : reconfig_test*/

class reconfig_test extends switch_test;
  `uvm_component_utils(reconfig_test);
  
  virtual_sequence_mem_reconfig vsmr_h;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
        
    vsmr_h = virtual_sequence_mem_reconfig::type_id::create("vsmr_h", this);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    vsmr_h.mem_sqr  = env_h.mem_agent_h.sequencer_h;
    vsmr_h.pack_sqr = env_h.in_agent_h.sequencer_h;
  endfunction : connect_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    if(!vsmr_h.randomize()) `uvm_error("VIRTUAL SEQUENCE", "Randomization failed");
    vsmr_h.start(null);
    phase.drop_objection(this);
  endtask : run_phase
endclass : reconfig_test
