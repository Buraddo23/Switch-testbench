`timescale 1ps / 1ps

import uvm_pkg::*;
import switch_pkg::*;
`include "uvm_macros.svh"
`include "switch_macros.svh"
  
`include "binding_module.sv"

module top;
  reg        tb_clk;
  reg        tb_reset;
  wire       tb_data_status;
  wire [7:0] tb_data;
  wire       tb_mem_en;
  wire       tb_mem_rd_wr;
  wire [1:0] tb_mem_add;
  wire [7:0] tb_mem_data;
  wire [7:0] tb_port0;
  wire [7:0] tb_port1;
  wire [7:0] tb_port2;
  wire [7:0] tb_port3;
  wire       tb_ready_0;
  wire       tb_ready_1;
  wire       tb_ready_2;
  wire       tb_ready_3;
  wire       tb_read_0;
  wire       tb_read_1;
  wire       tb_read_2;
  wire       tb_read_3;
  
  switch DUT(.clk(tb_clk),
             .reset(tb_reset),
             .data_status(tb_data_status),
             .data(tb_data),
             .port0(tb_port0),
             .port1(tb_port1),
             .port2(tb_port2),
             .port3(tb_port3),
             .ready_0(tb_ready_0),
             .ready_1(tb_ready_1),
             .ready_2(tb_ready_2),
             .ready_3(tb_ready_3),
             .read_0(tb_read_0),
             .read_1(tb_read_1),
             .read_2(tb_read_2),
             .read_3(tb_read_3),
             .mem_en(tb_mem_en),
             .mem_rd_wr(tb_mem_rd_wr),
             .mem_add(tb_mem_add),
             .mem_data(tb_mem_data)
            );
         
  bind switch binding_module U_switch_assert(.*);
  
  always #10 tb_clk = ~tb_clk;
  
  initial begin
    tb_clk = 1'b0;
    tb_reset = 1'b0;
    run_test();
  end
endmodule : top
