// Limpa alpha quando alarme zera
if (alarm[0] <= 0) {
    alpha -= 0.05;
    if (alpha <= 0) {
        instance_destroy();
    }
}
