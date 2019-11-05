module binding_module(
  output       clk,
  output       reset,
  output       data_status,
  output [7:0] data,
  output       mem_en,
  output       mem_rd_wr,
  output [1:0] mem_add,
  output [7:0] mem_data,
  input  [7:0] port0,
  input  [7:0] port1,
  input  [7:0] port2,
  input  [7:0] port3,
  input        ready_0,
  input        ready_1,
  input        ready_2,
  input        ready_3,
  output       read_0,
  output       read_1,
  output       read_2,
  output       read_3
);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
                     
  mem_if  vif_mem(clk);
  port_in_if vif_in(clk);
  port_out_if vif_out[4](clk);
  
  assign data_status = vif_in.status;
  assign data        = vif_in.data;
  
  assign mem_en    = vif_mem.enable;
  assign mem_rd_wr = vif_mem.write;
  assign mem_add   = vif_mem.address;
  assign mem_data  = vif_mem.data;
  
  assign vif_out[0].data  = port0;
  assign vif_out[0].ready = ready_0;
  assign read_0           = vif_out[0].read;
  
  assign vif_out[1].data  = port1;
  assign vif_out[1].ready = ready_1;
  assign read_1           = vif_out[1].read;
  
  assign vif_out[2].data  = port2;
  assign vif_out[2].ready = ready_2;
  assign read_2           = vif_out[2].read;
  
  assign vif_out[3].data  = port3;
  assign vif_out[3].ready = ready_3;
  assign read_3           = vif_out[3].read;
  
  initial begin
    uvm_config_db #(virtual mem_if)     ::set(null, "*", "vif_mem" , vif_mem);
    uvm_config_db #(virtual port_in_if) ::set(null, "*", "vif_in"  , vif_in);
    uvm_config_db #(virtual port_out_if)::set(null, "*", "vif_out0", vif_out[0]);
    uvm_config_db #(virtual port_out_if)::set(null, "*", "vif_out1", vif_out[1]);
    uvm_config_db #(virtual port_out_if)::set(null, "*", "vif_out2", vif_out[2]);
    uvm_config_db #(virtual port_out_if)::set(null, "*", "vif_out3", vif_out[3]);
  end
endmodule : binding_module
