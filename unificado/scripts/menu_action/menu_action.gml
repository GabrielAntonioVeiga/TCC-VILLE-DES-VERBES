function menu_action(index)
{
    switch(index)
    {
        case 0: // Continuar
            continuar_jogo();
        break;

        case 1: // Novo jogo
            room_goto(Room1);
        break;

        case 2: // Seleção de save
            room_goto(rm_SaveSelection);
        break;

        case 3: // Config
            room_goto(rm_config);
        break;

        case 4: // Créditos
            room_goto(rm_creditos);
        break;

        case 5: // Sair
            game_end();
        break;
    }
}