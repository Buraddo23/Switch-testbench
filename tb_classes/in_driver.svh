class in_driver extends switch_driver #(virtual port_in_if);
  `uvm_component_utils(in_driver)
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
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
