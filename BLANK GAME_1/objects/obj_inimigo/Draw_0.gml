/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
draw_self();


if(debug)
{
	draw_text(x,y-sprite_height,estado);
	
	
	draw_circle(destino_x,destino_y,16,false);
	
	draw_circle(x,y,campo_visao,true);
}