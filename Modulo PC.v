module PC(clock,incremento,saida_pc);
input clock;
input [6:0]incremento;  	//tamanho do salto
output [7:0]saida_pc;	
reg [7:0]valor;			//valor atual de PC
assign saida_pc=valor;
always begin
@(negedge clock)
valor=incremento;  	//escreve
end
endmodule

module teste_pc;
reg t_clock;
reg [6:0] t_incremento;
wire [7:0] t_saida_pc;
initial begin
$monitor("Ciclo:[%0d] Saida de PC:<%b>  Clock:{%b} Incremento:(%b)",$time,t_saida_pc,t_clock,t_incremento);
t_clock=1;
t_incremento=7'b0000000;
end
initial begin
#10 $stop;
end
always begin
#1 
t_incremento=7'b0000001;
t_clock=~t_clock;
#1 
t_clock=~t_clock;
#1
t_incremento = 7'b0000010;
t_clock=~t_clock;
#1
t_clock=~t_clock;
#1
t_incremento = 7'b0000101;
t_clock=~t_clock;
#1
t_clock=~t_clock;
end
PC t_PC(t_clock,t_incremento,t_saida_pc);
endmodule
