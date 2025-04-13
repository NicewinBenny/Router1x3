
	class router_scoreboard extends uvm_scoreboard;
	 `uvm_component_utils(router_scoreboard)

	source_xtn src;
	destination_xtn des;
	
	uvm_tlm_analysis_fifo #(source_xtn) src_fifo[];
        uvm_tlm_analysis_fifo #(destination_xtn) des_fifo[];
	router_env_config m_cfg;
	bit[1:0]addr;

	covergroup src_cg;
	ADDR:coverpoint src.header[1:0]{
				bins address1={2'b00};
				bins address2={2'b01};
				bins address3={2'b10};}
	PAYLOAD_LENGTH:coverpoint src.header[7:2]{
				bins small_t={[1:20]};
				bins medium_t={[21:40]};
				bins large_t={[41:63]};}
	ERROR:coverpoint src.error{
				bins no_error={0};
				bins error={1};}
	
	SRC:cross ADDR,PAYLOAD_LENGTH;

	endgroup

	covergroup des_cg;
	ADDRD:coverpoint des.header[1:0]{
				bins address1={2'b00};
				bins address2={2'b01};
				bins address3={2'b10};}
	PAYLOAD_LENGTHD:coverpoint des.header[7:2]{
				bins small_t={[1:20]};
				bins medium_t={[21:40]};
				bins large_t={[41:63]};}
	DES:cross ADDRD,PAYLOAD_LENGTHD;

	endgroup
extern function new(string name,uvm_component parent);
extern task run_phase(uvm_phase phase);
extern function void build_phase(uvm_phase phase);
extern task compare(source_xtn src,destination_xtn des);

endclass

     	function router_scoreboard::new(string name,uvm_component parent);
		super.new(name,parent);
		 src_cg = new();
   		 des_cg= new();
	endfunction

	function void router_scoreboard::build_phase(uvm_phase phase);
	 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	src_fifo=new[m_cfg.no_of_sagts];
	des_fifo=new[m_cfg.no_of_dagts];
	foreach(src_fifo[i])
		src_fifo[i]=new($sformatf("src_fifo[%0d]",i),this);
	foreach(des_fifo[i])
		des_fifo[i]=new($sformatf("des_fifo[%0d]",i),this);

	
	endfunction

        

  
	task router_scoreboard::compare(source_xtn src,destination_xtn des);
		if(src.header==des.header)
		$display("sucess");
		else
		$display("failed");
		if(src.payload==des.payload)
		$display("sucess");
		else
		$display("failed");
		if(src.parity==des.parity)
		$display("sucess");
		else
		$display("failed");
	endtask

		
     task router_scoreboard::run_phase(uvm_phase phase);
	   forever 
		begin
		fork
		begin
            	src_fifo[0].get(src);
            	src.print(); 
		src_cg.sample;
		end
		begin
		if(!uvm_config_db#(bit[1:0])::get(this,"","addr",addr))
			`uvm_fatal("Router_scoreboard","getting failed")
		des_fifo[addr].get(des);
		des_cg.sample;
		end
		join
		compare(src,des);
		end
	endtask

