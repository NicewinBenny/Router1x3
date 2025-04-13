
module router_top(clk,rst,din,rd_en0,rd_en1,rd_en2,pkt_vld,vld_out0,vld_out1,vld_out2,dout0,dout1,dout2,busy,err);
input clk,rst,rd_en0,rd_en1,rd_en2,pkt_vld;
input [7:0] din;
output vld_out0,vld_out1,vld_out2,busy,err;
output [7:0]dout0,dout1,dout2;
wire [2:0]write_enb;
wire [7:0]dout;
wire empty0,empty1,empty2,full0,full1,full2,sft_rst0,sft_rst1,sft_rst2,lfd_state,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,low_pkt_vld,parity_done,fifo_full;
rfsm FSM(clk,rst,parity_done,pkt_vld,sft_rst0,sft_rst1,sft_rst2,fifo_full,low_pkt_vld,empty0,empty1,empty2,din[1:0],busy,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state);
rsynch SYN(detect_add,din[1:0],write_enb_reg,clk,rst,rd_en0,rd_en1,rd_en2,empty0,empty1,empty2,full0,full1,full2,sft_rst0,sft_rst1,sft_rst2,vld_out0,vld_out1,vld_out2,fifo_full,write_enb);
router_reg REG(clk,rst,pkt_vld,din,fifo_full,rst_int_reg,detect_add,ld_state,laf_state,full_state,lfd_state,parity_done,low_pkt_vld,err,dout);

router_fifo FIFO_0(clk,rst,rd_en0,write_enb[0],dout,dout0,full0,empty0,sft_rst0,lfd_state);
router_fifo FIFO_1(clk,rst,rd_en1,write_enb[1],dout,dout1,full1,empty1,sft_rst1,lfd_state);
router_fifo FIFO_2(clk,rst,rd_en2,write_enb[2],dout,dout2,full2,empty2,sft_rst2,lfd_state);
//rfsm FSM(clk,rst,parity_done,pkt_vld,sft_rst0,sft_rst1,sft_rst2,fifo_full,low_pkt_vld,empty0,empty1,empty2,din[1:0],busy,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state);
//rsynch SYN(detect_add,din[1:0],wrt_enb_reg,clk,rst,rd_en0,rd_en1,rd_en2,empty0,empty1,empty2,full0,full1,full2,sft_rst0,sft_rst1,sft_rst2,vld_out0,vld_out1,vld_out2,fifo_full,write_enb);
//router_reg REG(clk,rst,pkt_vld,din,fifo_full,rst_int_reg,detect_add,ld_state,laf_state,full_state,lfd_state,parity_done,low_pkt_vld,err,dout);
endmodule

