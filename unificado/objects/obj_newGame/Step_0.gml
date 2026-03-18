if (keyboard_check_pressed(vk_up)) selected--;
if (keyboard_check_pressed(vk_down)) selected++;

selected = clamp(selected,0,array_length(options)-1);

if (keyboard_check_pressed(vk_enter))
{
    switch(selected)
    {
        case 0:
        case 1:
        case 2:
            global.save_slot = selected;
            room_goto(Room1);
        break;

        case 3:
            room_goto(rm_menu);
        break;
    }
}