

	class destination_driver extends uvm_driver #(destination_xtn);

   // Factory Registration

	`uvm_component_utils(destination_driver)

   	virtual router_if.DES_DRV_MP vif;

        destination_agent_config m_cfg;





// Standard UVM Methods:
     	
	extern function new(string name ="destination_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(destination_xtn req);
endclass

//-----------------  constructor new method  -------------------//
 
	 function destination_driver::new (string name ="destination_driver", uvm_component parent);
   	   super.new(name, parent);
 	 endfunction : new

//-----------------  build() phase method  -------------------//
 	function void destination_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(destination_agent_config)::get(this,"","destination_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
 	function void destination_driver::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
        endfunction

//-----------------  run() phase method  -------------------//
	 
	task destination_driver::run_phase(uvm_phase phase);
               	forever 
		begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end
	endtask


//-----------------  task send_to_dut() method  -------------------//


task destination_driver::send_to_dut(destination_xtn req);
while(vif.des_drv.valid_out!==1)
@(vif.des_drv);
repeat(req.delay)
@(vif.des_drv);
vif.des_drv.read_enb<=1'b1;
@(vif.des_drv);
while(vif.des_drv.valid_out!==0)
@(vif.des_drv);
@(vif.des_drv);
vif.des_drv.read_enb<=1'b0;
req.print();

 endtask 
