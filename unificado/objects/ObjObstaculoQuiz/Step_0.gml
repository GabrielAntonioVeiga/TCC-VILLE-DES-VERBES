//efeito grafico que faz um "E" aparecer e desaparecer a cima  do objeto para indicar a interação
if (collision_circle(x, y, global.range, Player, false, true)) {
    if (balao_e == noone) {
        balao_e = instance_create_layer(x, y, "interacao", interacao);
   
		var largura_balao = balao_e.sprite_width;
		var altura_balao = balao_e.sprite_height;
    
		balao_e.x = x + (sprite_width / 2) - sprite_xoffset - (largura_balao / 2) + balao_e.sprite_xoffset;
		balao_e.y = bbox_top - altura_balao - 20; 
    }
} else {
    if (balao_e != noone) {
        instance_destroy(balao_e);
        balao_e = noone;
    }
}
