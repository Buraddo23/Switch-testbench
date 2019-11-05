interface mem_if(input bit clk);
  logic       enable;
  logic       write;
  logic [1:0] address;
  logic [7:0] data;

  clocking driver_cb @(posedge clk);
    input enable;
    input write;
    input address;
    input data;
  endclocking : driver_cb
  
  task set_mem_addr(input bit [1:0] addr,
             input bit [7:0] dat
            );
    enable = 1'b1;
    write  = 1'b1;
    address = addr;
    data    = dat;
    @(driver_cb);
    enable  = 1'b0;
    write   = 1'b0;
  endtask : set_mem_addr
endinterface : mem_if
