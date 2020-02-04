class virtual_sequence_mem_reconfig extends virtual_random_sequence;
  `uvm_object_utils(virtual_sequence_mem_reconfig)
  
  function new (string name = "virtual_sequence_mem_reconfig");
    super.new(name);
  endfunction : new
  
  task body();    
    super.body();
    
    `uvm_do_on_with(rm_h, mem_sqr, { mem_port == 1; mem_addr == 8'hc1; });    
    `uvm_do_on_with(rp_h, pack_sqr, { valid_addresses[0] == cfg_addr[0]; 
                                      valid_addresses[1] == 8'hc1; 
                                      valid_addresses[2] == cfg_addr[2]; 
                                      valid_addresses[3] == cfg_addr[3];
                                    });
  endtask : body
endclass : virtual_sequence_mem_reconfig
