class packet extends uvm_sequence_item;
  rand byte da;
  rand byte sa;
  rand byte length;
  rand byte data[];
       byte fcs;

  `uvm_object_utils_begin(packet);
    `uvm_field_int(da, UVM_DEFAULT)
    `uvm_field_int(sa, UVM_DEFAULT)
    `uvm_field_int(length, UVM_DEFAULT)
    `uvm_field_array_int(data, UVM_DEFAULT)
    `uvm_field_int(fcs, UVM_DEFAULT)
  `uvm_object_utils_end
       
  constraint size {
    length == data.size;
  }
  
  function new(string name = "");
    super.new(name);
  endfunction : new
  
  virtual function byte get_fcs;
    return da ^ sa ^ length ^ data.xor();
  endfunction : get_fcs
  
  function void post_randomize();
    fcs = get_fcs;
  endfunction : post_randomize
  
  function void do_pack(uvm_packer packer);
    super.do_pack(packer);
    packer.pack_field_int(da, $bits(da));
    packer.pack_field_int(sa, $bits(sa));
    packer.pack_field_int(length, $bits(length));
    foreach(data[i])
      packer.pack_field_int(data[i], $bits(data[i]));
    packer.pack_field_int(fcs, $bits(fcs));
  endfunction : do_pack
  
  function void do_unpack(uvm_packer packer);
    super.do_unpack(packer);
    da = packer.unpack_field_int($bits(da));
    sa = packer.unpack_field_int($bits(sa));
    length = packer.unpack_field_int($bits(length));
    data.delete();
    data = new[length];
    foreach(data[i])
      data[i] = packer.unpack_field_int(8);
    fcs = packer.unpack_field_int($bits(fcs));
  endfunction : do_unpack
endclass : packet
