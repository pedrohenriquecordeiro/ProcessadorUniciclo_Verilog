module control(line,saida_controle);

	input [7:0]line;
	output [12:0] saida_controle;

	reg [11:0] controle;
	// controle[12]=controle ULA GT - controle[11:10]=ControleA - controle[9]=controleB - controle[8]=controleUla - controle[7]=controleEscritaReg - controle[6]=controleEscritaMemo - controle[5]=controleLeituraMemo - 
	// controle[4]=controleJump - controle[3]=controleGoTo - controle[2:1]=controleInputUla - controleHalt[0]=controleHalt
		 	
	assign saida_controle = controle;	

	always @(line) begin 
		case ( line[7:4] )
			4'b0000: controle = 13'b0011010000011; //movfw
			4'b0001: controle = 13'b0100100010001; //jogw
			4'b0010: controle = 13'b0101010000011; //addw
			4'b0011: controle = 13'b0000010000001; //clearw
			4'b0100: controle = 13'b0100101000101; //mtm
			4'b0101: controle = 13'b0100010100101; //mfm
			4'b0110: controle = 13'b0100100010001; //jog
			4'b0111: controle = 13'b0100100010001; //joe
			4'b1000: controle = 13'b0100100010001; //jol
			4'b1001: controle = 13'b0011010000101; //move
			4'b1010: controle = 13'b0101100001101; //gt
			4'b1011: controle = 13'b0100000000000; //end
			4'b1010: controle = 13'b1101100001101; //gtb
			default: controle = 13'b0100000000000; //end
		endcase
	end 
endmodule
//funcionando

/*
module teste_control;

	reg [7:0]line;	
	reg [7:0]contador;
	wire [11:0]saida;

	initial begin
		$monitor("Sinal de controle : %b  Comando : %b",saida,line);
		line = 8'b00001111;
	end

	always begin
		for(contador=15;contador<=207;contador=contador+16)
		begin
			#1 line = contador;
			$display("%d",contador);
		end
		$stop;
	end
	control teste_control(line,saida);
endmodule*/
