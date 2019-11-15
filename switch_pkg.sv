package switch_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
 
  `include "agent_config.svh"
  typedef agent_config #(virtual port_in_if)   in_agent_config;
  typedef agent_config #(virtual mem_if)      mem_agent_config;
  typedef agent_config #(virtual port_out_if) out_agent_config;
  `include "env_config.svh"
  
  `include "packet.svh"
  `include "mem_transaction.svh"
  
  `include "random_packet_sequence.svh"
  `include "random_mem_sequence.svh"
  
  typedef uvm_sequencer #(packet) packet_sequencer;  
  typedef uvm_sequencer #(mem_transaction) mem_sequencer;
  
  `include "in_driver.svh"
  `include "mem_driver.svh"
  `include "out_driver.svh"
  
  `include "in_monitor.svh"
  `include "mem_monitor.svh"

  `include "in_agent.svh"
  `include "mem_agent.svh"
  `include "out_agent.svh"
  //`include "scoreboard.svh"
  //`include "coverage.svh"
  `include "env.svh"
  
  `include "switch_test.svh"
endpackage : switch_pkg
