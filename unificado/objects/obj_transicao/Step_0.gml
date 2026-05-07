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
    if (!room_changed) {
        room_changed = true;
        if (source_room != -1) {
            var found_porta = noone;
            with (obj_porta) {
                if (target_room == other.source_room) {
                    found_porta = id;
                    break;
                }
            }
            if (found_porta != noone) {
                target_x = found_porta.x;
                target_y = found_porta.y + 32; // Offset para não nascer exatamente dentro
            }
        }
        
        if (target_x != -1 && target_y != -1 && instance_exists(Player)) {
            Player.x = target_x;
            Player.y = target_y;
        }
    }

    alpha -= fade_speed;
    if (alpha <= 0) {
        if (target_x != -1 && target_y != -1 && instance_exists(Player)) {
            Player.x = target_x;
            Player.y = target_y;
        }
        instance_destroy();
    }
}
