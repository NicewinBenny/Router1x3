
class destination_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(destination_agt_top)
    
   // Create the agent handle
      	 destination_agent agnth[];
	 router_env_config r_cfg;
	destination_agent_config d_cfg[];
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "destination_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);
  endclass
//-----------------  constructor new method  -------------------//
   // Define Constructor new() function
   	function destination_agt_top::new(string name = "destination_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	function void destination_agt_top::build_phase(uvm_phase phase);
     		super.build_phase(phase);
if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",r_cfg))
		`uvm_fatal("destination_agt_top","getting failed")
		d_cfg=new[r_cfg.no_of_dagts];
   		agnth=new[r_cfg.no_of_dagts];
		foreach(agnth[i])
			begin
			d_cfg[i]=destination_agent_config::type_id::create($sformatf("d_cfg[%0d]",i));
			d_cfg[i]=r_cfg.des_agent_cfg[i];
			agnth[i]=destination_agent::type_id::create($sformatf("agnth[%0d]",i),this);

			uvm_config_db#(destination_agent_config)::set(this,$sformatf("agnth[%0d]*",i),"destination_agent_config",r_cfg.des_agent_cfg[i]);
			end
	endfunction

