class env_config;
 virtual mem_if      vif_mem;
 virtual port_in_if  vif_in;
 virtual port_out_if vif_out[4];

 function new(virtual mem_if      vif_mem,
              virtual port_in_if  vif_in,
              virtual port_out_if vif_out0,
              virtual port_out_if vif_out1,
              virtual port_out_if vif_out2,
              virtual port_out_if vif_out3
             );
    this.vif_mem    = vif_mem;
    this.vif_in     = vif_in;
    this.vif_out[0] = vif_out0;
    this.vif_out[1] = vif_out1;
    this.vif_out[2] = vif_out2;
    this.vif_out[3] = vif_out3;
 endfunction : new
endclass : env_config
