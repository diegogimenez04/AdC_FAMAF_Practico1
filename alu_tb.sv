module alu_tb();
	logic [63:0] a, b, y, yexp;
	logic [3:0] alu_ctl;
	logic zero, zeroexp;
	
	logic clk;
	logic [31:0] errors, test;
	logic [196:0] test_cases [0:13] = '{
		//     a              b      alu_ctl    yexpected   zexp
		{64'h12345678, 64'h00000000, 4'b0000, 64'h00000000, 1'b1}, // and
		{64'h12345678, 64'h11111111, 4'b0000, 64'h10101010, 1'b0},
		
		{64'h12345678, 64'hFFFFFFFF, 4'b0001, 64'hFFFFFFFF, 1'b0}, // or
		{64'h12345678, 64'h11111111, 4'b0001, 64'h13355779, 1'b0},
		
		{64'h00000000, 64'h00000000, 4'b0010, 64'h00000000, 1'b1}, // add
		{64'hFFFF0000, 64'h0000FFFF, 4'b0010, 64'hFFFFFFFF, 1'b0},
		
		{64'h000FF000, 64'h000FF000, 4'b0110, 64'h00000000, 1'b1}, // sub
		{64'h000FF000, 64'h0FF00000, 4'b0110, ~64'hfe01000+1, 1'b0},
		
		{64'hf31eca91, 64'h87654321, 4'b0111, 64'h87654321, 1'b0}, // pass input b
		{64'h53215343, 64'h00000000, 4'b0111, 64'h00000000, 1'b1},
		
		{64'habcd1459, 64'h04328c1b, 4'b1101, 64'hffffffffffffffff, 1'b?}, // random junk
		{64'h4312fdbc, 64'h84bdacfe, 4'b1011, 64'hffffffffffffffff, 1'b?},
		
		{64'hffffffffffffffff, 64'h1, 4'b0010, 64'h????????????????, 1'b?}, // overflow
		{64'hffffffffffffffff, 64'h8feda1, 4'b0010, 64'h????????????????, 1'b?}
	};
	
	alu dut(a, b, alu_ctl, y, zero);
	
	always begin
		clk = 0; #5; clk = 1; #5;
	end
	
	always @(negedge clk) begin
		{a, b, alu_ctl, yexp, zeroexp} = test_cases[test];
		test = test + 1;
	end
	
	always @(posedge clk) begin
		#1;
		// using != so that overflow tests don't error
		if (y != yexp | zero != zeroexp) begin
			$display("error: test finished with unexpected result!");
			$display("y = %h (expected %h)", y, yexp);
			$display("zero = %b (expected %b)", zero, zeroexp);
			$display("in %dth instance\n", test);
			errors = errors + 1;
		end
		
		if (test_cases[test] === 'bx) begin
			$display("%d/%d tests finished succesfully", test-errors, test);
			$stop;
		end
	end
	
	initial begin
		errors = 0;
		test = 0;
	end
endmodule