class router_base_test extends uvm_test;

   // Factory Registration
	`uvm_component_utils(router_base_test)

      	router_tb router_envh;
        router_env_config r_cfg;
     	source_agent_config s_cfg[];
	destination_agent_config d_cfg[];

        int no_of_sagts = 1;
        int no_of_dagts =3 ;

// Standard UVM Methods:

	extern function new(string name = "router_base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void start_of_simulation_phase(uvm_phase phase);
        endclass

//-----------------  constructor new method  -------------------//

   	function router_base_test::new(string name = "router_base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


function void router_base_test::build_phase(uvm_phase phase);
		  s_cfg = new[no_of_sagts];
		  d_cfg = new[no_of_dagts];


	        r_cfg=router_env_config::type_id::create("r_cfg");
                r_cfg.src_agent_cfg =new[no_of_sagts];
                r_cfg.des_agent_cfg=new[no_of_dagts];
		r_cfg.no_of_sagts=no_of_sagts;
		r_cfg.no_of_dagts=no_of_dagts;
		foreach(s_cfg[i])
		begin
		s_cfg[i]=source_agent_config::type_id::create($sformatf("s_cfg[%0d]",i));
	if(!uvm_config_db #(virtual router_if)::get(this,"","vif",s_cfg[i].vif))
		`uvm_fatal("test","cannot get config data")
		s_cfg[i].is_active=UVM_ACTIVE;
		r_cfg.src_agent_cfg[i]=s_cfg[i];
		end
	foreach(d_cfg[i])
		begin
		d_cfg[i]=destination_agent_config::type_id::create($sformatf("d_cfg[%0d]",i));
	if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("vif_%0d",i),d_cfg[i].vif))
		`uvm_fatal("test","cannot get config data")
		d_cfg[i].is_active=UVM_ACTIVE;
		r_cfg.des_agent_cfg[i]=d_cfg[i];
		end
		uvm_config_db #(router_env_config)::set(this,"*","router_env_config",r_cfg);
		r_cfg.no_of_sagts=no_of_sagts;
		r_cfg.no_of_dagts=no_of_dagts;
     		super.build();
		router_envh=router_tb::type_id::create("router_envh", this);
	endfunction

function void router_base_test::start_of_simulation_phase(uvm_phase phase);
		uvm_top.print_topology;
	endfunction 

	
class small_test extends router_base_test;

  
	`uvm_component_utils(small_test)

         bit[1:0] addr;
 	 small_vseq s_v;
	// medium_vseq m_v;
	 //large_vseq l_v;


	 
// Standard UVM Methods:
 
	extern function new(string name = "small_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

   	function small_test::new(string name = "small_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//-----------------  build() phase method  -------------------//
            
	function void small_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
		endfunction


//-----------------  run() phase method  -------------------//
      	task small_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
repeat(20)
begin
         s_v=small_vseq::type_id::create("s_v");
	 //m_v=medium_vseq::type_id::create("m_v");
	 //l_v=large_vseq::type_id::create("l_v");


	 addr=$urandom%3;
         uvm_config_db #(bit[1:0])::set(this,"*","addr",addr);
       	 s_v.start(router_envh.v_seqrh);
	// m_v.start(router_envh.v_seqrh);
	 //l_v.start(router_envh.v_seqrh);
end

         phase.drop_objection(this);
	endtask   





class medium_test extends router_base_test;

	`uvm_component_utils(medium_test)

         bit[1:0] addr;
 	 medium_vseq m_v;

// Standard UVM Methods:
 
	extern function new(string name = "medium_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

   	function medium_test::new(string name = "medium_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//-----------------  build() phase method  -------------------//
            
	function void medium_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
		endfunction


//-----------------  run() phase method  -------------------//
      task medium_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
repeat(20)
begin
         m_v=medium_vseq::type_id::create("m_v");
	 addr=$urandom%3;
         uvm_config_db #(bit[1:0])::set(this,"*","addr",addr);
       	 m_v.start(router_envh.v_seqrh);
end
         phase.drop_objection(this);
	endtask   

	



class large_test extends router_base_test;

  
	`uvm_component_utils(large_test)

         bit[1:0] addr;
 	 large_vseq l_v;

// Standard UVM Methods:
 
	extern function new(string name = "large_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

   	function large_test::new(string name = "large_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//-----------------  build() phase method  -------------------//
            
	function void large_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
		endfunction


//-----------------  run() phase method  -------------------//
      task large_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
repeat(10)
begin
         l_v=large_vseq::type_id::create("l_v");
	 addr=$urandom%3;
         uvm_config_db #(bit[1:0])::set(this,"*","addr",addr);
       	 l_v.start(router_envh.v_seqrh);
end
         phase.drop_objection(this);

	endtask 

class error_test extends router_base_test;

  
	`uvm_component_utils(error_test)

         bit[1:0] addr;
 	 error_vseq e_v;

// Standard UVM Methods:
 
	extern function new(string name = "error_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

   	function error_test::new(string name = "error_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


//-----------------  build() phase method  -------------------//
            
	function void error_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
		endfunction


//-----------------  run() phase method  -------------------//
      task error_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
repeat(10)
begin
         e_v=error_vseq::type_id::create("e_v");
	 addr=$urandom%3;
         uvm_config_db #(bit[1:0])::set(this,"*","addr",addr);
       	 e_v.start(router_envh.v_seqrh);
end
         phase.drop_objection(this);
	endtask   


  
