module maindec_tb();
	logic [10:0] Op;
	logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
	logic [1:0] ALUOp;
	logic [31:0] test, errors;
	logic [8:0] expected;
	logic clk;
	
	maindec dut(Op, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
	
	logic [19:0] tests [0:4] = '{
	//			Op							Expected
		{11'b111_1100_0010, 9'b0_1_1_1_1_0_0_00},
		{11'b111_1100_0000, 9'b1_1_0_0_0_1_0_00},
		{11'b101_1010_0???, 9'b1_0_0_0_0_0_1_01},
		{11'b100_0101_1000, 9'b0_0_0_1_0_0_0_10},
		{11'b111_1111_1000, 9'b0}
	};
	
	always begin
		clk = 0; #5; clk = 1; #5;
	end

	always @(negedge clk) begin
		{Op, expected} = tests[test];
		test = test + 1;
	end

	always @(posedge clk) begin
		if ({Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} !== expected) begin
			$display("Result: %h (expected %h)\nin test %d", {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp}, expected, test);
			errors = errors + 1;
		end

		if (tests[test] === 'bx) begin
			$display("%d / %d tests finished succesfully", test-errors, test);
			$stop;
		end
	end
	
	initial begin
		test = 0;
		errors = 0;
	end

endmodule
