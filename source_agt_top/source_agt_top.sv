class source_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(source_agt_top)
    
      	 source_agent agnth[];
	 router_env_config r_cfg;
	 source_agent_config s_cfg[];
// Standard UVM Methods:
	extern function new(string name = "source_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);
  endclass
//-----------------  constructor new method  -------------------//
    	function source_agt_top::new(string name = "source_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	function void source_agt_top::build_phase(uvm_phase phase);
     		super.build_phase(phase);
if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",r_cfg))
		`uvm_fatal("source_agt_top","getting failed")
   		agnth=new[r_cfg.no_of_sagts];
		foreach(agnth[i])
			begin
		s_cfg=new[r_cfg.no_of_sagts];
   		agnth=new[r_cfg.no_of_sagts];
			s_cfg[i]=source_agent_config::type_id::create($sformatf("s_cfg[%0d]",i));
			s_cfg[i]=r_cfg.src_agent_cfg[i];
			agnth[i]=source_agent::type_id::create($sformatf("agnth[%0d]",i),this);

		
			uvm_config_db#(source_agent_config)::set(this,$sformatf("agnth[%0d]*",i),"source_agent_config",r_cfg.src_agent_cfg[i]);
			end
	endfunction
