// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function Movimentacao(){
	
	//checando se eu estou no chao
	var _chao = place_meeting(x,y+1,obj_chao);
	
	//movimento
	var _left = keyboard_check(ord("A"))
	
	var _right = keyboard_check(ord("D"))
	
	var _jump = keyboard_check_pressed(vk_space);
	
	var _reload = keyboard_check_pressed(ord("R")); //bootao de reload


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

function Create_prot(){
	
	gravidade = 0.5;//variavel da velocidade da gravidade
	
	//Velocidades
	velh = 0;//variavel da velocidade do player horizontal
	
	velv= 0;//variavel da velocidade do player vertical
	
	//Limite de velocidades
	
	max_velh = 8;//horizontal
	
	max_velv= 15;// vertical
	
	
	qtd_tiros = 3; //quantidade de tiros do player
	
	tiro_danos = 1;  //dano do tiro 
	
	vida = 3;
	
	recarregar = false;
	
	tempo_recarregar = 60;
	
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
	
	if(_tiro){
		
		if(qtd_tiros ==0)
		{
			qtd_tiros = 3;
			
		}
		
		else{
		qtd_tiros -=1;//diminui uma bala
		
		var t = instance_create_layer(x,y,layer,obj_tiro);//dá o tiro
		t.speed = max_velv; //velocidade do tiro
		t.dano = 1;//dano do tiro
		t.direction = 180 *face; //define a direção em que o tiro vai sair, esquerda ou direita
		
		}
		
	}

}


function dano() //checa se o obj morreu, se morreu delete-o
{
	
	if(vida<=0)
	{
		destruir_obj();
		
	}
	
	
} 


function destruir_obj() //funcao de destruir objetos
{
	instance_destroy();
}