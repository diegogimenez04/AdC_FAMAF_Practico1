module execute_tb ();

	logic [63:0] PC_E, signImm_E, readData1_E, readData2_E, PCBranch_E, aluResult_E, writeData_E, branch_exp, alu_exp, write_exp, test, errors;
	logic [3:0] AluControl;
	logic AluSrc, zero_E, zero_exp, clk;

	logic [455:0] tests [0:0] = '{
	// AluSRc,AluControl,PC_E,	  SignImm,	ReadData1 ReadData2 PCBranch, AluRes, WriteData, zero
		{1'b0, 4'b0010, 64'h0000, 64'h0001, 64'h0002, 64'h0000, 64'b100, 64'b10,    64'b0,    1'b0}
	};

	execute dut(AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E, PCBranch_E, aluResult_E, writeData_E, zero_E);

	always begin
		clk = 0; #5; clk = 1; #5;
	end

	always @(negedge clk) begin
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E, branch_exp, alu_exp, write_exp, zero_exp} = tests[test];
		test = test +1;
	end

	always @(posedge clk) begin
		if(tests[test] === 'bx) begin
			$display("%d / %d tests succesfully finished", test-errors, test);
			$stop;
		end
		if(PCBranch_E !== branch_exp) begin
			$display("Branch: %h (expected %h)", PCBranch_E, branch_exp);
			errors = errors +1;			
		end
		if(aluResult_E !== alu_exp) begin
			$display("Branch: %h (expected %h)", PCBranch_E, branch_exp);
			errors = errors +1;			
		end
		if(writeData_E !== write_exp) begin
			$display("Branch: %h (expected %h)", PCBranch_E, branch_exp);
			errors = errors +1;			
		end
		if(zero_E !== zero_exp) begin
			$display("Branch: %h (expected %h)", PCBranch_E, branch_exp);
			errors = errors +1;			
		end
	end

	initial begin
		test = 0;
		errors = 0;
	end

endmodule
