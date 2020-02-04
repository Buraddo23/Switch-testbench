class virtual_random_sequence extends virtual_sequence_base;
  `uvm_object_utils(virtual_random_sequence)

  random_mem_sequence    rm_h;
  random_packet_sequence rp_h;
  
  rand byte cfg_addr[4];
  
  function new (string name = "virtual_random_sequence");
    super.new(name);
  endfunction : new
  
  task pre_body();
    super.pre_body();
    
    rm_h = random_mem_sequence   ::type_id::create("rm_h");
    rp_h = random_packet_sequence::type_id::create("rp_h");
  endtask : pre_body
  
  task body();    
    for(int i = 0; i < 4; i++) begin
      `uvm_do_on_with(rm_h, mem_sqr, { mem_port == i; mem_addr == cfg_addr[i]; });
    end
    
    `uvm_do_on_with(rp_h, pack_sqr, { valid_addresses[0] == cfg_addr[0]; 
                                      valid_addresses[1] == cfg_addr[1]; 
                                      valid_addresses[2] == cfg_addr[2]; 
                                      valid_addresses[3] == cfg_addr[3];
                                    });
  endtask : body
endclass : virtual_random_sequence
