class out_monitor extends uvm_monitor;
  `uvm_component_utils(out_monitor)
  
  virtual port_out_if vif;
  uvm_analysis_port #(packet) ap;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);    
    if (!uvm_config_db #(virtual port_out_if)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR", "Failed to get VIF");
  endfunction : build_phase
  
  task main_phase(uvm_phase phase);
    packet pkt;
  
    super.main_phase(phase);

    forever begin : monitor_block
      byte unsigned bq[$], bytes[];
      @(posedge (vif.ready && vif.read));
      phase.raise_objection(this);
      @(vif.monitor_cb);
      @(vif.monitor_cb);
      while (vif.ready && vif.read) begin
        bq.push_back(vif.data);
        @(vif.monitor_cb);
      end
      if(bq.size()) begin
        bytes = new[bq.size()] (bq);
        
        pkt = packet::type_id::create("pkt");
        pkt.unpack_bytes(bytes);
        pkt.print();
        //ap.write(pkt);
      end
      phase.drop_objection(this);
    end
  endtask : main_phase
endclass : out_monitor
