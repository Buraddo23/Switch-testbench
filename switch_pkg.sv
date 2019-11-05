package switch_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //`include "sif_monitor_config.svh"
  `include "agent_config.svh"
  typedef agent_config #(virtual port_in_if)   in_agent_config;
  typedef agent_config #(virtual mem_if)      mem_agent_config;
  typedef agent_config #(virtual port_out_if) out_agent_config;
  `include "env_config.svh"
  
  `include "packet.svh"
  `include "random_sequence.svh"
  
  typedef uvm_sequencer #(packet) packet_sequencer;  
  `include "switch_driver.svh"
  `include "in_driver.svh"
  `include "mem_driver.svh"
  `include "out_driver.svh"
  //`include "switch_monitor.svh"

  `include "in_agent.svh"
  `include "mem_agent.svh"
  `include "out_agent.svh"
  //`include "scoreboard.svh"
  //`include "coverage.svh"
  `include "env.svh"
  
  `include "switch_test.svh"
endpackage : switch_pkg
