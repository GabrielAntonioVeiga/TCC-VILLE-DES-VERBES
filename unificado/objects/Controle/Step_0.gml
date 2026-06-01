if instance_exists(Dialogo) {
	global.dialogo = true;	
}

if (variable_global_exists("tempo_jogado")) {
    global.tempo_jogado += delta_time / 1000000;
}