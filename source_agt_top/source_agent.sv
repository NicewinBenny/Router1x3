class source_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(source_agent)

        source_agent_config m_cfg;
       
  	source_monitor monh;
	source_sequencer seqrh;
	source_driver drvh;

// Standard UVM Methods:
  extern function new(string name = "source_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
 // extern task run_phase(uvm_phase phase);


endclass : source_agent

//-----------------  constructor new method  -------------------//

function source_agent::new(string name = "source_agent", uvm_component parent = null);
         super.new(name, parent);
       endfunction
     

//-----------------  build() phase method  -------------------//

function void source_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
        if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",m_cfg))
		`uvm_fatal("agent","getting failed") 
	        monh=source_monitor::type_id::create("monh",this);	
        if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=source_driver::type_id::create("drvh",this);
		seqrh=source_sequencer::type_id::create("seqrh",this);
		end
	endfunction

      
//-----------------  connect() phase method  -------------------//
      
function void source_agent::connect_phase(uvm_phase phase);
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
	endfunction

/*task source_agent::run_phase(uvm_phase phase);
uvm_top.print_topology;
endtask*/
   
