
  class source_xtn extends uvm_sequence_item;
  
// UVM Factory Registration Macro
    	`uvm_object_utils(source_xtn)

	rand bit[7 : 0] header,payload[];    
	bit[7 : 0] parity;
	bit pkt_valid,error,busy;
          
	constraint c1{header[1:0]!=2'b11;}
	constraint c2{payload.size==header[7:2];}
	constraint c3{header[7:2]!=0;}


extern function new(string name = "source_xtn");
extern function void do_print(uvm_printer printer);
extern function void post_randomize();
endclass:source_xtn

//-----------------  constructor new method  -------------------//

	function source_xtn::new(string name = "source_xtn");
		super.new(name);
	endfunction:new
	  


//-----------------  do_print method  -------------------//
   function void  source_xtn::do_print (uvm_printer printer);
    super.do_print(printer);

   
    //                   srting name   		bitstream value     size       radix for printing
    printer.print_field( "header", 		this.header, 	    8,		 UVM_DEC		);
foreach(payload[i])
begin
printer.print_field($sformatf("payload[%0d]",i),  this.payload[i],      8,           UVM_DEC                );
end
    printer.print_field( "parity", 		this.parity, 	    8,		 UVM_DEC		);
    printer.print_field( "pkt_valid", 		this.pkt_valid,      1,		 UVM_DEC		);
    printer.print_field( "error", 		this.error,          1,		 UVM_DEC		);
    printer.print_field( "busy", 		this.busy,           1,		 UVM_DEC		);

   
    //  	         variable name		xtn_type		$bits(variable name) 	variable name.name
    //printer.print_generic( "xtn_type", 		"addr_t",		$bits(xtn_type),		xtn_type.name);

  endfunction:do_print
    

  /* function void source_xtn::post_randomize();
    parity=header;
foreach(payload[i])
    begin
      parity=payload[i]^parity;
    end
  endfunction : post_randomize*/
