global.dialogo = false;
global.range = 130; //para a distancia de interações
global.dados_quiz = {}; 
if (file_exists("quizzes.json")) {
    var arquivo = file_text_open_read("quizzes.json");
    var texto_json = "";
    while (!file_text_eof(arquivo)) {
        texto_json += file_text_read_string(arquivo);
        file_text_readln(arquivo);
    }
    file_text_close(arquivo);
    global.dados_quiz = json_parse(texto_json);
    show_debug_message("JSON carregado com sucesso!");
    
} else {
    show_debug_message("ERRO: Arquivo quizzes.json não encontrado!");
}