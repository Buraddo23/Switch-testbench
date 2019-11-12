interface port_in_if(input bit clk);
  logic [7:0] data;
  //logic busy;
  logic status;
  
  clocking driver_cb @(posedge clk);
    output data;
    //output busy;
    output status;
  endclocking : driver_cb
  
  clocking monitor_cb @(posedge clk);
    input data;
    input status;
  endclocking : monitor_cb
  
  //task get_busy(output logic bs);
  //  bs = busy;
  //endtask : get_busy
  
  task set_input(input logic [7:0] dat,
                 input logic       cm
                );
    @(driver_cb);
    data   = dat;
    status = cm;
  endtask : set_input
  
  function bit get_status();
    return status;
  endfunction : get_status
  
  function logic [7:0] get_input();
    return data;
  endfunction : get_input
endinterface : port_in_if
