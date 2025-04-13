class source_sequencer extends uvm_sequencer #(source_xtn);

// Factory registration using `uvm_component_utils
	`uvm_component_utils(source_sequencer)


// Standard UVM Methods:
	extern function new(string name = "source_sequencer",uvm_component parent);
	endclass

//-----------------  constructor new method  -------------------//

	function source_sequencer::new(string name="source_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

