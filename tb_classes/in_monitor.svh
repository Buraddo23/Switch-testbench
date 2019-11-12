class in_monitor extends uvm_monitor;
  `uvm_component_utils(in_monitor)
  
  virtual port_in_if vif;
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
    packet pkt;
  
    super.run_phase(phase);

    forever begin : monitor_block
      byte unsigned bq[$], bytes[];
      @(posedge vif.status);
      while (vif.status) begin
        bq.push_back(vif.data);
        @(vif.monitor_cb);
      end
      bytes = new[bq.size()] (bq);
      
      pkt = packet::type_id::create("pkt");
      pkt.unpack_bytes(bytes);
      pkt.print();
      //ap.write(pkt);
    end
  endtask : run_phase
endclass : in_monitor
