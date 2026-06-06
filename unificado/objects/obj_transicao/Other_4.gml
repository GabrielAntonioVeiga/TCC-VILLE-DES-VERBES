// Esse código roda ASSIM QUE a nova sala carrega
if (source_room != -1 && (target_x == -1 || target_y == -1)) {
    var found_porta = noone;
    
    // Procura na NOVA sala uma porta que aponte de volta para a sala de onde viemos
    with (obj_porta) {
        if (target_room == other.source_room) {
            found_porta = id;
            break;
        }
    }
    
    // Se achou a porta na nova sala, define as coordenadas nela
    if (found_porta != noone) {
        target_x = found_porta.x;
        target_y = found_porta.y + 32; // Seu offset
    }
}

// Teleporta o jogador Persistente para o local correto na nova sala
if (target_x != -1 && target_y != -1 && instance_exists(Player)) {
    Player.x = target_x;
    Player.y = target_y;
}