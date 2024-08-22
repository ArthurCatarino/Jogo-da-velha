module game_logic (
    input wire clk,                 // Clock
    input wire reset,               // Sinal de reset do jogo
    input wire [1:0] player_input,  // Sinal do jogador atual (1 para X, 2 para O)
    input wire [3:0] pos,           // Posição selecionada (0 a 8)
    output reg [8:0] board,         // Estado atual do tabuleiro
    output reg [1:0] winner,        // Estado do vencedor (0: nenhum, 1: X, 2: O)
    output reg game_over            // Sinaliza se o jogo acabou (1: sim, 0: não)
);

    reg [2:0] win_conditions [0:7]; // Condições de vitória (três em linha)

    initial begin
        // Inicializando as condições de vitória (três em linha, coluna ou diagonal)
        win_conditions[0] = 3'b000; // Linha 0
        win_conditions[1] = 3'b001; // Linha 1
        win_conditions[2] = 3'b010; // Linha 2
        win_conditions[3] = 3'b100; // Coluna 0
        win_conditions[4] = 3'b101; // Coluna 1
        win_conditions[5] = 3'b110; // Coluna 2
        win_conditions[6] = 3'b111; // Diagonal principal
        win_conditions[7] = 3'b011; // Diagonal secundária
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reiniciar o estado do jogo
            board <= 9'b000000000; // Tabuleiro vazio
            winner <= 2'b00;       // Sem vencedor
            game_over <= 0;        // Jogo não acabou
        end else if (!game_over) begin
            if (board[pos] == 0) begin
                // Marcar a posição com o jogador atual
                board[pos] <= player_input;

                // Verificar vitória
                integer i;
                for (i = 0; i < 8; i = i + 1) begin
                    if ((board[win_conditions[i][0]] == player_input) && 
                        (board[win_conditions[i][1]] == player_input) && 
                        (board[win_conditions[i][2]] == player_input)) begin
                        winner <= player_input;
                        game_over <= 1;
                    end
                end

                // Verificar empate (tabuleiro cheio)
                if (&board) begin
                    winner <= 2'b11; // Indicar empate
                    game_over <= 1;
                end
            end
        end
    end
endmodule
