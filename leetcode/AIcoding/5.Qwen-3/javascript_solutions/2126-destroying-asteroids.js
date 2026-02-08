function asteroidsDestroyed(asteroids) {
    let mass = 1;
    asteroids.sort((a, b) => a - b);
    for (let i = 0; i < asteroids.length; i++) {
        if (mass < asteroids[i]) {
            return false;
        }
        mass += asteroids[i];
    }
    return true;
}