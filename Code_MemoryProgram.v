module memory_program(PC,code,clock);
	input clock;
	input [7:0]PC;
	output [7:0]code;

	reg [7:0]linha;
	reg[7:0]memprogram[65:0];
	assign code=linha;
	
	initial begin 
		$readmemb("C:/Users/Thepe/Documents/VERILOG/project.dat",memprogram);
	end
	
	always @(negedge clock) begin //caso PC não mude(em modo de halt desligado), o codigo não execulta 
		linha = memprogram[PC];
	end
endmodule
// funcionando

/*module teste;

	reg [7:0]PC;
	reg [7:0]contador; // para o loop for
	wire [7:0]code;

	initial begin
		$monitor("Linha:%b PC=%d",code,PC);
		PC = 8'b00000000;
	end

	always begin
  		for(contador=0;contador<=100;contador=contador+1)
		begin
			#1 PC = contador;
		end
		$stop;
	end
	memory_program teste(PC,code);
endmodule*/

