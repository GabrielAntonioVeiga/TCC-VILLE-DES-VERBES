draw_self();

// Desenho da "Porta" temporario para garantir a visao caso o Sprite2 for invisivel
draw_set_color(c_yellow);
draw_text(x, y - 20, "PORTA");
draw_rectangle(x - 30, y - 60, x + 30, y, true);
draw_set_color(c_white);

if (instance_exists(Player)) {
    if (point_distance(x, y, Player.x, Player.y) < 150) {
        var sndE = asset_get_index("interacaoE");
        if (sndE != -1) {
            draw_sprite(sndE, 0, x, y - 80);
        }
    }
}
