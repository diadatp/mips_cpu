module dmem (
	input         clk  ,
	input         we   ,
	input  [31:0] addr ,
	input  [31:0] wdata,
	output [31:0] rdata
);

	reg [31:0] rdata;

	reg [31:0] memdata[63:0];

	always @(memdata[addr]) begin
		rdata = memdata[addr];
	end

	always @(posedge clk) begin
		if(1'b1 == we) begin
			memdata[addr] = wdata;
		end
	end

endmodule
