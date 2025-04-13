 
class base_seq extends uvm_sequence #(source_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(base_seq)  

// Standard UVM Methods:
        extern function new(string name ="base_seq");
	endclass
//-----------------  constructor new method  -------------------//
	function base_seq::new(string name ="base_seq");
		super.new(name);
	endfunction


class small_packet extends base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(small_packet)
bit[1:0]addr;

// Standard UVM Methods:
        extern function new(string name ="small_packet");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function small_packet::new(string name = "small_packet");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      	
	task small_packet::body();
	//repeat(5)
	  begin
   	   req=source_xtn::type_id::create("req");
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("sequence","getting failed")
	   start_item(req);
   	   assert(req.randomize() with {header[7:2] inside {[1:20]} && header[1:0]==addr;});
	   `uvm_info("SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	   finish_item(req); 
	   end
    	endtask



//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_ten_wr_xtns from ram_wbase_seq;
class medium_packet extends base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(medium_packet)
bit[1:0]addr;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="medium_packet");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function medium_packet::new(string name = "medium_packet");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
        task medium_packet::body();	
   	//repeat(5) 
	begin
	req=source_xtn::type_id::create("req");
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("sequence","getting failed")
	start_item(req);
   assert(req.randomize() with {header[7:2] inside {[21:40]} && header[1:0]==addr;});

	`uvm_info("SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	end
       endtask


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------
class large_packet extends base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(large_packet)
bit[1:0]addr;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="large_packet");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function large_packet::new(string name = "large_packet");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
        task large_packet::body();	
   	//repeat(5) 
	begin
	req=source_xtn::type_id::create("req");
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("sequence","getting failed")
	start_item(req);
       assert(req.randomize() with {header[7:2] inside {[41:63]} && header[1:0]==addr;});
	`uvm_info("SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	end
       endtask


class error_packet extends base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(error_packet)
bit[1:0]addr;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="error_packet");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function error_packet::new(string name = "error_packet");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
        task error_packet::body();	
   	//repeat(5) 
	begin
	req=source_xtn::type_id::create("req");
	if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"addr",addr))
		`uvm_fatal("sequence","getting failed")
	start_item(req);
       assert(req.randomize() with {header[7:2] inside {[1:63]} && header[1:0]==addr;});
	req.parity=8'd7;
	`uvm_info("SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	end
       endtask

