module flopr_tb();
	logic clk, reset;
	logic [31:0] testnum, errors;
	logic [63:0] d, q, qexpected;
	
	logic [63:0] testvectors [9:0] = '{
		64'h12345678,
		64'h01ea7a55,
		64'h00011001,
		64'h69694200,
		64'h48eaf54c,
		64'h80ecd145,
		64'h4132fe14,
		64'hbbbaaa00,
		64'habcdef01,
		64'h6710345a
	};

	flopr#(64) dut(clk, reset, d, q);
	
	always begin
			clk = 1; #5; clk = 0; #5;
	end
	
	always @(negedge clk) begin
		if (~reset) qexpected = testvectors[testnum];
		else qexpected = 64'b0;
		d = testvectors[testnum]; #10;
		testnum = testnum + 1;
	end
	
	always @(posedge clk) begin
		#1;
		if (testvectors[testnum] === 64'bx) begin
			$display("%d/%d tests finished succesfully", testnum-errors, testnum);
			$stop;
		end
		
		if (q !== qexpected) begin
			$display("Error");
			$display("q = %h (expected %h) in %dth instance", q, qexpected, testnum+1);
			errors = errors + 1;
		end
	end
	
	initial begin
		#1;
		testnum = 0; errors = 0;
		reset = 1; #52;
		reset = 0;
	end
endmodule
