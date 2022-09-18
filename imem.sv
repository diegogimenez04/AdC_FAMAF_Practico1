module imem
	#(parameter N = 32) (
	input  logic [5:0]   addr,
	output logic [N-1:0] q
);
	logic [31:0] ROM [0:63] = '{ default : '0 };
	initial ROM [0:6] ='{32'h8b1f03e2,
		32'hb4000090,
		32'hcb010210,
		32'h8b110042,
		32'hb4ffffbf,
		32'hf8000002,
		32'hb400001f
		};
	assign q = ROM[addr];
endmodule