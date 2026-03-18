if keyboard_check_pressed(vk_up) selected--;
if keyboard_check_pressed(vk_down) selected++;

selected = clamp(selected,0,array_length(options)-1);

if keyboard_check_pressed(vk_enter)
{
    switch(selected)
    {
        case 0:
            global.volume = min(global.volume+0.1,1);
        break;

        case 1:
            global.volume = max(global.volume-0.1,0);
        break;

        case 2:
            window_set_fullscreen(!window_get_fullscreen());
        break;

        case 3:
            room_goto(rm_menu);
        break;
    }
}