interface router_if(input bit clock); 

logic [7:0] data_in;
logic [7:0] data_out;
logic resetn;
logic pkt_valid;
logic error;
logic busy;
logic valid_out;
logic read_enb;
//bit clk;
 // assign clk = clock;


clocking src_drv @(posedge clock);
default input #1 output #1;
output data_in;
output pkt_valid;
output resetn;
input busy;
input error;
endclocking

clocking src_mon @(posedge clock);
default input #1 output #1;
input data_in;
input pkt_valid;
input busy;
input error;
endclocking


clocking des_drv @(posedge clock);
default input #1 output #1;
input valid_out;
output read_enb;
endclocking


clocking des_mon @(posedge clock);
default input #1 output #1;
input data_out;
input read_enb;
endclocking

modport SRC_DRV_MP(clocking src_drv);
modport SRC_MON_MP(clocking src_mon);
modport DES_DRV_MP(clocking des_drv);
modport DES_MON_MP(clocking des_mon);

endinterface
