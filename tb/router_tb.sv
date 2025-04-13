class router_tb extends uvm_env;
        
     	`uvm_component_utils(router_tb)

	
	source_agt_top sagt_top;
	destination_agt_top dagt_top;
	
	router_virtual_sequencer v_seqrh;
	
        router_env_config m_cfg;
	router_scoreboard sb;
//	bit[1:0]addr;


            

extern function new(string name = "router_tb", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);


endclass: router_tb
	
	function router_tb::new(string name = "router_tb", uvm_component parent);
		super.new(name,parent);
	endfunction


        	function void router_tb::build_phase(uvm_phase phase);
			super.build_phase(phase);
			 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
				`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
			sagt_top=source_agt_top::type_id::create("sagt_top",this);
			dagt_top=destination_agt_top::type_id::create("dagt_top",this);
			v_seqrh=router_virtual_sequencer::type_id::create("v_seqrh",this);
			sb=router_scoreboard::type_id::create("sb",this);
			
		endfunction

   		function void router_tb::connect_phase(uvm_phase phase);
	//	if(m_cfg.has_source)
	//	begin
		for(int i=0;i<m_cfg.no_of_sagts;i++)
		v_seqrh.s_seqrh[i] = sagt_top.agnth[i].seqrh;
	//	end
	//	if(m_cfg.has_destination)
	//	begin
		for(int i=0;i<m_cfg.no_of_dagts;i++)
		v_seqrh.d_seqrh[i] = dagt_top.agnth[i].seqrh;
	//	end

			foreach(sagt_top.agnth[i])
					sagt_top.agnth[i].monh.monitor_port.connect(sb.src_fifo[0].analysis_export);	
				foreach(dagt_top.agnth[i])
					begin
			//		if(!uvm_config_db#(bit[1:0])::get(this,"","addr",addr))
			//			`uvm_fatal("Router_tb","getting failed")
					 dagt_top.agnth[i].monh.monitor_port.connect(sb.des_fifo[i].analysis_export);	
					end
		endfunction
