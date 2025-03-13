// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function Movimentacao(){
	
	//checando se eu estou no chao
	var _chao = place_meeting(x,y+1,obj_chao);
	
	//movimento
	var _left = keyboard_check(ord("A"))
	
	var _right = keyboard_check(ord("D"))
	
	var _jump = keyboard_check_pressed(ord("K"));
	
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
	
	velh = 0;//variavel da velocidade do player horizontal
	
	velv= 0;//variavel da velocidade do player vertical
	
	max_velh = 8;//valor max da velocidade do player horizontal
	
	max_velv= 15;//valor max da velocidade do player horizontal
	
	qtd_tiros = 3;
	
	tiro_danos = 1; 
	
	
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
	
	
	var _tiro = keyboard_check_pressed(ord("L"));
	
	if(_tiro){
		
		if(qtd_tiros ==0)
		{
			qtd_tiros = 3;
			
		}
		
		else{
		qtd_tiros -=1;
		
		var t = instance_create_layer(x,y,layer,obj_tiro);
		t.speed = max_velv;
		t.direction = 180 *face;
	}
		
}

	

	
	
}


function destruir_obj()
{
	instance_destroy();
}