module ULA(controle_ula,a,b,saida_ula,zero,negativo);

	input controle_ula;   			//entrada de controle da ULA
	input [7:0] a,b; 			//valores de entrada para ser operados na ULA
	output [7:0] saida_ula;  		//resultado da operação feita na ULA
	reg [7:0] resultado;
	output zero; 
	output negativo;  			 
	assign zero=(resultado==0); 		//valor 1 se determinada operação ser igual a zero,valor 0 se resultado for igual a algo diferente de zero
	assign negativo=( (controle_ula == 1) && (resultado>a) );
	assign saida_ula=resultado;

	always @(controle_ula,a,b) begin
		case(controle_ula)
			0:resultado=a+b;
			1:resultado=a-b;
			default:resultado=8'b00000000;
		endcase
	end

endmodule



module t_ula;
reg controle_ula;
reg [7:0] a,b;
wire zero,negativo;
wire [7:0]saida;

initial begin
	$monitor("Time<%0d> A(%b)e B(%b)=%b Neg:%b Zero:%b C=%b",$time,a,b,saida,negativo,zero,controle_ula);
end

always begin
	#1
		controle_ula = 0;
	#1
		a=8'b00001111;
		b=8'b00000001;
	#1
		controle_ula=1;
	#1	
		a=8'b00000111;
		b=8'b00000001;
	#1
		a=8'b10001111;
		b=8'b00001111;
	#1
		a=8'b00001111;
		b=8'b00001111;
	#1
		a=8'b00000011;
		b=8'b10000000;
		$stop;
end
ULA t_ula(controle_ula,a,b,saida,zero,negativo);
endmodule
