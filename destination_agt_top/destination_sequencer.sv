
// Extend ram_rd_sequencer from uvm_sequencer parameterized by read_xtn
	class destination_sequencer extends uvm_sequencer #(destination_xtn);

// Factory registration using `uvm_component_utils
	`uvm_component_utils(destination_sequencer)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "destination_sequencer",uvm_component parent);
	endclass
//-----------------  constructor new method  -------------------//
	function destination_sequencer::new(string name="destination_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
