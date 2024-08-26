module draw_xo (
    input wire clk,                    // Clock
    input wire reset,                  // Sinal de reset
    input wire [9:0] hcount,           // Contador horizontal (posição x do pixel)
    input wire [9:0] vcount,           // Contador vertical (posição y do pixel)
    input wire blank,                  // Indica se estamos dentro da área visível
    input wire [8:0] board_state,      // Estado atual do tabuleiro (3x3 = 9 bits)
    output reg [3:0] VGA_R,            // Sinal de cor vermelho
    output reg [3:0] VGA_G,            // Sinal de cor verde
    output reg [3:0] VGA_B             // Sinal de cor azul
);

    // Parâmetros de layout do tabuleiro
    parameter CELL_SIZE = 66;          // Tamanho de cada célula do tabuleiro (em pixels)
    parameter LINE_WIDTH = 4;          // Largura das linhas do tabuleiro
    parameter X_COLOR = 4'b1111;       // Cor do X (branco)
    parameter O_COLOR = 4'b1111;       // Cor do O (branco)
    parameter BACKGROUND = 4'b0000;    // Cor de fundo (preto)
    
    // Coordenadas das células do tabuleiro
    integer i;
    reg draw;
    
    // Função para desenhar um X
    function draw_X;
        input [9:0] x, y;
        input [9:0] x_offset, y_offset;
        draw_X = ((x - x_offset) == (y - y_offset)) || ((x - x_offset) == (CELL_SIZE - 1 - (y - y_offset)));
    endfunction
    
    // Função para desenhar um O
    function draw_O;
        input [9:0] x, y;
        input [9:0] x_offset, y_offset;
        draw_O = (((x - x_offset) - CELL_SIZE / 2) * ((x - x_offset) - CELL_SIZE / 2) + 
                  ((y - y_offset) - CELL_SIZE / 2) * ((y - y_offset) - CELL_SIZE / 2) <= 
                  (CELL_SIZE / 2 - LINE_WIDTH) * (CELL_SIZE / 2 - LINE_WIDTH)) &&
                 (((x - x_offset) - CELL_SIZE / 2) * ((x - x_offset) - CELL_SIZE / 2) + 
                  ((y - y_offset) - CELL_SIZE / 2) * ((y - y_offset) - CELL_SIZE / 2) >= 
                  (CELL_SIZE / 2 - LINE_WIDTH - 2) * (CELL_SIZE / 2 - LINE_WIDTH - 2));
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            // Se estiver resetado, limpa a tela
            VGA_R <= BACKGROUND;
            VGA_G <= BACKGROUND;
            VGA_B <= BACKGROUND;
        end else if (!blank) begin
            draw = 0;
            // Itera sobre cada célula do tabuleiro
            for (i = 0; i < 9; i = i + 1) begin
                // Calcula as coordenadas de origem de cada célula
                integer x_offset = (i % 3) * CELL_SIZE;
                integer y_offset = (i / 3) * CELL_SIZE;
                
                if (board_state[i] == 1) begin
                    // Desenha X na célula i
                    if (draw_X(hcount, vcount, x_offset, y_offset)) begin
                        draw = 1;
                        VGA_R <= X_COLOR;
                        VGA_G <= X_COLOR;
                        VGA_B <= X_COLOR;
                    end
                end else if (board_state[i] == 2) begin
                    // Desenha O na célula i
                    if (draw_O(hcount, vcount, x_offset, y_offset)) begin
                        draw = 1;
                        VGA_R <= O_COLOR;
                        VGA_G <= O_COLOR;
                        VGA_B <= O_COLOR;
                    end
                end
            end
            // Se não estiver desenhando, o pixel é preto
            if (!draw) begin
                VGA_R <= BACKGROUND;
                VGA_G <= BACKGROUND;
                VGA_B <= BACKGROUND;
            end
        end else begin
            // Fora da área visível (sincronização)
            VGA_R <= BACKGROUND;
            VGA_G <= BACKGROUND;
            VGA_B <= BACKGROUND;
        end
    end

endmodule
