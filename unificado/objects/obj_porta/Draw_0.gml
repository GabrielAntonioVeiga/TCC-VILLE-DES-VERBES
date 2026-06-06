if (instance_exists(Player)) {
    if (point_distance(x, y, Player.x, Player.y) < distancia_interacao) {
        var sndE = asset_get_index("interacaoE");
        if (sndE != -1) {
            draw_sprite(
                sndE,
                0,
                x,
                bbox_top - 20
            );
        }
    }
}