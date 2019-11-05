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
  
  task wait_for_ready();
    @(ready);
  endtask : wait_for_ready
  
  task get_data(output logic [7:0] dat);
    while (read && ready) begin
      dat = monitor_cb.data;
    end
  endtask : get_data
  
  task set_read(input logic rd);
    driver_cb.read <= rd;
  endtask : set_read
endinterface : port_out_if
