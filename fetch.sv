module fetch #(N=64) (input logic PCSrc_F, clk, reset,
	input logic [63:0] PCBranch_F,
	output logic [63:0] imem_addr_F);

	logic [63:0] q, d;
	
	mux2#(64) mu(q, PCBranch_F, PCSrc_F, d);
	flopr#(64) flo(clk, reset, d, imem_addr_F);
	adder#(64) ad(imem_addr_F, 64'd4, q);
endmodule
