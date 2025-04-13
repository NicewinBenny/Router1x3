module router_fifo(clk,rst,rd_en,we,din,dout,full,empty,sft_rst,lfd_state);
input clk,rst,rd_en,we,sft_rst,lfd_state;
input [7:0]din;
output reg [7:0]dout;
output full,empty;
reg [8:0]mem[15:0];
reg [4:0]wrp,rdp;
reg [6:0]count;
reg lfd_state_t;

always@(posedge clk)
begin
	if(!rst)
		lfd_state_t<=0;
	else
		lfd_state_t<=lfd_state;
end

always@(posedge clk)
begin
	if(!rst)
		count<=7'h0;
	else if(sft_rst)
		count<=7'h0;
	else if(rd_en && !empty)
		begin
			if(mem[rdp[3:0]][8]==1)
				count<=mem[rdp[3:0]][7:2]+1'b1;
		else if(count!=0)
		count<=count-1'b1;
end
end
always@(posedge clk)
begin
	if(!rst)
		dout<=8'h0;
	else if(sft_rst)
		dout<=8'hz;
	//else if (count==0&&re)
		//dout<=8'hz;
	else if(rd_en&&!empty)
		dout<=mem[rdp[3:0]][7:0];
		else 
		dout<=8'hz;
end
always@(posedge clk)
begin
	if(!rst)
	
		mem[wrp[3:0]][8:0]<=9'h0;
	else if(sft_rst)
		mem[wrp[3:0]][8:0]<=9'h0;
	else if(we&&!full)
	begin
	if(lfd_state_t)
	begin
	mem[wrp[3:0]][8]<=1;
	mem[wrp[3:0]][7:0]<=din;
	end
	else
	begin
	mem[wrp[3:0]][8]<=0;
	mem[wrp[3:0]][7:0]<=din;
	end
	end
	
	
	
end
always@(posedge clk)
begin
	if(!rst)
		wrp<=5'h0;
	else if(sft_rst)
		wrp<=5'h0;
	else if(we &&!full)
		wrp<=wrp+1'b1;
end
always@(posedge clk)
begin
	if(!rst)
		rdp<=5'h0;
	else if(sft_rst)
		rdp<=5'h0;
	else if (rd_en && !empty)
		rdp<=rdp+1'b1;
end
assign full=((wrp=={~rdp[4],rdp[3:0]})&&(rdp==0))? 1'b1:1'b0;
assign empty =(wrp==rdp)||(sft_rst==1)? 1'b1:1'b0;
endmodule

