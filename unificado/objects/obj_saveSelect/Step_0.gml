if keyboard_check_pressed(vk_up) selected--;
if keyboard_check_pressed(vk_down) selected++;

 /*
 essa lógica é enganosa, pois o <slots> está como 3, porém o for que o manipula vai até 2
 a função clamp está limitando <selected> até 3, por isso o else está funcionando para o botão voltar
*/
selected = clamp(selected,0,slots);
if keyboard_check_pressed(vk_enter)
{
    if selected < slots
    {
        global.save_slot = selected;
        room_goto(Room1);
    }
    else
    {
        room_goto(rm_menu);
    }
}