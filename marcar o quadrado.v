module mark_square (
    input wire clk,                   // Clock
    input wire reset,                 // Sinal de reset
    input wire [3:0] cursor,          // Posição do cursor (0 a 8)
    input wire [1:0] player,          // Jogador atual (1 para 'X', 2 para 'O')
    input wire select,                // Sinal para confirmar a marcação
    output reg [1:0] board [0:8],     // Estado atual do tabuleiro
    output reg valid_move             // Indica se a jogada foi válida
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reiniciar o tabuleiro
            integer i;
            for (i = 0; i < 9; i = i + 1) begin
                board[i] <= 2'b00;    // Inicializa todas as posições como vazias (0)
            end
            valid_move <= 0;
        end else if (select) begin
            if (board[cursor] == 2'b00) begin
                // Marcar a posição com o símbolo do jogador atual se estiver vazia
                board[cursor] <= player;
                valid_move <= 1;  // Jogada válida
            end else begin
                // Jogada inválida (posição já ocupada)
                valid_move <= 0;
            end
        end
    end

endmodule
