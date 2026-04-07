if (fade_out) {
    alpha += fade_speed;
    if (alpha >= 1) {
        alpha = 1;
        fade_out = false;
        if (room_exists(target_room) && target_room != -1) {
            room_goto(target_room);
        }
    }
} else {
    alpha -= fade_speed;
    if (alpha <= 0) {
        if (target_x != -1 && target_y != -1 && instance_exists(Player)) {
            Player.x = target_x;
            Player.y = target_y;
        }
        instance_destroy();
    }
}
