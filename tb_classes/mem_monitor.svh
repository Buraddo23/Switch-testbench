class mem_monitor extends uvm_monitor;
  `uvm_component_utils(mem_monitor)
  
  virtual mem_if vif;
  uvm_analysis_port #(mem_transaction) ap;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);    
    if (!uvm_config_db #(virtual mem_if)::get(this, "", "vif", vif))
      `uvm_fatal("MEMORY MONITOR", "Failed to get VIF");
    
    ap = new("ap", this);
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    mem_transaction memory;
    super.run_phase(phase);
    
    forever begin : monitor_block
      memory = mem_transaction::type_id::create("memory");
      
      vif.get_mem_addr(memory.enable, memory.write, memory.port, memory.address);
      if(memory.enable && memory.write) begin
        `uvm_info("MEMORY MONITOR", {"Address in memory: ", memory.convert2string()}, UVM_HIGH);
        ap.write(memory);
      end
    end
  endtask : run_phase
endclass : mem_monitor
