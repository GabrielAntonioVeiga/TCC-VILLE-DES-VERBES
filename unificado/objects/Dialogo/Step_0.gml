if inicializar == false{
	ScriptsTextos();
	inicializar = true;
	alarm[0] = 1;
}

if keyboard_check_pressed(ord("E")) {
	
	if caractere < string_length(texto[pagina]) {
		caractere = string_length(texto[pagina]);
	} else {
		alarm[0] = 1;
		caractere = 0;
		
		if pagina < array_length(texto) - 1 {
			pagina++;
		} else {
			global.dialogo = false;
			instance_destroy();
		
			io_clear();
		}
	}
}