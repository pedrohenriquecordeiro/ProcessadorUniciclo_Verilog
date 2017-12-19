module mux_gt(controle_gt,soma_1_mux_gt,soma_2_mux_gt,saida_mux_gt);

	input controle_gt;
	input [7:0]soma_1_mux_gt,soma_2_mux_gt;
	output [7:0]saida_mux_gt;  //saida para o PC
	reg [7:0]temp;

	assign saida_mux_gt = temp;

	always @(controle_gt,soma_1_mux_gt,soma_2_mux_gt)begin
		if(controle_gt)
			temp = soma_2_mux_gt; // saida do somador_gt
		else
			temp = soma_1_mux_gt; // saida do somador_jump
	end
endmodule 

module mux_jump(bloco_controle,saida_mux_jump);

	input bloco_controle;
	output [7:0]saida_mux_jump;
	reg [7:0]temp;

	assign saida_mux_jump = temp;

	always @(bloco_controle)begin
		if(bloco_controle)
			temp = 8'b00000010;
		else
			temp = 8'b00000001;
	end
endmodule

module mux_a(controle_a,entrada_1_mux_a,entrada_2_mux_a,entrada_3_mux_a,saida_mux_a);

	input [1:0] controle_a;
	input [3:0] entrada_1_mux_a;
	input [7:0] entrada_2_mux_a,entrada_3_mux_a;
	output [7:0] saida_mux_a;
	reg [7:0]temp;

	assign saida_mux_a = temp;

	always @(controle_a,entrada_1_mux_a,entrada_2_mux_a,entrada_3_mux_a) begin
		case(controle_a)
			2'b00 : temp = entrada_1_mux_a;  // valor vindo da instrução
			2'b01 : temp = entrada_2_mux_a;  // valor vindo da ULA
			2'b10 : temp = entrada_3_mux_a;  // valor vindo da Memoria
		endcase
	end
endmodule

module demux_b(controle_b,entrada_demux_b,saida_1_demux_b,saida_2_demux_b);

	input controle_b;
	input [7:0] entrada_demux_b;
	output [7:0] saida_1_demux_b,saida_2_demux_b;
	reg [7:0]temp_1,temp_2;

	assign saida_1_demux_b = temp_1;
	assign saida_2_demux_b = temp_2;

	always@(controle_b,entrada_demux_b)begin
		if(controle_b)
			temp_1 = entrada_demux_b;  // valor para banco de registradores
		else
			temp_2 = entrada_demux_b;  // valor para a Memoria
	end
endmodule

module mux_ula(controle_input_ula,entrada_1_demux_ula,entrada_2_demux_ula,saida_demux_ula);

	input [1:0]controle_input_ula;
	input [7:0] entrada_1_demux_ula;
	input [3:0] entrada_2_demux_ula;
	output [7:0] saida_demux_ula;
	reg [7:0] temp;

	assign saida_demux_ula = temp;

	always@(controle_input_ula,entrada_1_demux_ula,entrada_2_demux_ula)begin
		case(controle_input_ula)
			2'b00 : temp = entrada_1_demux_ula; // valor vindo do banco de resgistrador
			2'b01 : temp = entrada_2_demux_ula; // valor vindo da instrução
			2'b10 : temp = 0;
		endcase
	end
endmodule

module demux_halt(controle_halt,entrada_demux_halt,saida_1_demux_halt,saida_2_demux_halt);

	input controle_halt;
	input [7:0] entrada_demux_halt;
	output [7:0] saida_1_demux_halt,saida_2_demux_halt;
	reg [7:0]temp_1,temp_2;

	assign saida_1_demux_halt = temp_1;
	assign saida_2_demux_halt = temp_2;
	

	always@(controle_halt,entrada_demux_halt) begin
		if(controle_halt)
			temp_2 = entrada_demux_halt; //halt ligado
		else
			temp_1 = 0;   // halt desligado
	end
endmodule

module ULA_GT(controle,valor1_somador_gt,valor2_somador_gt,saida_somador_gt);
	input controle;
	input [7:0]valor1_somador_gt;
	input [3:0]valor2_somador_gt;
	output [7:0]saida_somador_gt;
	reg [7:0]temp;

	assign saida_somador_gt = temp;

	always@(valor1_somador_gt,valor2_somador_gt) begin
		if(controle)
			temp = valor1_somador_gt - valor2_somador_gt;  //sub
		else
			temp = valor1_somador_gt + valor2_somador_gt;  //add
	end
endmodule

module somador_jump(valor1_somador_jump,valor2_somador_jump,saida_somador_jump);

	input [7:0]valor1_somador_jump,valor2_somador_jump;
	output [7:0]saida_somador_jump;
	reg [7:0] temp;

	assign saida_somador_jump = temp;

	always @(valor1_somador_jump,valor2_somador_jump)begin
		temp = valor1_somador_jump + valor2_somador_jump;
	end
endmodule

module bloco_controle(zero,neg,controle_jumps,saida_bloco_controle);

	input zero,neg,controle_jumps;
	output saida_bloco_controle;
	reg temp;

	assign saida_bloco_controle = temp;

	always@(zero or neg or controle_jumps) begin
		temp = controle_jumps & (~zero | ~neg);
	end

endmodule





