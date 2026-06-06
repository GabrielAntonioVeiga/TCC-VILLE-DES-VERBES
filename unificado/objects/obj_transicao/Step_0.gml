if (fade_out) {
    alpha += fade_speed;
    if (alpha >= 1) {
        alpha = 1;
        fade_out = false;
        if (room_exists(target_room) && target_room != -1) {
            // Torna o objeto persistente ANTES de mudar, para ele não morrer
            persistent = true; 
            room_goto(target_room);
        }
    }
} else {
    // Quando estiver esmaecendo (saindo do preto), apenas diminui o alpha
    alpha -= fade_speed;
    if (alpha <= 0) {
        instance_destroy();
    }
}