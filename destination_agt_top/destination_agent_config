
class destination_agent_config extends uvm_object;


`uvm_object_utils(destination_agent_config)
int no_of_dagts;
virtual router_if vif;

static int mon_rcvd_xtn_cnt = 0;

static int drv_data_sent_cnt = 0;
uvm_active_passive_enum is_active = UVM_ACTIVE;



extern function new(string name = "destination_agent_config");

endclass: destination_agent_config

function destination_agent_config::new(string name = "destination_agent_config");
  super.new(name);
endfunction
