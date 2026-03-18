if keyboard_check_pressed(vk_up) selected--;
if keyboard_check_pressed(vk_down) selected++;

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