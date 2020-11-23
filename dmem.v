module dmem (
	input         clk  ,
	input         we   ,
	input  [31:0] addr ,
	input  [31:0] wdata,
	output [31:0] rdata
);

	reg [31:0] memdata [127:0];

	assign rdata = memdata[addr];

	always @(posedge clk) begin
		if(1'b1 == we) begin
			memdata[addr] = wdata;
		end
	end

endmodule
