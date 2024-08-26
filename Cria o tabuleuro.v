module vga_board (
    input wire clk,                    // Clock
    input wire reset,                  // Sinal de reset
    input wire [9:0] hcount,           // Contador horizontal (posição x do pixel)
    input wire [9:0] vcount,           // Contador vertical (posição y do pixel)
    input wire blank,                  // Indica se estamos dentro da área visível
    output reg [3:0] VGA_R,            // Sinal de cor vermelho
    output reg [3:0] VGA_G,            // Sinal de cor verde
    output reg [3:0] VGA_B             // Sinal de cor azul
);

    // Parâmetros do tabuleiro
    parameter BOARD_SIZE = 200;        // Tamanho do tabuleiro (em pixels)
    parameter LINE_WIDTH = 4;          // Largura das linhas do tabuleiro (em pixels)
    parameter SCREEN_WIDTH = 640;      // Largura da tela VGA
    parameter SCREEN_HEIGHT = 480;     // Altura da tela VGA

    // Calcula as posições iniciais e finais das linhas do tabuleiro
    wire [9:0] left = (SCREEN_WIDTH - BOARD_SIZE) / 2;
    wire [9:0] right = left + BOARD_SIZE;
    wire [9:0] top = (SCREEN_HEIGHT - BOARD_SIZE) / 2;
    wire [9:0] bottom = top + BOARD_SIZE;

    // Coordenadas das linhas verticais
    wire [9:0] vline1 = left + BOARD_SIZE / 3;
    wire [9:0] vline2 = left + 2 * BOARD_SIZE / 3;

    // Coordenadas das linhas horizontais
    wire [9:0] hline1 = top + BOARD_SIZE / 3;
    wire [9:0] hline2 = top + 2 * BOARD_SIZE / 3;

    always @(posedge clk) begin
        if (reset) begin
            // Se estiver resetado, limpa a tela
            VGA_R <= 4'b0000;
            VGA_G <= 4'b0000;
            VGA_B <= 4'b0000;
        end else if (!blank) begin
            // Dentro da área visível
            // Verifica se estamos nas áreas das linhas verticais
            if ((hcount >= vline1 - LINE_WIDTH / 2 && hcount <= vline1 + LINE_WIDTH / 2 && vcount >= top && vcount <= bottom) ||
                (hcount >= vline2 - LINE_WIDTH / 2 && hcount <= vline2 + LINE_WIDTH / 2 && vcount >= top && vcount <= bottom)) begin
                VGA_R <= 4'b1111;  // Desenha a linha vertical com cor branca
                VGA_G <= 4'b1111;
                VGA_B <= 4'b1111;
            end
            // Verifica se estamos nas áreas das linhas horizontais
            else if ((vcount >= hline1 - LINE_WIDTH / 2 && vcount <= hline1 + LINE_WIDTH / 2 && hcount >= left && hcount <= right) ||
                     (vcount >= hline2 - LINE_WIDTH / 2 && vcount <= hline2 + LINE_WIDTH / 2 && hcount >= left && hcount <= right)) begin
                VGA_R <= 4'b1111;  // Desenha a linha horizontal com cor branca
                VGA_G <= 4'b1111;
                VGA_B <= 4'b1111;
            end else begin
                // Caso contrário, não desenha nada (fundo preto)
                VGA_R <= 4'b0000;
                VGA_G <= 4'b0000;
                VGA_B <= 4'b0000;
            end
        end else begin
            // Fora da área visível (sincronização)
            VGA_R <= 4'b0000;
            VGA_G <= 4'b0000;
            VGA_B <= 4'b0000;
        end
    end

endmodule
