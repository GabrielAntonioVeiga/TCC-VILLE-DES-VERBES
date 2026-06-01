
if (!variable_global_exists("pergunta_atual_id")) {
    global.pergunta_atual_id = {}; 
    global.notas = [];
    global.quizzes_concluidos = {};
}

if (!variable_global_exists("tempo_jogado")) {
    global.tempo_jogado = 0;
}

global.dialogo = false;
global.range = 90;
global.dados_quiz = {}; 

// 2. CARREGA O JSON
if (file_exists("quizzes.json")) {
    var arquivo = file_text_open_read("quizzes.json");
    var texto_json = "";
    
    while (!file_text_eof(arquivo)) {
        texto_json += file_text_read_string(arquivo);
        file_text_readln(arquivo);
    }
    
    file_text_close(arquivo);
    global.dados_quiz = json_parse(texto_json);
} 