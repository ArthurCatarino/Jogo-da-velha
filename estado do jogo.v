module check_game_state (
    input wire [1:0] board [0:8],  // Estado atual do tabuleiro (matriz 3x3 linearizada)
    output reg [1:0] winner,       // Indica o vencedor (0: nenhum, 1: X, 2: O)
    output reg game_over,          // Indica se o jogo acabou (1: sim, 0: não)
    output reg draw                // Indica se o jogo deu velha (1: sim, 0: não)
);

    always @(*) begin
        // Inicializa os sinais
        winner = 2'b00;
        game_over = 0;
        draw = 0;

        // Verifica linhas
        if (board[0] != 0 && board[0] == board[1] && board[1] == board[2]) begin
            winner = board[0];
        end else if (board[3] != 0 && board[3] == board[4] && board[4] == board[5]) begin
            winner = board[3];
        end else if (board[6] != 0 && board[6] == board[7] && board[7] == board[8]) begin
            winner = board[6];
        end

        // Verifica colunas
        else if (board[0] != 0 && board[0] == board[3] && board[3] == board[6]) begin
            winner = board[0];
        end else if (board[1] != 0 && board[1] == board[4] && board[4] == board[7]) begin
            winner = board[1];
        end else if (board[2] != 0 && board[2] == board[5] && board[5] == board[8]) begin
            winner = board[2];
        end

        // Verifica diagonais
        else if (board[0] != 0 && board[0] == board[4] && board[4] == board[8]) begin
            winner = board[0];
        end else if (board[2] != 0 && board[2] == board[4] && board[4] == board[6]) begin
            winner = board[2];
        end

        // Se há um vencedor, o jogo acaba
        if (winner != 2'b00) begin
            game_over = 1;
        end else begin
            // Verifica se todas as posições estão preenchidas para determinar empate (velha)
            if (board[0] != 0 && board[1] != 0 && board[2] != 0 &&
                board[3] != 0 && board[4] != 0 && board[5] != 0 &&
                board[6] != 0 && board[7] != 0 && board[8] != 0) begin
                draw = 1;
                game_over = 1;
            end
        end
    end

endmodule
