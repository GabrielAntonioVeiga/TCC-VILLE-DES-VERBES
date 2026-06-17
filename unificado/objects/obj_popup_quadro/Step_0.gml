/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 67A2F610
/// @DnDArgument : "code" "if (subindo) {$(13_10)    alpha = min(alpha + 0.05, 1);$(13_10)    if (alpha >= 1) subindo = false;$(13_10)}$(13_10)timer--;$(13_10)if (timer <= 0) {$(13_10)    alpha = max(alpha - 0.05, 0);$(13_10)    if (alpha <= 0) instance_destroy();$(13_10)}"
if (subindo) {
    alpha = min(alpha + 0.05, 1);
    if (alpha >= 1) subindo = false;
}
timer--;
if (timer <= 0) {
    alpha = max(alpha - 0.05, 0);
    if (alpha <= 0) instance_destroy();
}