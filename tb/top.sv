module top;
   	
    	import router_test_pkg::*;
	import uvm_pkg::*;

   	bit clock;  
	always 
		#10 clock=~clock;     

   	router_if in(clock);
	router_if in0(clock);
	router_if in1(clock);
	router_if in2(clock);

router_top  DUV(.clk(clock),.pkt_vld(in.pkt_valid),.rst(in.resetn),.err(in.error),.busy(in.busy),.din(in.data_in),
.vld_out0(in0.valid_out),.dout0(in0.data_out),.rd_en0(in0.read_enb),
.vld_out1(in1.valid_out),.dout1(in1.data_out),.rd_en1(in1.read_enb),
.vld_out2(in2.valid_out),.dout2(in2.data_out),.rd_en2(in2.read_enb));






//nice
 /* router_top  DUV(.clock(clock),.pkt_valid(in0.pkt_valid),.resetn(in0.resetn),.err(in0.error),.busy(in0.busy),.data_in(in0.data_in),.read_enb_0(in1.read_enb),.vld_out_0(in1.valid_out),.data_out_0(in1.data_out),.read_enb_1(in2.read_enb),.vld_out_1(in2.valid_out),.data_out_1(in2.data_out),.read_enb_2(in3.read_enb),.vld_out_2(in3.valid_out),.data_out_2(in3.data_out));*/
	/*
	router_top DUV	(.clk(clock),.pkt_valid(in0.pkt_valid),.rstn(in0.resetn),.busy(in0.busy),.error(in0.error),.data_in(in0.data_in),.valid_out_0(in1.valid_out),.valid_out_1(in2.valid_out),.valid_out_2(in3.valid_out),.read_enb_0(in1.read_enb),.read_enb_1(in2.read_enb),.read_enb_2(in3.read_enb),.data_out_0(in1.data_out),.data_out_1(in2.data_out),.data_out_2(in3.data_out));
*/

		initial
		 begin
			
			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif
			
			uvm_config_db #(virtual router_if)::set(null,"*","vif",in);	
			uvm_config_db #(virtual router_if)::set(null,"*","vif_0",in0);	
			uvm_config_db #(virtual router_if)::set(null,"*","vif_1",in1);	
			uvm_config_db #(virtual router_if)::set(null,"*","vif_2",in2);	
					run_test();
		end



property stable_data;
@(posedge clock) in.busy |=>$stable(in.data_in);
endproperty

property busy_check;
@(posedge clock)$rose(in.pkt_valid) |->in.busy;
endproperty

property valid_signal;
@(posedge clock)$rose(in.pkt_valid) |->##3(in0.valid_out|in1.valid_out|in2.valid_out);
endproperty

property read_en1;
@(posedge clock)in0.valid_out |->##[1:29](in0.read_enb);
endproperty

property read_en2;
@(posedge clock)in1.valid_out|->##[1:29](in1.read_enb);   
endproperty

property read_en3;
@(posedge clock)in2.valid_out|->##[1:29](in2.read_enb); 
endproperty

property read_en1_low;
@(posedge clock)!(in0.valid_out) |=>!(in0.read_enb);
endproperty

property read_en2_low;
@(posedge clock)!(in1.valid_out) |=>!(in1.read_enb);
endproperty

property read_en3_low;
@(posedge clock)!(in2.valid_out) |=>!(in2.read_enb);
endproperty

C1:assert property(stable_data)
		$display("Assertion is successfull for stable_data");
		else
		$display("not success for stable_data");
C2:assert property(busy_check)
		$display("Assertion is successfull for busy_check");
		else
		$display("not success for busy_check");
C3:assert property(valid_signal)
		$display("Assertion is successfull for valid_signal");
		else
		$display("not success for valid_signal");
C4:assert property(read_en1)
		$display("Assertion is successfull for read_en1");
		else
		$display("not success for read_en1");
C5:assert property(read_en2)
		$display("Assertion is successfull for read_en2");
		else
		$display("not success for read_en2");
C6:assert property(read_en3)
		$display("Assertion is successfull for read_en3");
		else
		$display("not success for read_en3");
C7:assert property(read_en1_low)
		$display("Assertion is successfull for read_en1_low");
		else
		$display("not success for read_en1_low");
C8:assert property(read_en2_low)
		$display("Assertion is successfull for read_en2_low");
		else
		$display("not success for read_en2_low");
C9:assert property(read_en3_low)
		$display("Assertion is successfull for read_en3_low");
		else
		$display("not success for read_en3_low");


D1:cover property(stable_data);
D2:cover property(busy_check);
D3:cover property(valid_signal);
D4:cover property(read_en1);
D5:cover property(read_en2);
D6:cover property(read_en3);
D7:cover property(read_en1_low);
D8:cover property(read_en2_low);
D9:cover property(read_en3_low);

endmodule




