// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function Movimentacao(){
	
	//checando se eu estou no chao
	var _chao = place_meeting(x,y+1,obj_chao);
	
	//movimento
	var _left = keyboard_check(ord("A"))
	
	var _right = keyboard_check(ord("D"))
	
	var _jump = keyboard_check_pressed(vk_space);


	//aplicando controle ao movimento
	velh  = (_right - _left)*max_velh; //velocidade horizontal
	
	//aplicando gravidade
	velv += gravidade;
	
	
	//limitando a gravidade
	if(velv > max_velv)
	{
		velv = clamp(velv,-max_velv,max_velv*2);
	}
	//Pulando
	if(_jump && _chao)
	{
		velv -= max_velv;
	}
	
}
function Create_ent()
{	
	gravidade = 0.5;//variavel da velocidade da gravidade
	
	//Velocidades
	velh = 0;//variavel da velocidade do player horizontal
	
	velv= 0;//variavel da velocidade do player vertical
	
	//Limite de velocidades
	
	max_velh = 8;//horizontal
	
	max_velv= 15;// vertical
	
	estado = "parado";
	debug = false;
}


function Create_prot(){
	
	
	
	//Variaveis de atirar e recarregar
	
	qtd_tiros = 3; //quantidade de tiros do player
	
	tiro_danos = 1;  //dano do tiro 
	max_tiros = 3;          // Capacidade máxima do carregador
    recarregar = false;     // Estado de recarga
    tempo_recarregar = 0;   // Contador para recarga
	
	
	vida = 3; //vida do player
	
	invulnerabilidade = false; //variavel que deffine se o player tomou dano recentemente
	
	//Variavéis de controle
	

	
}




function colisao()
{
	//Sistema de colisao horizontal
	repeat(abs(velh))
	{
		var _velh = sign(velh);
		
		if(place_meeting(x +_velh,y,obj_chao))
		{
		
		//Você vai parar	
		velh = 0;
		
		//Saindo do laço
		break;
		}
		else //Nao bati na parede
		{ 
			x += _velh; //Posso me mover
			
		}
		
	}
	
	//Colisao vertical
	repeat(abs(velv))
	{
		var _velv = sign(velv);
		
		//se vc esta no chao
		if(place_meeting(x, y+ _velv, obj_chao))
		{
			//Pare
			velv = 0;
			break;
		}
		
		else
		{
			//senao, aplica gravvidade
			y += _velv;
		}
	}
	
	
} 


//-----------------------------Funções para movimento do inimigo
function muda_estado()
{
	
}

/*controla_estado = function()
{
	//Controlando os estados do inimigo
	switch(estado)
	{
		#region parado
		case "parado":
			//diminuindo o tempo
			tempo--;
			//ele deve ficar parado
		
			velv = 0;
			velh =0;
			
			if(tempo<=0)
			{
				//mudando de estado
				estado = choose("parado","andando");
				
				//reseto o tempo
				tempo = tempo_estado;
			}
			
		
		break;
		#endregion
		
		
		#region andando
		
		case("andando"):
		
			//Estado de andando
			tempo--;
			
			//Escolhendo um ponto aleatório da Room
			//Checando se eu ainda não tenho destino
			if(destino_x ==0 or destino_y ==0){
				
				destino_x = random_range(0, room_width);
				
				destino_y = random_range(0, room_height);
			}
			
			//Andando em direção ao destino
			
			var _dir = point_direction(x,y,destino_x,destino_y);
			
			velh = lengthdir_x(max_vel,_dir);
			velv = lengthdir_y(max_vel, _dir);
			
			break;
			#endregion
	}
}
*/

function movimento_inimigo()
{
	
	
	
	
}



//-----------------------------------------------------------FUNÇÕES DE AÇÕOES DO PERSONAGEM
function atirar()
{
	//checa a direção do player
	var _left = keyboard_check(ord("A"))
	
	var _right = keyboard_check(ord("D"))
	
	face = _right - _left; // Define a direção do tiro baseado no movimento
	
	if(_left)
	{
		face = 1;
	}
	
	if(_right)
	{
		face = 0;
	}
	
	
	var _tiro = keyboard_check_pressed(ord("L")); //checa se o player deu um tiro
	
	if(_tiro && !recarregar && qtd_tiros > 0){
	
		qtd_tiros -=1;//diminui uma bala
		
		var t = instance_create_layer(x,y,layer,obj_tiro);//dá o tiro
		t.speed = max_velv; //velocidade do tiro
		t.dano = 1;//dano do tiro
		t.direction = 180 *face; //define a direção em que o tiro vai sair, esquerda ou direita
		
		if(qtd_tiros<=0)
		{
			recarregar = true;
			tempo_recarregar = 180;
		}
		
		
	}

}

function cura() //função que recupera a vida  do player se ele pegar um coração
{
	
	vida = 3;
}


function reload()//função para recarga da arma do player
{
	var _reload = keyboard_check_pressed(ord("R")); //botao de reload
	
	//inicia recarga manual
	if(_reload && !recarregar &&qtd_tiros<max_tiros)
	{
		recarregar = true;
		tempo_recarregar = 180;// 3 segundos
		
	}
	//draw_set_color(c_white);
	//draw_text(x,y-50, "Balas: "+string(qtd_tiros))
	if(recarregar)
	{
		//draw_text(x,y-30,"Recarregandoo...")
		tempo_recarregar -=1;
		
		if(tempo_recarregar <=0 )
		{
			recarregar = false;
			qtd_tiros = max_tiros;
			
		}
	}
	
	
}

function dano() //checa se o obj zerou a vida, se zerar delete-o
{
	
	
	if(vida<=0)
	{
		destruir_obj();
		
		if(obj_player == ev_destroy)
		{
			room_goto(rm_start);
		}
		
	}
	
	
	
	
} 

function imortal() //função para invulnerabilidade do player após tomar dano
{
	if(invulnerabilidade){
		alarm[0]-=1;
	
		if(alarm[0]<=0)
		{
			invulnerabilidade = false;
		}
	
	}
	
}


function destruir_obj() //funcao de destruir objetos
{
	instance_destroy();
}