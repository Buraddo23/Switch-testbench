class agent_config #(type if_type);
 if_type vif;

 function new(if_type vif);
    this.vif = vif;
 endfunction : new
endclass : agent_config
