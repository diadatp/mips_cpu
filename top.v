module top (
	input clk, // clock
	input reset  // synchronous reset active high
);

	wire [31:0] imem_data ;
	wire [31:0] imem_addr ;
	wire [31:0] dmem_rdata;
	wire        dmem_we   ;
	wire [31:0] dmem_addr ;
	wire [31:0] dmem_wdata;

	imem imem_inst (
		.addr(imem_addr[7:2]),
		.data(imem_data     )
	);

	mips mips_inst (
		.clk       (clk       ),
		.rst       (reset     ),
		.imem_data (imem_data ),
		.imem_addr (imem_addr ),
		.dmem_rdata(dmem_rdata),
		.dmem_we   (dmem_we   ),
		.dmem_addr (dmem_addr ),
		.dmem_wdata(dmem_wdata)
	);

	dmem dmem_inst (
		.clk  (clk       ),
		.we   (dmem_we   ),
		.addr (dmem_addr ),
		.wdata(dmem_wdata),
		.rdata(dmem_rdata)
	);

endmodule