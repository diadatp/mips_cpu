module aludec (
	input  [31:0] instr     ,
	output [ 2:0] alucontrol
);

	reg [2:0] alucontrol;

	always @(instr) begin
		casex ({instr[31:26], instr[5:0]})
			12'b000100xxxxxx : alucontrol = 3'b110;
			12'b001010xxxxxx : alucontrol = 3'b111;
			12'b001000xxxxxx : alucontrol = 3'b010;
			12'bxxxxxx100000 : alucontrol = 3'b010;
			12'bxxxxxx100010 : alucontrol = 3'b110;
			12'bxxxxxx100100 : alucontrol = 3'b000;
			12'bxxxxxx100101 : alucontrol = 3'b001;
			12'bxxxxxx101010 : alucontrol = 3'b111;
			default          : alucontrol = 3'b010;
		endcase
	end

endmodule
