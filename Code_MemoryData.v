module memory(clock,endereco,controle_escrita,controle_leitura,dado_entrada,dado_saida);
	
	input clock,controle_escrita,controle_leitura;
	input [7:0]endereco,dado_entrada;
	output [7:0]dado_saida;
	
	reg [7:0]line;
	reg[7:0]memdata[255:0];

	assign dado_saida=line;

	always @(negedge clock) begin  //leitura
		if(controle_leitura)
			line = memdata[endereco];
	end
	
	always @(posedge clock) begin  //escrita
		if(controle_escrita)
			memdata[endereco]=dado_entrada;
	end	
endmodule
//funcionando
/*module teste_memo;

	reg clock,controle_escrita,controle_leitura;
	reg [7:0]endereco,dado_entrada;
	wire [7:0]dado_saida;

	reg[7:0]contador;

	initial begin
		$monitor("memo[%b] = %b :: memo[%b] == %b ::Controle leitura=%b  -  controle escrita=%b",endereco,dado_entrada,endereco,dado_saida,controle_leitura,controle_escrita);
	end

	always begin
		#1 controle_escrita = 1;
		   controle_leitura = 0;
		#1 clock = 0;
		for(contador=0;contador<=10;contador=contador+1)
		begin
			#1 clock = 1;
			   dado_entrada = contador;
			   endereco = contador;
			#1 clock = 0;
		end

		#1 controle_escrita = 0;
		   controle_leitura = 1;
		#1 clock=1;

		for(contador=0;contador<=5;contador=contador+1)
		begin
			#1 clock = 0;
			   endereco = contador;
			#1 clock = 1;
		end
		#1 controle_leitura = 0;

		for(contador=6;contador<=10;contador=contador+1)
		begin
			#1 clock = 0;
			   endereco = contador;
			#1 clock = 1;
		end

		$stop;
	end
	memory teste_memo(clock,endereco,controle_escrita,controle_leitura,dado_entrada,dado_saida);
endmodule
*/
		

		
			

