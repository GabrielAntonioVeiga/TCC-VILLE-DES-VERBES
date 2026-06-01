
if (!variable_global_exists("pergunta_atual_id")) {
    global.pergunta_atual_id = {}; 
    global.notas = [];
    global.quizzes_concluidos = {};
    global.status_missoes = {}; 
	global.objetivo_atual = "Nenhum objetivo no momento. Explore livremente!"; 

}

if (!variable_global_exists("tempo_jogado")) {
    global.tempo_jogado = 0;
}

global.dialogo = false;
global.range = 90;
global.dados_quiz = {}; 


var arquivos_json = [
    "quizzes_jantar.json",
    "quizzes_atelie.json",
    "quizzes_corredor.json",
    "quizzes_quarto.json",
    "quizzes_banheiro.json",
    "quizzes_lavanderia.json"
];

for (var i = 0; i < array_length(arquivos_json); i++) {
    var arquivo_atual = arquivos_json[i];
    
    if (file_exists(arquivo_atual)) {
        var arquivo = file_text_open_read(arquivo_atual);
        var texto_json = "";
        
        while (!file_text_eof(arquivo)) {
            texto_json += file_text_read_string(arquivo);
            file_text_readln(arquivo);
        }
        
        file_text_close(arquivo);
     
        var dados_temporarios = json_parse(texto_json);
        
        var chaves = variable_struct_get_names(dados_temporarios);
        for (var j = 0; j < array_length(chaves); j++) {
            var nome_quiz = chaves[j];
            global.dados_quiz[$ nome_quiz] = dados_temporarios[$ nome_quiz];
        }
    }
}