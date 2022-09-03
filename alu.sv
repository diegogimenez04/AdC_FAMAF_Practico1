module alu(input logic [63:0] a, b, input logic [3:0] ALUControl,
	output logic [63:0] result, output logic zero);

	logic [63:0] res;

	always_comb
		casez(ALUControl)
			4'b0000: res = a & b;
			4'b0001: res = a | b;
			4'b0010: res = a + b;
			4'b0110: res = a + (~b + 1);
			4'b0111: res = b;

			default: res='1;
		endcase
		assign result = res;
		assign zero = res === '0 ? '1 : '0;
endmodule
