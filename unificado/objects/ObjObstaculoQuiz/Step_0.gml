if (!visible) exit;

// Calcula a distância exata da borda deste objeto até a borda do Player
var player_perto = false;
if (instance_exists(Player)) {
    if (distance_to_object(Player) < global.range) {
        player_perto = true;
    }
}

// LÓGICA DE INTERAÇÃO
if (player_perto) {
    
    // Pega o centro horizontal e o topo da máscara para posicionar o balão "E"
    var centro_x = (bbox_left + bbox_right) / 2;
    var topo_y   = bbox_top;
    
    // Desenha o balão "E" centralizado no topo
    if (balao_e == noone) {
        balao_e = instance_create_layer(centro_x, topo_y - 16, "interacao", interacao);
    } else {
        // Atualiza a posição (caso o objeto ou a tela se movam)
        balao_e.x = centro_x;
        balao_e.y = topo_y - 16;
    }
    
    // Se apertar "E", abre o Quiz!
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        var _meu_quiz = instance_create_depth(0, 0, -9999, obj_quiz);
        
        // Passa a identidade da mobília pro quiz!
        _meu_quiz.pergunta_id = meu_quiz_id; 
        
        global.dialogo = true;
    }
    
} else {
    // Se o player se afastou da borda do objeto, deleta o balão
    if (balao_e != noone) {
        instance_destroy(balao_e);
        balao_e = noone;
    }
}