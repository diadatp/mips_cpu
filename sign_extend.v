module sign_extend (
	input  [15:0] idata,
	output [31:0] odata
);

	reg [31:0] odata;

	always @(idata) begin : proc_sign_extend
		odata = {{16{idata[15]}}, idata};
	end

endmodule