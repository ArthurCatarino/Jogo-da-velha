module navigate_board (
    input wire clk,           // Clock
    input wire reset,         // Sinal de reset
    input wire key_move,      // Sinal para mover o cursor (Key[0])
    input wire key_select,    // Sinal para confirmar a posição (Key[1])
    output reg [3:0] cursor,  // Posição atual do cursor (0 a 8)
    output reg selected       // Indica se a posição foi confirmada
);

    reg [3:0] current_position;  // Posição atual no tabuleiro

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reiniciar a posição do cursor
            current_position <= 4'b0000;  // Começa na posição 0
            selected <= 0;                // Nenhuma posição selecionada
        end else if (key_move) begin
            // Mover o cursor para a próxima posição
            if (current_position < 4'd8) begin
                current_position <= current_position + 1;
            end else begin
                current_position <= 4'd0; // Volta ao início do tabuleiro
            end
        end else if (key_select) begin
            // Confirmar a posição atual
            cursor <= current_position;
            selected <= 1;
        end
    end

endmodule
