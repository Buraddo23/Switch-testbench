class random_test extends switch_test;
  `uvm_component_utils(random_test);
  
  virtual_random_sequence vrs_h;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
        
    vrs_h = virtual_random_sequence::type_id::create("vrs_h", this);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    vrs_h.mem_sqr  = env_h.mem_agent_h.sequencer_h;
    vrs_h.pack_sqr = env_h.in_agent_h.sequencer_h;
  endfunction : connect_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    if(!vrs_h.randomize()) `uvm_error("VIRTUAL SEQUENCE", "Randomization failed");
    vrs_h.start(null);
    phase.drop_objection(this);
  endtask : run_phase
endclass : random_test
