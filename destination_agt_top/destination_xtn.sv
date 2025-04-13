 class destination_xtn extends uvm_sequence_item;
  
    	`uvm_object_utils(destination_xtn)

 bit[7:0]header,payload[],parity;
bit read_enb,valid_out;
rand bit[5:0]delay;

         
 

// Standard UVM Methods:
extern function new(string name = "destination_xtn");
extern function void do_print(uvm_printer printer);


endclass:destination_xtn

//-----------------  constructor new method  -------------------//

function destination_xtn::new(string name = "destination_xtn");
		super.new(name);
endfunction:new
	  
function void destination_xtn::do_print (uvm_printer printer);
super.do_print(printer);
printer.print_field("header",this.header,8,UVM_DEC);
foreach(payload[i])
begin
printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);
end
printer.print_field("parity",this.parity,8,UVM_DEC);
printer.print_field("read_enb",this.read_enb,1,UVM_DEC);
printer.print_field("valid_out",this.valid_out,1,UVM_DEC);
printer.print_field("delay",this.delay,6,UVM_DEC);
endfunction:do_print

