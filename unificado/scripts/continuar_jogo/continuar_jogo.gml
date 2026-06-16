/// continuar_jogo()
function continuar_jogo() {
    var ok = carregar_jogo(); // usa o wrapper
    if (ok) {
        // ir para a room de gameplay (substitua pelo nome exato se necessário)
        room_goto(rm_jantar);
    } else {
        // já mostrou mensagem dentro de carregar_jogo()
    }
}