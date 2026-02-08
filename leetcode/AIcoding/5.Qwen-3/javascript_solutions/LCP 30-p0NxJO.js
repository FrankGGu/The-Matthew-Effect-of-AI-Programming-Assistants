function minHealth(tower) {
    let health = 1;
    for (let i = tower.length - 2; i >= 0; i--) {
        if (tower[i] > health) {
            health = tower[i] - health + 1;
        } else {
            health = 1;
        }
    }
    return health;
}