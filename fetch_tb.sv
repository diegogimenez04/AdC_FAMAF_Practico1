module fetch_tb();
	logic clk, reset, PCSrc_F;
	logic [63:0] PCBranch_F, imem_addr_F, cycle, expected;
	
	
	logic [127:0] tests [0:1] = '{
		{64'hffff, 64'b0},
		{64'hfff1, 64'hfff1}
	};

	fetch dut(PCSrc_F, clk, reset, PCBranch_F, imem_addr_F);

	always begin
		clk = 0; #5; clk = 1; #5;
	end

	always @(negedge clk) begin
		if(cycle === 5) begin
			reset = 0;
			PCBranch_F = 64'hfff0;
		end
		if(cycle===10) begin
			PCSrc_F = 1;
		end
		cycle = cycle +1;
	end

	always @(posedge clk) begin
		if(cycle >= 5) begin
			$display("PCBranch_F: %h\nimem_addr_F = %h", PCBranch_F, imem_addr_F);
		end
		if(cycle===15) begin
			$stop;
		end
	end

	initial begin
		cycle = 0;
		reset = 1;
		PCSrc_F = 0;
		PCBranch_F = 64'h1;
	end

endmodule
