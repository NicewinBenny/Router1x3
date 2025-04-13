class source_agent_config extends uvm_object;


// UVM Factory Registration Macro
`uvm_object_utils(source_agent_config)


virtual router_if vif;
 int no_of_sagts;



uvm_active_passive_enum is_active = UVM_ACTIVE;

static int mon_rcvd_xtn_cnt = 0;
static int drv_data_sent_cnt = 0;


// Standard UVM Methods:
extern function new(string name = "source_agent_config");

endclass: source_agent_config
//-----------------  constructor new method  -------------------//

function source_agent_config::new(string name = "source_agent_config");
  super.new(name);
endfunction
