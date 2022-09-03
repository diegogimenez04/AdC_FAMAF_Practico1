module execute(input logic AluSrc,
	input logic [3:0] AluControl,
	input logic [63:0] PC_E, signImm_E, readData1_E, readData2_E,
	output logic [63:0] PCBranch_E, aluResult_E, writeData_E,
	output logic zero_E);

	logic [63:0] output_sl, output_mux;

	sl2#(64) sl(signImm_E, output_sl);
	adder#(64) ad(output_sl, PC_E, PCBranch_E);
	mux2#(64) mu(readData2_E, signImm_E, AluSrc, output_mux);
	alu al(readData1_E, output_mux, AluControl, aluResult_E, zero_E);
	assign writeData_E = readData2_E;
endmodule
