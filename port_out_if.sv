interface port_out_if(input bit clk);
  logic [7:0] data;
  logic ready;
  logic read;

  clocking driver_cb @(posedge clk);
    input  data;
    input  ready;
    output read;
  endclocking : driver_cb
  
  clocking monitor_cb @(posedge clk);
    input data;
    input ready;
    input read;
  endclocking : monitor_cb
  
  task set_read(input logic rd);
    driver_cb.read <= rd;
  endtask : set_read
endinterface : port_out_if
