module mips (
    input         clk       ,
    input         rst       ,
    // imem side
    input  [31:0] imem_data ,
    output [31:0] imem_addr ,
    // dmem side
    input  [31:0] dmem_rdata,
    output        dmem_we   ,
    output [31:0] dmem_addr ,
    output [31:0] dmem_wdata
);

    wire [2:0] alucontrol;
    wire       alu_src   ;
    wire       branch    ;
    wire       jump      ;
    wire       mem_to_reg;
    wire       reg_dst   ;
    wire       reg_write ;

    controller controller_inst (
        .instr     (imem_data ),
        .alucontrol(alucontrol),
        .alu_src   (alu_src   ),
        .branch    (branch    ),
        .jump      (jump      ),
        .mem_to_reg(mem_to_reg),
        .mem_write (dmem_we   ),
        .reg_dst   (reg_dst   ),
        .reg_write (reg_write )
    );

    datapath datapath_inst (
        .clk       (clk       ),
        .rst       (rst       ),
        .alucontrol(alucontrol),
        .alu_src   (alu_src   ),
        .branch    (branch    ),
        .jump      (jump      ),
        .mem_to_reg(mem_to_reg),
        .mem_write (dmem_we   ),
        .reg_dst   (reg_dst   ),
        .reg_write (reg_write ),
        .instr     (imem_data ),
        .pc        (imem_addr ),
        .read_data (dmem_rdata),
        .alu_result(dmem_addr ),
        .write_data(dmem_wdata)
    );

endmodule
