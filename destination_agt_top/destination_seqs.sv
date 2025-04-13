
class base_dseq extends uvm_sequence #(destination_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(base_dseq)  

// Standard UVM Methods:
        extern function new(string name ="base_dseq");
	endclass
//-----------------  constructor new method  -------------------//
	function base_dseq::new(string name ="base_dseq");
		super.new(name);
	endfunction





class normal_sequence extends base_dseq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(normal_sequence)

// Standard UVM Methods:
        extern function new(string name ="normal_sequence");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function normal_sequence::new(string name = "normal_sequence");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      	
	task normal_sequence::body();
	  begin
   	   req=destination_xtn::type_id::create("req");
	   start_item(req);
   	 	 assert(req.randomize() with {delay<30;});
	   finish_item(req); 
	   end
    	endtask


	
class soft_reset extends base_dseq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(soft_reset)

// Standard UVM Methods:
        extern function new(string name ="soft_reset");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function soft_reset::new(string name = "soft_reset");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
        task soft_reset::body();	

	begin
	req=destination_xtn::type_id::create("req");
	start_item(req);
        assert(req.randomize() with {delay>30;});
	finish_item(req);
	end
       endtask

