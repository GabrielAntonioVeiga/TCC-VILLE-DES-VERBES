if (instance_exists(Player)) {
    if (distance_to_object(Player) < distancia_interacao) {
        var sndE = asset_get_index("interacaoE");
        if (sndE != -1) {
            
            // CALCULA O CENTRO HORIZONTAL REAL DA PORTA
            // bbox_left (esquerda) + bbox_right (direita) dividido por 2 acha o meio exato
            var centro_x = (bbox_left + bbox_right) / 2;
            
            draw_sprite(
                sndE,
                0,
                centro_x,       // Usando o centro calculado em vez do x puro
                bbox_top - 20   // Mantém no topo com o seu offset de 20 pixels para cima
            );
        }
    }
}