
module rsynch(detect_add,data_in,wrt_enb_reg,clk,rst,rd_en0,rd_en1,rd_en2,empty_0,empty_1,empty_2,full0,full1,full2,sft_rst0,sft_rst1,sft_rst2,vld_out0,vld_out1,vld_out2,fifo_full,wrt_enb);
input detect_add,wrt_enb_reg,clk,rst,rd_en0,rd_en1,rd_en2,empty_0,empty_1,empty_2,full0,full1,full2;
input [1:0] data_in;
output reg sft_rst0,sft_rst1,sft_rst2,fifo_full;
output vld_out0,vld_out1,vld_out2;
output reg [2:0]wrt_enb;
reg [1:0]fifo_add;
reg [4:0] count_sft_rst0,count_sft_rst1,count_sft_rst2;
wire w0,w1,w2;
always @(posedge clk)
begin
	if(!rst)
		fifo_add<=2'd0;
	else if(detect_add)
		fifo_add<=data_in;
end
always@(*)
begin
	if(wrt_enb_reg)
	begin
		case (fifo_add)
			2'b00:wrt_enb=3'b001;
			2'b01:wrt_enb=3'b010;
			2'b10:wrt_enb=3'b100;
			2'b11:wrt_enb=3'b000;
		endcase
	end
	else
		wrt_enb=3'b000;
end
always@(*)
begin
	case(fifo_add)
		2'b00:fifo_full=full0;
		2'b01:fifo_full=full1;
		2'b10:fifo_full=full2;
		2'b11:fifo_full=1'b0;
	endcase
end
assign vld_out0=!empty_0;
assign vld_out1=!empty_1;
assign vld_out2=!empty_2;



always @(posedge clk)
begin
	if(!rst)
	begin
	count_sft_rst0<=1;
	sft_rst0<=0;
        end
	else if(!vld_out0)
	begin
		count_sft_rst0<=1;
		sft_rst0<=0;
	end
	else if(rd_en0)
	begin
		count_sft_rst0<=1;
		sft_rst0<=0;
	end
        else if(w0)
	begin
		count_sft_rst0<=1;
		sft_rst0<=1;
	end
        else
	begin
		count_sft_rst0<=count_sft_rst0+1;
		sft_rst0<=0;
	end
end

always @(posedge clk)
begin
	if(!rst)
	begin
	count_sft_rst1<=1;
	sft_rst1<=0;
        end
	else if(!vld_out1)
	begin
		count_sft_rst1<=1;
		sft_rst1<=0;
	end
	else if(rd_en1)
	begin
		count_sft_rst1<=1;
		sft_rst1<=0;
	end
        else if(w1)
	begin
		count_sft_rst1<=1;
		sft_rst1<=1;
	end
        else
	begin
		count_sft_rst1<=count_sft_rst1+1;
		sft_rst1<=0;
	end
end

always @(posedge clk)
begin
	if(!rst)
	begin
	count_sft_rst2<=1;
	sft_rst2<=0;
        end
	else if(!vld_out2)
	begin
		count_sft_rst2<=1;
		sft_rst2<=0;
	end
	else if(rd_en2)
	begin
		count_sft_rst2<=1;
	sft_rst2<=0;
	end
        else if(w2)
	begin
		count_sft_rst2<=5'b1;
		sft_rst2<=1'b1;
	end
        else
	begin
		count_sft_rst2<=count_sft_rst2+1;
		sft_rst2<=1'b0;
	end
end
assign w0=(count_sft_rst0==5'd30)? 1'b1:1'b0;
assign w1=(count_sft_rst1==5'd30)? 1'b1:1'b0;
assign w2=(count_sft_rst2==5'd30)? 1'b1:1'b0;
endmodule


     
