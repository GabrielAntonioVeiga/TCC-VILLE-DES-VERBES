
if (!variable_global_exists("portas_desbloqueadas")) {
    global.portas_desbloqueadas = {};
}


porta_id = room_get_name(room) + "_" + string(x) + "_" + string(y);
desbloqueada = false;

// Checa se esta porta já foi desbloqueada anteriormente
if (variable_struct_exists(global.portas_desbloqueadas, porta_id)) {
    if (global.portas_desbloqueadas[$ porta_id] == true) {
        desbloqueada = true;
    }
}


missao_necessaria = "";
