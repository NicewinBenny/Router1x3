
class source_monitor extends uvm_monitor;

	`uvm_component_utils(source_monitor)

   	virtual router_if.SRC_MON_MP vif;

        source_agent_config m_cfg;

  	uvm_analysis_port #(source_xtn) monitor_port;
//int busy=1;
//int ending;


// Standard UVM Methods:
extern function new(string name = "source_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
//extern function void phase_ready_to_end(uvm_phase phase);

endclass 
//-----------------  constructor new method  -------------------//
	function source_monitor::new(string name = "source_monitor", uvm_component parent);
		super.new(name,parent);
	 		monitor_port = new("monitor_port", this);

  	endfunction

//-----------------  build() phase method  -------------------//
 	function void source_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	 if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
	
 	function void source_monitor::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
        endfunction


//-----------------  run() phase method  -------------------//
	
task source_monitor::run_phase(uvm_phase phase);
        forever
begin
              collect_data();

/*if(ending)
begin
busy=0;
phase.drop_objection(this);
end*/

end     
       endtask

       task source_monitor::collect_data();
         source_xtn xtn;
//	@(vif.src_mon);
	 xtn= source_xtn::type_id::create("xtn");
//	xtn.print;
	while(vif.src_mon.pkt_valid!==1)
	@(vif.src_mon);
	while(vif.src_mon.busy!==0)
	@(vif.src_mon);
	xtn.header=vif.src_mon.data_in;
	xtn.payload=new[xtn.header[7:2]];
	@(vif.src_mon);
	for(int i=0; i<xtn.header[7:2]; i++)
	begin
	while(vif.src_mon.busy!==0)
	@(vif.src_mon);
	xtn.payload[i]=vif.src_mon.data_in;
	@(vif.src_mon);
	end
	xtn.parity=vif.src_mon.data_in;
//	xtn.print();

	repeat(2)
	@(vif.src_mon);
	xtn.error=vif.src_mon.error;
	xtn.print;
monitor_port.write(xtn);
//	@(vif.src_mon);
//	@(vif.src_mon);


	endtask

/*function void source_monitor::phase_ready_to_end(uvm_phase phase);
if(phase.get_name=="run")
begin
ending=1;
if(busy)
phase.raise_objection(this);
end
endfunction*/

/*// UVM report_phase
  function void source_monitor::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: SOURCE Monitor Collected %0d Transactions", m_cfg.mon_rcvd_xtn_cnt), UVM_LOW)
  endfunction */
