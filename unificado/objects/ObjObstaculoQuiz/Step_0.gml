if (!visible) exit;

if (collision_circle(x, y, global.range, Player, false, true)) {
    
    // Desenha o balão "E"
    if (balao_e == noone) {
        balao_e = instance_create_layer(x, y, "interacao", interacao);
        // ... (resto do seu código de alinhar o balão) ...
    }
    
    // Se apertar "E", abre o Quiz!
    if (keyboard_check_pressed(ord("E")) && global.dialogo == false && !instance_exists(obj_quiz) && !instance_exists(Dialogo)) {
        
        var _meu_quiz = instance_create_depth(0, 0, -9999, obj_quiz);
        
        // Passa a identidade da mobília pro quiz!
        _meu_quiz.pergunta_id = meu_quiz_id; 
        
        global.dialogo = true;
    }
    
} else {
    if (balao_e != noone) {
        instance_destroy(balao_e);
        balao_e = noone;
    }
}