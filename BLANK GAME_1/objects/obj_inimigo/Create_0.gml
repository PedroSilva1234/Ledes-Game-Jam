/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();

vida = 2;

tempo_estado = room_speed *3;
tempo = tempo_estado;

//variavel de tempo para carregar o ataque
tempo_ataque = room_speed *0.5;

t_ataque = tempo_ataque;

max_velh =5;
tempo_persegue = room_speed *2;
t_persegue = tempo_persegue;

campo_visao = 180;
alvo = noone;

destino_x = 0;
destino_y  = 0;


//função de dettecção do player
olhando = function()
{
	var _player = collision_circle(x,y,campo_visao,obj_player,false,true);
	
	//se o player entrou no campo de visao, sigo ele
	if(_player &&t_persegue<=0)
	{
		estado = "persegue";
		alvo = _player;
		
		
	}
}

controla_estado = function()
{
	//Controlando os estados do inimigo
	switch(estado)
	{
		#region parado
		case "parado":
		
			//diminuindo o tempo de persegue
			if(t_persegue>0)
			{
				t_persegue --;
			}
			//diminuindo o tempo
			tempo--;
			//ele deve ficar parado
		
			velv += gravidade;
			velh =0;
			
			if(tempo<=0)
			{
				//mudando de estado
				estado = choose("parado","andando");
				
				//reseto o tempo
				tempo = tempo_estado;
			}
			
			//Regra para ir para o estagio de persegue
			olhando();
			
		
		break;
		#endregion
		
		
		#region andando
		
		case("andando"):
		
			//Estado de andando
			tempo--;
			
			
			var _dist = point_distance(x,y,destino_x,destino_y);
			//Escolhendo um ponto aleatório da Room
			//Checando se eu ainda não tenho destino
			if(destino_x ==0 or destino_y ==0 or _dist<max_velh * 2){
				
				destino_x = random_range(0, room_width);
				
				destino_y = random_range(0, room_height);
			}
			
			//Andando em direção ao destino
			
			var _dir = point_direction(x,y,destino_x,destino_y);
			
			velh = lengthdir_x(max_velh,_dir);
			
			//velv = lengthdir_y(max_velh,_dir);
			
		
			
			if(tempo<=0)
			{
				tempo = tempo_estado;
				estado= choose("parado","andando","andando");
				destino_x = random_range(0, room_width);
				
				//destino_y = random_range(0, room_height);
			}
		
			
			//Regra para ir para o estagio de persegue
			olhando();
			
			break;
			#endregion
			
			#region persegue
			//perseguir o player
			case"persegue":
			
			
				//image_blend = c_orange;
				
				if(alvo)
				{
					destino_x = alvo.x;
					destino_y = alvo.y;
					
				}
				
				else
				{
					//escolha o proximo estado
					estado = choose("parado","parado","andando");
					
					destino_x = 0; 
				}
				
				var _dir = point_direction(x,y,destino_x,destino_y);
				velh = lengthdir_x(max_velh,_dir);
				
				//Regra para deixar de seguir o player
				
				var _dist = point_distance(x,y,destino_x,destino_y);
				
				if(_dist>campo_visao +70)
				{
					alvo = noone;
					tempo = tempo_estado;
					destino_x = 0;
					destino_y = 0;
				}
				//Checando se estou muito perto do player;
				
				if(_dist <100)
				{
					estado = "carrega_ataque";
					tempo = tempo_estado;
					
				}
				
				break;
				#endregion
				
				
				#region carrega_ataque
				case "carrega_ataque":
				
					t_ataque--;
					velv = 0;
					velh = 0;
					if(t_ataque <=0)
					{
						estado = "ataque";
						t_ataque = tempo_ataque;
					}
				
				break;
				#endregion
				
				#region ataque:
				case "ataque":
				
					//ataquei o , eu reseto o t_persegue
					//Dessa forma eu preciso esperar um tempo para perseguir o player
					t_persegue = tempo_persegue;
					
					
					//Ficando mais rapido
					var _dir = point_direction(x,y,destino_x,destino_y);
					
					velh = lengthdir_x(max_velh*3, _dir);
					velv = lengthdir_y(max_velv*3, _dir);
					
					
					//Se eu cheguei no meu destino eu fico de boa 
					
					var _dist = point_distance(x,y,destino_x,destino_y);
					
					if(_dist<16)
					{
						
						estado = "parado";
					
					}
					
				#endregion
				
					
	}
}