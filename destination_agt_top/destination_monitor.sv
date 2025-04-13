class destination_monitor extends uvm_monitor;

  // Factory Registration
	`uvm_component_utils(destination_monitor)

   	virtual router_if.DES_MON_MP vif;

        destination_agent_config m_cfg;
	//int busy=1;
	//int ending;

   uvm_analysis_port #(destination_xtn) monitor_port;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "destination_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
///extern function void phase_ready_to_end(uvm_phase phase);
//extern function void report_phase(uvm_phase phase);

endclass




//-----------------  constructor new method  -------------------//
 
 function destination_monitor::new(string name = "destination_monitor", uvm_component parent);
    super.new(name, parent);

    monitor_port = new("monitor_port", this);
  endfunction : new

//-----------------  build() phase method  -------------------//
 
	function void destination_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(destination_agent_config)::get(this,"","destination_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
        endfunction

//-----------------  connect() phase method  -------------------//
 	function void destination_monitor::connect_phase(uvm_phase phase);
      vif = m_cfg.vif;
        endfunction

task destination_monitor::run_phase(uvm_phase phase);
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


task destination_monitor::collect_data();
destination_xtn xtn;
xtn=destination_xtn::type_id::create("xtn");
while(vif.des_mon.read_enb!==1)
@(vif.des_mon);
@(vif.des_mon);
xtn.header=vif.des_mon.data_out;
xtn.payload=new[xtn.header[7:2]];
@(vif.des_mon);
foreach(xtn.payload[i])
begin
xtn.payload[i]=vif.des_mon.data_out;
@(vif.des_mon);
end
xtn.parity=vif.des_mon.data_out;
xtn.print;
monitor_port.write(xtn);
@(vif.des_mon);
//@(vif.des_mon);




endtask

/*function void destination_monitor::phase_ready_to_end(uvm_phase phase);
if(phase.get_name=="run")
begin
ending=1;
if(busy)
phase.raise_objection(this);
end
endfunction*/


