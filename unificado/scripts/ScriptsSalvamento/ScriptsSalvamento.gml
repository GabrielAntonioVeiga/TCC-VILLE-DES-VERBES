function salvar_jogo() {
	
	var estruturaSalvamento = 
	{
		posicaoX: Player.x,
		posicaoY: Player.y,
		avatar: Player.sprite_index,
		direcao: Player.facing,
		cenario: "Cenario",
		colecionaveisAdquiridos: "Colecionaveis",
		quizzesConcluidos: "Quizzes"
	}
		
	var stringEstruturaSalvamento = json_stringify(estruturaSalvamento);
	
	var arquivo = file_text_open_write("save.txt");
	
	file_text_write_string(arquivo, stringEstruturaSalvamento);
	
	file_text_close(arquivo);
	
}

function carregar_jogo() {
	if (file_exists("save.txt")) {
		var arquivo = file_text_open_read("save.txt");
		
		var stringEstruturaSalvamento = file_text_read_string(arquivo);
		
		var estruturaSalvamento = json_parse(stringEstruturaSalvamento);
		
		Player.x = estruturaSalvamento.posicaoX;
		Player.y = estruturaSalvamento.posicaoY;
		Player.sprite_index = estruturaSalvamento.avatar;
		Player.facing = estruturaSalvamento.direcao;
		
		file_text_close(arquivo);
	}
	
}