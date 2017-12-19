module banco_reg(code,datawrite,controleEscritaReg,clock,saida1_reg,saida2_reg);

	input clock;
	input [7:0] code;
	input controleEscritaReg;
	input [7:0] datawrite;
	output [7:0] saida1_reg;
	output [7:0] saida2_reg;

	reg [7:0] registrador[0:4];
	//regis[0] = R0
	// ...
	//regis[4] = WORK

	reg [7:0] temp1;
	reg [7:0] temp2;

	assign saida1_reg=temp1;
	assign saida2_reg=temp2;

	initial begin
		registrador[0]=8'b00000000;
		registrador[1]=8'b00000000;
		registrador[2]=8'b00000000;    // é o registrado que no codigo recebe o valor do maior numero da sequencia
		registrador[3]=8'b00000001;    // é o registrado que no codigo recebe o valor do menor numero da sequencia
		registrador[4]=8'b00000000;    // WORK
	end

	always @(posedge clock) begin //escrita
		if(controleEscritaReg)
			case(code[7:4])
				4'b0000 : registrador[code[1:0]] = registrador[4]; //movfw
				
				4'b0011 : registrador[4] = datawrite;  //clearw
				
				4'b0100 : registrador[code[1:0]] = datawrite; //mfm 
	
				4'b1001 : registrador[code[3:2]] = registrador[code[1:0]]; //move

				4'b0010 : registrador[4] = datawrite;         //addw
			endcase
	end

	always @(negedge clock) begin //leitura
		case(code[7:4])
			4'b0001:  begin
				  temp1 = registrador[code[1:0]]; // jogw
				  temp2 = registrador[4];
				  end
			
			4'b0101:  temp1 = registrador[code[1:0]]; //mtm
			
			4'b0110:  begin
				  temp1 = registrador[code[3:2]]; // jog 
				  temp2 = registrador[code[1:0]];
				  end

			4'b0111:  begin
				  temp1 = registrador[code[3:2]]; // joe 
				  temp2 = registrador[code[1:0]]; 
				  end

			4'b1000:  begin
				  temp1 = registrador[code[3:2]];  // jol
				  temp2 = registrador[code[1:0]];  
				  end

			4'b0010 : temp1 = registrador[4] ;    // addw

			default: begin
				 temp1 = 8'bzzzzzzzz;
				 temp2 = 8'bzzzzzzzz;
				 end
		endcase
	end
endmodule	
	//funcionando	
/*	
module teste_banco;

	reg [7:0]code,datawrite;
	reg controle_escrita,clock;
	wire [7:0]saida1,saida2;

	reg [7:0] apontador;

	initial begin
		$monitor("code<%b> datawrite:<%b> escrita:<%b> SAIDA1:[%b} SAIDA2:[%b}",code,datawrite,controle_escrita,saida1,saida2);
	end

	always begin
		#1
			controle_escrita = 1;
			clock=0;
		#1
			clock=1;
			code = 8'b00101111; //w = 0100
		#1
			clock = 0;
		#1
			clock = 1;
			code = 8'b00000000; // r0 = 0100
		#1
			clock=0;
		#1
			clock = 1;
			code = 8'b00000010; // r2 = 0100
		#1
			clock = 0;
		#1
			clock = 1;
			code = 8'b10010100;  //r1=r0=0100
		#1
			clock = 0;
		#1
			clock = 1;
			code = 8'b01000011;  //r3 = datawrite
			datawrite = 8'b11110000;
		#1
			clock = 0;
		#1
			clock = 1;
			code = 8'b00110000;  //clear no w
		#1
			clock = 0;
			controle_escrita = 0;
		#1
			clock = 1;
		#1
			clock=0;
			code = 8'b00010000; // expoem w e r0 w=0 e que o r0=0100
		#1
			clock = 1;
		#1
			clock = 0;
			code = 8'b01010001; //expoem r1 r1=0100
		#1
			clock = 1;
		#1
			clock = 0;
			code = 8'b10001011; // expoem r2 e r3 r2 = 0100 r3=11110000
		#1
			$stop;
	end
	banco_reg teste_banco(code,datawrite,controle_escrita,clock,saida1,saida2);
endmodule*/
			
			

