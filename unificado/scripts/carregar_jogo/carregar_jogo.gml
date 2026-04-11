function carregar_jogo()
{
    // exemplo simples de carregamento
    if (file_exists("save0.json"))
    {
        show_message("Save carregado!");
        return true;
    }
    else
    {
        show_message("Nenhum save encontrado.");
        return false;
    }
}