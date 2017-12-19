module PC(address,clock,saida_pc);

	input clock;
	input [7:0]address;  			//tamanho do salto
	output [7:0]saida_pc;	

	reg [7:0] valor;			//valor atual de PC

	assign saida_pc = valor;
	
	initial begin
		valor = 0;
	end

	always @(posedge clock) begin
		valor = address;
	end

endmodule


/*module teste_pc;

	reg clock;
	reg [7:0] incremento;
	reg [7:0] contador;

	wire [7:0] saida_pc;

	initial begin
		$monitor("%0d = PC[%b] incremento=%b  CLK[%d]",$time,saida_pc,incremento,clock);
		incremento=1;
		clock = 0;
	end

	always begin
		$monitoron;
		for (contador = 0 ; contador <=10 ; contador = contador + 1)
		begin
			#1 clock = ~clock;
		end
		incremento=2;
		for(contador = 0 ; contador <=5 ; contador = contador + 1)
		begin
			#1 clock = ~clock;
		end
		incremento=5;
		for(contador = 0 ; contador <=5 ; contador = contador + 1)
		begin
			#1 clock = ~clock;
		end
		$monitoroff;
		$stop;
	end
	PC t_PC(incremento,clock,saida_pc);
endmodule
*/