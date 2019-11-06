class in_driver extends uvm_driver #(packet);
  `uvm_component_utils(in_driver)
  
  virtual port_in_if vif;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual port_in_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Failed to get VIF");
  endfunction : build_phase
  
  task main_phase(uvm_phase phase);
    super.main_phase(phase);
    
    forever begin : cmd_loop      
      drive();
    end : cmd_loop
  endtask : main_phase
  
  task drive(); 
    packet pkt;
    byte unsigned bytes[];
     
    seq_item_port.get_next_item(pkt);
    pkt.pack_bytes(bytes);
    pkt.print();
      
    foreach(bytes[i]) begin : iterate_pkt
      vif.set_input(bytes[i], 1);
    end : iterate_pkt
    vif.set_input(0,0);
    seq_item_port.item_done();
  endtask : drive
endclass : in_driver
