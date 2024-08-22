module reset_game (
    input wire clk,                   // Clock
    input wire reset,                 // Sinal de reset (SW[0])
    output reg [1:0] board [0:8],     // Estado atual do tabuleiro
    output reg [1:0] current_player,  // Jogador atual (1 para 'X', 2 para 'O')
    output reg [1:0] winner,          // Indica o vencedor (0: nenhum, 1: X, 2: O)
    output reg game_over              // Indica se o jogo acabou (1: sim, 0: não)
);

    // Processo de reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reiniciar o tabuleiro
            integer i;
            for (i = 0; i < 9; i = i + 1) begin
                board[i] <= 2'b00;  // Inicializa todas as posições como vazias (0)
            end

            // Reiniciar o jogador atual
            current_player <= 2'b01;  // Começa com o jogador X (1)

            // Reiniciar o estado do vencedor
            winner <= 2'b00;          // Sem vencedor

            // Reiniciar o estado de game over
            game_over <= 0;           // Jogo não acabou
        end
    end

endmodule
