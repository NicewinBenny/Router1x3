
class source_driver extends uvm_driver #(source_xtn);

   // Factory Registration

	`uvm_component_utils(source_driver)

     	virtual router_if.SRC_DRV_MP vif;

         source_agent_config m_cfg;



// Standard UVM Methods:
     	
	extern function new(string name ="source_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase); 
	extern task send_to_dut(source_xtn req);
endclass

//-----------------  constructor new method  -------------------//
	function source_driver::new(string name ="source_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	function void source_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);
	 if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
 	function void source_driver::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
        endfunction


//-----------------  run() phase method  -------------------//

	task source_driver::run_phase(uvm_phase phase);
	@(vif.src_drv);
		vif.src_drv.resetn<=1'b0;
	@(vif.src_drv);
		vif.src_drv.resetn<=1'b1;

               	forever 
		begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end
	endtask

//-----------------  task send_to_dut() method  -------------------//

	task source_driver::send_to_dut(source_xtn req);
	while(vif.src_drv.busy!==0)
		@(vif.src_drv);
		vif.src_drv.pkt_valid<=1'b1;
		vif.src_drv.data_in<=req.header;
		@(vif.src_drv);
		foreach(req.payload[i])
			begin
			while(vif.src_drv.busy!==0)
          		@(vif.src_drv);
			vif.src_drv.data_in<=req.payload[i];
			@(vif.src_drv);
		end
		vif.src_drv.pkt_valid<=1'b0;
		vif.src_drv.data_in<=req.parity;
		req.print();
		
	//	repeat(2)
	//		@(vif.src_drv);
	//		req.error<=vif.src_drv.error;
		

			

	
endtask
