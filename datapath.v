module datapath (
	input         clk       ,
	input         rst       ,
	input  [ 2:0] alucontrol,
	input         alu_src   ,
	input         branch    ,
	input         jump      ,
	input         mem_to_reg,
	input         mem_write ,
	input         reg_dst   ,
	input         reg_write ,
	// imem side
	input  [31:0] instr     ,
	output [31:0] pc        ,
	// dmem side
	input  [31:0] read_data ,
	output [31:0] alu_result,
	output [31:0] write_data
);

	wire [31:0] pc_plus_4;
	assign pc_plus_4 = pc + 4;

	wire [31:0] pc_jump;
	assign pc_jump = {pc_plus_4[31:28], instr[25:0], 2'b00};

	wire pc_src;
	assign pc_src = branch & zero;

	wire [31:0] pc_branch;
	assign pc_branch = pc_plus_4 + {imm_ext[29:0], 2'b00};

	wire [31:0] pc_next;
	assign pc_next = jump ? pc_jump : (pc_src ? pc_branch : pc_plus_4);

	reg [31:0] pc;
	always @(posedge clk) begin : proc_pc
		if(~rst) begin
			pc = pc_next;
		end else begin
			pc = 32'h00000000;
		end
	end

	wire [5:0] rt;
	assign rt = instr[20:16];

	wire [5:0] rd;
	assign rd = instr[15:11];

	wire [4:0] write_reg;
	assign write_reg = reg_dst ? rd : rt;

	wire [31:0] result;
	assign result = mem_to_reg ? read_data : alu_result ;

	wire [31:0] reg_data1;
	wire [31:0] reg_data2;

	regfile regfile_inst (
		.clk  (clk         ),
		.rw   (reg_write   ),
		.addr1(instr[25:21]),
		.addr2(instr[20:16]),
		.addr3(write_reg   ),
		.wdata(result      ),
		.data1(reg_data1   ),
		.data2(reg_data2   )
	);

	wire [31:0] src_a;
	wire [31:0] src_b;
	wire c_out;

	assign src_a = reg_data1;
	assign src_b = alu_src ? imm_ext : reg_data2;

	alu alu_inst (
		.a_in (src_a     ),
		.b_in (src_b     ),
		.f_in (alucontrol),
		.zero (zero      ),
		.c_out(c_out     ),
		.y_out(alu_out   )
	);
	wire [31:0] alu_out;
	assign alu_result = alu_out;

	wire [31:0] imm_ext;
	sign_extend sign_extend_inst (
		.idata(instr[15:0]),
		.odata(imm_ext    )
	);

	assign write_data = reg_data2;

endmodule
