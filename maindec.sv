module maindec (input logic [10:0] Op, 
	output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, 
	output logic [1:0] ALUOp);

	always_comb
		casez(Op)
			11'b111_1100_0010: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 'b0_1_1_1_1_0_0_00;
			11'b111_1100_0000: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 'b1_1_0_0_0_1_0_00;
			11'b101_1010_0???: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 'b1_0_0_0_0_0_1_01;
			// R-format
			11'b100_0101_1000, 11'b110_0101_1000, 11'b100_0101_0000, 11'b101_0101_0000:
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 'b0_0_0_1_0_0_0_10;
			
			default: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = '0;
		endcase
endmodule
