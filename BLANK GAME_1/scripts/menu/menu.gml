// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function menu(){
// Define a cor do texto
draw_set_color(c_white);

// Define um espaçamento entre as linhas
var espaco = 30;

// Define a posição inicial do menu
var start_x = room_width / 2 - 50;
var start_y = room_height / 3;

// Desenha o título do jogo
draw_set_halign(fa_center);
//draw_set_valign(fa_center);
draw_text(start_x, start_y, "Project K.R.L");

// Posições Y das opções
var opcao_jogar_y = start_y + espaco * 2;
var opcao_como_y = start_y + espaco * 3;
var opcao_creditos_y = start_y + espaco * 4;

// Desenha as opções do menu
draw_text(start_x, opcao_jogar_y, "Pressione ENTER para jogar");
draw_text(start_x, opcao_como_y, "Como Jogar");
draw_text(start_x, opcao_creditos_y, "Créditos");

// Verifica se o mouse está sobre uma opção e desenha um retângulo ao redor
if (mouse_y > opcao_jogar_y - 10 && mouse_y < opcao_jogar_y + 10) {
    draw_set_color(c_yellow);  // Cor para destaque de "Jogar"
    draw_rectangle(start_x - 20, opcao_jogar_y - 10, start_x + 200, opcao_jogar_y + 10, false);
    draw_set_color(c_white);  // Reseta a cor para branco

    // Verifica se o mouse clicou na opção "Jogar"
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(Room1);  // Troca para a room do jogo
    }
}
if (mouse_y > opcao_como_y - 10 && mouse_y < opcao_como_y + 10) {
    draw_set_color(c_yellow);  // Cor para destaque de "Como Jogar"
    draw_rectangle(start_x - 20, opcao_como_y - 10, start_x + 200, opcao_como_y + 10, false);
    draw_set_color(c_white);  // Reseta a cor para branco

    // Verifica se o mouse clicou na opção "Como Jogar"
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(Room2);  // Troca para a room de "Como Jogar"
    }
}
if (mouse_y > opcao_creditos_y - 10 && mouse_y < opcao_creditos_y + 10) {
    draw_set_color(c_yellow);  // Cor para destaque de "Créditos"
    draw_rectangle(start_x - 20, opcao_creditos_y - 10, start_x + 200, opcao_creditos_y + 10, false);
    draw_set_color(c_white);  // Reseta a cor para branco

    // Verifica se o mouse clicou na opção "Créditos"
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(Room3);  // Troca para a room de "Créditos"
    }
}
}