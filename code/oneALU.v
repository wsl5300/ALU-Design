`timescale 1ns/1ns
module oneALU( dataA, dataB, Signal, carryin, carryout, less, Set, dataOut );
	input dataA, dataB;
	input [5:0] Signal;
	input carryin;
	output carryout;
	input less;
	output Set;
	output dataOut;
	wire ANDOut;
	wire OROut;
	wire XOROut;
	wire sum;

	and(ANDOut, dataA, dataB);
	or(OROut, dataA, dataB);
	xor(XOROut, dataB, Signal[1]);
	FA fa (.a(dataA), .b(XOROut), .c(carryin), .cout(carryout), .sum(sum));

	assign Set = sum;

	parameter AND = 6'b100100; 
	parameter OR  = 6'b100101; 
	parameter ADD = 6'b100000; 
	parameter SUB = 6'b100010;
	parameter SLT = 6'b101010; 

	assign dataOut = (Signal == AND) ? ANDOut : (Signal == OR) ? OROut : (Signal == ADD) ? sum : (Signal == SUB) ? sum : (Signal == SLT) ? less : 1'bx;    
                  


endmodule