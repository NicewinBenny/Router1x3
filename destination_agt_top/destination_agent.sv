
 	class destination_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(destination_agent)
        destination_agent_config m_cfg;
       
	destination_monitor monh;
	destination_sequencer seqrh;
	destination_driver drvh;



// Standard UVM Methods:
  extern function new(string name = "destination_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
 // extern task run_phase(uvm_phase phase);

endclass : destination_agent
//-----------------  constructor new method  -------------------//

       function destination_agent::new(string name = "destination_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//

function void destination_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
        if(!uvm_config_db #(destination_agent_config)::get(this,"","destination_agent_config",m_cfg))
		`uvm_fatal("agent","getting failed") 
	        monh=destination_monitor::type_id::create("monh",this);	
        if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=destination_driver::type_id::create("drvh",this);
		seqrh=destination_sequencer::type_id::create("seqrh",this);
		end
	endfunction

      
//-----------------  connect() phase method  -------------------//
      
function void destination_agent::connect_phase(uvm_phase phase);
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
	endfunction

/*task destination_agent::run_phase(uvm_phase phase);
uvm_top.print_topology;
endtask*/
   

