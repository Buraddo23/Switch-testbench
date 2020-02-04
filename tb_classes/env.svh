class env extends uvm_env;
  `uvm_component_utils(env);
  
  in_agent          in_agent_h;
  mem_agent         mem_agent_h;
  out_agent         out_agent_h[4];
  switch_scoreboard scoreboard_h;
  //switch_coverage   coverage_h;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    env_config       env_config_h;
    in_agent_config  in_config_h;
    mem_agent_config mem_config_h;
    out_agent_config out_config_h[4];
    super.build_phase(phase);
    
    if(!uvm_config_db #(env_config)::get(this, "", "config", env_config_h))
      `uvm_fatal("ENV", "Failed to get config");
      
    in_config_h = new(env_config_h.vif_in);
    uvm_config_db #(in_agent_config)::set(this, "in_agent_h", "config", in_config_h);
    in_agent_h = in_agent::type_id::create("in_agent_h",  this);
    
    mem_config_h = new(env_config_h.vif_mem);
    uvm_config_db #(mem_agent_config)::set(this, "mem_agent_h", "config", mem_config_h);
    mem_agent_h = mem_agent::type_id::create("mem_agent_h", this);
    
    for (int i = 0; i < 4; i++) begin
      string agent_number, agent_name;
      agent_number.itoa(i);
      agent_name = {"out_agent_h", agent_number};

      out_config_h[i] = new(env_config_h.vif_out[i]);
      uvm_config_db #(out_agent_config)::set(this, agent_name, "config", out_config_h[i]);
      out_agent_h[i] = out_agent::type_id::create(agent_name, this);
    end
    
    scoreboard_h = switch_scoreboard::type_id::create("scoreboard_h", this);
    //coverage_h   = switch_coverage  ::type_id::create("coverage_h",   this);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    in_agent_h.    mon_ap.connect(scoreboard_h.ap_in);
    mem_agent_h.   mon_ap.connect(scoreboard_h.ap_mem);
    out_agent_h[0].mon_ap.connect(scoreboard_h.ap_out0);
    out_agent_h[1].mon_ap.connect(scoreboard_h.ap_out1);
    out_agent_h[2].mon_ap.connect(scoreboard_h.ap_out2);
    out_agent_h[3].mon_ap.connect(scoreboard_h.ap_out3);
    //master_agent_h.mon_ap.connect(coverage_h.analysis_export);
  endfunction :connect_phase
endclass : env
