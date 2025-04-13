
class vbase_seq extends uvm_sequence #(uvm_sequence_item);

	
  // Factory registration
	`uvm_object_utils(vbase_seq)  
       
	source_sequencer s_seqrh[];
	destination_sequencer d_seqrh[]; 

        router_virtual_sequencer vsqrh;
	small_packet s_h;
	medium_packet m_h;
	large_packet l_h;
	error_packet e_h;
	normal_sequence n_h;
	soft_reset sr_h;

	router_env_config m_cfg;
	bit[1:0]addr;



// Standard UVM Methods:
 	extern function new(string name = "vbase_seq");
	extern task body();
	endclass : vbase_seq  


        function vbase_seq::new(string name ="vbase_seq");
		super.new(name);
	endfunction


task vbase_seq::body();
	if(!uvm_config_db #(router_env_config)::get(null,get_full_name(),"router_env_config",m_cfg))
		`uvm_fatal("virtual_seq","getting failed")	  
	s_seqrh=new[m_cfg.no_of_sagts];
  	d_seqrh=new[m_cfg.no_of_dagts];

  assert($cast(vsqrh,m_sequencer)) 
  else
  begin
    `uvm_error("BODY", "Error in $cast of virtual sequencer")
  end


 	foreach(s_seqrh[i])
	s_seqrh[i]=vsqrh.s_seqrh[i];

	foreach(d_seqrh[i])
		d_seqrh[i]=vsqrh.d_seqrh[i];
endtask: body

   



class small_vseq extends vbase_seq;

	`uvm_object_utils(small_vseq)
	bit[1:0]addr;


// Standard UVM Methods:
 	extern function new(string name = "small_vseq");
	extern task body();
	endclass : small_vseq  


	function small_vseq::new(string name ="small_vseq");
		super.new(name);
	endfunction


	task small_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("virtual_seuquence","failed")
	s_h=small_packet::type_id::create("s_h");
	n_h=normal_sequence::type_id::create("n_h");
	//m_h=medium_packet::type_id::create("m_h");
	//l_h=large_packet::type_id::create("l_h");

	//sr_h=soft_reset::type_id::create("sr_h");

	fork
		s_h.start(s_seqrh[0]);
		n_h.start(d_seqrh[addr]);
		//m_h.start(s_seqrh[0]);
		//l_h.start(s_seqrh[0]);
	//sr_h.start(d_seqrh[addr]);

	join
	endtask

 /*class rsmall_vseq extends vbase_seq;

	`uvm_object_utils(rsmall_vseq)


// Standard UVM Methods:
 	extern function new(string name = "rsmall_vseq");
	extern task body();
	endclass : rsmall_vseq  


	function rsmall_vseq::new(string name ="rsmall_vseq");
		super.new(name);
	endfunction


	task rsmall_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr)
		`uvm_fatal("virtual_seuquence","failed")
	s_h=small_packet::type_id::create("s_h");
	sr_h=soft_reset::type_id::create("sr_h");
	fork
		s_h.start(s_seqrh[i]);
		sr_h.start(d_seqrh[addr]);
	join
	endtask*/


class medium_vseq extends vbase_seq;

	`uvm_object_utils(medium_vseq)
	bit[1:0]addr;


// Standard UVM Methods:
 	extern function new(string name = "medium_vseq");
	extern task body();
	endclass : medium_vseq  


	function medium_vseq::new(string name ="medium_vseq");
		super.new(name);
	endfunction


	task medium_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("virtual_seuquence","failed")
	m_h=medium_packet::type_id::create("m_h");
	n_h=normal_sequence::type_id::create("n_h");
	//sr_h=soft_reset::type_id::create("sr_h");

	fork
		m_h.start(s_seqrh[0]);
		n_h.start(d_seqrh[addr]);
		//sr_h.start(d_seqrh[addr]);
	join
	endtask



/*class rmedium_vseq extends vbase_seq;

	`uvm_object_utils(rmedium_vseq)


// Standard UVM Methods:
 	extern function new(string name = "rmedium_vseq");
	extern task body();
	endclass : rmedium_vseq  


	function rmedium_vseq::new(string name ="rmedium_vseq");
		super.new(name);
	endfunction


	task rmedium_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr)
		`uvm_fatal("virtual_seuquence","failed")
	m_h=medium_packet::type_id::create("m_h");
	sr_h=soft_reset::type_id::create("sr_h");
	fork
		m_h.start(s_seqrh[i]);
		sr_h.start(d_seqrh[addr]);
	join
	endtask*/



class large_vseq extends vbase_seq;

	`uvm_object_utils(large_vseq)
        bit[1:0]addr;


// Standard UVM Methods:
 	extern function new(string name = "large_vseq");
	extern task body();
	endclass : large_vseq  


	function large_vseq::new(string name ="large_vseq");
		super.new(name);
	endfunction


	task large_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("virtual_seuquence","failed")
	l_h=large_packet::type_id::create("l_h");
	//n_h=normal_sequence::type_id::create("n_h");
	sr_h=soft_reset::type_id::create("sr_h");

		
	fork
		l_h.start(s_seqrh[0]);
		//n_h.start(d_seqrh[addr]);
		sr_h.start(d_seqrh[addr]);
	join
	endtask


/*class rlarge_vseq extends vbase_seq;

	`uvm_object_utils(rlarge_vseq)


// Standard UVM Methods:
 	extern function new(string name = "rlarge_vseq");
	extern task body();
	endclass : rlarge_vseq  


	function rlarge_vseq::new(string name ="rlarge_vseq");
		super.new(name);
	endfunction


	task rlarge_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr)
		`uvm_fatal("virtual_seuquence","failed")
	l_h=large_packet::type_id::create("m_h");
	sr_h=soft_reset::type_id::create("sr_h");
	fork
		l_h.start(s_seqrh[i]);
		sr_h.start(d_seqrh[addr]);
	join
	endtask*/


class error_vseq extends vbase_seq;

	`uvm_object_utils(error_vseq)
	bit[1:0]addr;


// Standard UVM Methods:
 	extern function new(string name = "error_vseq");
	extern task body();
	endclass : error_vseq  


	function error_vseq::new(string name ="error_vseq");
		super.new(name);
	endfunction


	task error_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("virtual_seuquence","failed")
	e_h=error_packet::type_id::create("e_h");
	n_h=normal_sequence::type_id::create("n_h");
	//sr_h=soft_reset::type_id::create("sr_h");

	fork
		e_h.start(s_seqrh[0]);
		n_h.start(d_seqrh[addr]);
		//sr_h.start(d_seqrh[addr]);
	join
	endtask


/*class rerror_vseq extends vbase_seq;

	`uvm_object_utils(rmedium_vseq)


// Standard UVM Methods:
 	extern function new(string name = "rerror_vseq");
	extern task body();
	endclass : rerror_vseq  


	function rerror_vseq::new(string name ="rerror_vseq");
		super.new(name);
	endfunction


	task rerror_vseq::body();
                 super.body();
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr)
		`uvm_fatal("virtual_seuquence","failed")
	e_h=error_packet::type_id::create("e_h");
	sr_h=soft_reset::type_id::create("sr_h");
	fork
		e_h.start(s_seqrh[i]);
		sr_h.start(d_seqrh[addr]);
	join
	endtask*/









