function carregar_jogo() {
    // ESTA É A CORREÇÃO: Chamamos a função real que lê o JSON
    if (existe_save_slot(0)) {
        return carregar_jogo_slot(0); 
    } else {
        show_message("Nenhum save encontrado.");
        return false;
    }
}