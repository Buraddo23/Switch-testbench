interface mem_if(input bit clk);
  logic       enable;
  logic       write;
  logic [1:0] address;
  logic [7:0] data;

  clocking driver_cb @(posedge clk);
    output enable;
    output write;
    output address;
    output data;
  endclocking : driver_cb
  
  clocking monitor_cb @(posedge clk);
    input enable;
    input write;
    input address;
    input data;
  endclocking : monitor_cb
  
  task set_mem_addr(input bit       en,
                    input bit       wr,
                    input bit [1:0] addr,
                    input bit [7:0] dat
                   );
    @(driver_cb);
    enable  = en;
    write   = wr;
    address = addr;
    data    = dat;
  endtask : set_mem_addr
  
  task get_mem_addr(output bit       en,
                    output bit       wr,
                    output bit [1:0] addr,
                    output bit [7:0] dat
                   );
    @(monitor_cb);
    en   = enable;
    wr   = write;
    addr = address;
    dat  = data;
  endtask : get_mem_addr
endinterface : mem_if
