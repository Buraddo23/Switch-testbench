virtual class switch_test extends uvm_test;
  `uvm_component_utils(switch_test);
  
  env env_h;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    virtual mem_if      vif_mem;
    virtual port_in_if  vif_in;
    virtual port_out_if vif_out[4];
            env_config  env_config_h;
    
    super.build_phase(phase);
    
    if(!uvm_config_db #(virtual mem_if)     ::get(this, "", "vif_mem" , vif_mem))
      `uvm_fatal("TEST", "Failed to get VIF_MEM");
    if(!uvm_config_db #(virtual port_in_if) ::get(this, "", "vif_in"  , vif_in))
      `uvm_fatal("TEST", "Failed to get VIF_IN");
    if(!uvm_config_db #(virtual port_out_if)::get(this, "", "vif_out0", vif_out[0]))
      `uvm_fatal("TEST", "Failed to get VIF_OUT0");
    if(!uvm_config_db #(virtual port_out_if)::get(this, "", "vif_out1", vif_out[1]))
      `uvm_fatal("TEST", "Failed to get VIF_OUT1");
    if(!uvm_config_db #(virtual port_out_if)::get(this, "", "vif_out2", vif_out[2]))
      `uvm_fatal("TEST", "Failed to get VIF_OUT2");
    if(!uvm_config_db #(virtual port_out_if)::get(this, "", "vif_out3", vif_out[3]))
      `uvm_fatal("TEST", "Failed to get VIF_OUT3");
      
    env_config_h = new(vif_mem, vif_in, vif_out[0], vif_out[1], vif_out[2], vif_out[3]);
    uvm_config_db #(env_config)::set(this, "env_h", "config", env_config_h);
    
    env_h = env::type_id::create("env_h", this);
  endfunction : build_phase
endclass : switch_test
