module switch_player (
    input wire clk,                 // Clock
    input wire reset,               // Sinal de reset (reinicia para o jogador X)
    input wire valid_move,          // Sinal indicando que uma jogada válida foi feita
    output reg [1:0] current_player // Jogador atual (1 para 'X', 2 para 'O')
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o jogo com o jogador X (1)
            current_player <= 2'b01;
        end else if (valid_move) begin
            // Alterna entre os jogadores 'X' (1) e 'O' (2)
            if (current_player == 2'b01) begin
                current_player <= 2'b10; // Troca para o jogador O
            end else begin
                current_player <= 2'b01; // Troca para o jogador X
            end
        end
    end

endmodule
