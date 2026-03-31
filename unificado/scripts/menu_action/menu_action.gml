function menu_action(index)
{
    switch(index)
    {
        case 0: // Jogar
            room_goto(rm_SaveSelection);
        break;

        case 1: // Config
            room_goto(rm_config);
        break;

        case 2: // Créditos
            room_goto(rm_creditos);
        break;

        case 3: // Sair
            game_end();
        break;
    }
}