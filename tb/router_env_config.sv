class router_env_config extends uvm_object;


source_agent_config src_agent_cfg[];
destination_agent_config des_agent_cfg[];
int no_of_sagts;
int no_of_dagts;
int has_source=1;
int has_destination=1;

`uvm_object_utils(router_env_config)

extern function new(string name="router_env_config");
endclass:router_env_config

function router_env_config::new(string name="router_env_config");
super.new(name);
endfunction
