if (instance_exists(Player)) {

  
    var _dist = point_distance(x, y - (direcao="cima" ? Player.sprite_height :  Player.sprite_height/2), Player.x, Player.y);

    if (_dist <= distancia_interacao) {
        var sndE = asset_get_index("interacaoE");
        if (sndE != -1) {           
            var centro_x = (bbox_left + bbox_right) / 2;
            var draw_y = bbox_top;
            
            draw_sprite(sndE, 0, centro_x, draw_y);
        }
    }
}