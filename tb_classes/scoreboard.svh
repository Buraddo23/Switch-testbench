`uvm_analysis_imp_decl(_in)
`uvm_analysis_imp_decl(_mem)
`uvm_analysis_imp_decl(_out0)
`uvm_analysis_imp_decl(_out1)
`uvm_analysis_imp_decl(_out2)
`uvm_analysis_imp_decl(_out3)

class switch_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(switch_scoreboard)
  
  uvm_analysis_imp_in   #(packet,          switch_scoreboard) ap_in;
  uvm_analysis_imp_mem  #(mem_transaction, switch_scoreboard) ap_mem;
  uvm_analysis_imp_out0 #(packet,          switch_scoreboard) ap_out0;
  uvm_analysis_imp_out1 #(packet,          switch_scoreboard) ap_out1;
  uvm_analysis_imp_out2 #(packet,          switch_scoreboard) ap_out2;
  uvm_analysis_imp_out3 #(packet,          switch_scoreboard) ap_out3;
  
  byte   mem_tr[4];
  packet in_tr[$];
  packet out_tr[4][$];
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_in   = new("ap_in",  this);
    ap_mem  = new("ap_mem", this);
    ap_out0 = new("ap_out0", this);
    ap_out1 = new("ap_out1", this);
    ap_out2 = new("ap_out2", this);
    ap_out3 = new("ap_out3", this);
  endfunction : build_phase  
  
  function void write_in(packet t);
    `uvm_info("SCOREBOARD", {"Received: ", t.convert2string()}, UVM_HIGH);
    in_tr.push_back(t);
  endfunction : write_in
  
  function void write_mem(mem_transaction t);
    `uvm_info("SCOREBOARD", {"Received: ", t.convert2string()}, UVM_HIGH);
    
    if (t.enable && t.write) begin
      mem_tr[t.port] = t.address;
    end
  endfunction : write_mem
  
  function void write_out0(packet t);
    write_out(0, t);
  endfunction : write_out0
  
  function void write_out1(packet t);
    write_out(1, t);
  endfunction : write_out1
  
  function void write_out2(packet t);
    write_out(2, t);
  endfunction : write_out2
  
  function void write_out3(packet t);
    write_out(3, t);
  endfunction : write_out3
  
  function void write_out(int i, packet t);
    int temp;
    `uvm_info("SCOREBOARD", {"Received: ", t.convert2string()}, UVM_HIGH)
    
    if (mem_tr[i] != t.da) begin
      `uvm_error("SCOREBOARD", "FAIL: Destination adress is not the same as port adress.")
      return;
    end
    temp = int'(in_tr.find_first_index(p) with (p.da == mem_tr[i]));
    if (!in_tr[temp].compare(t)) begin
      `uvm_error("SCOREBOARD", "FAIL: Packets received by Input and Output are not the same")
      return;
    end
    in_tr.delete(temp);
    `uvm_info("SCOREBOARD", {"PASS: Packet:", t.convert2string}, UVM_MEDIUM)
  endfunction : write_out
endclass : switch_scoreboard
