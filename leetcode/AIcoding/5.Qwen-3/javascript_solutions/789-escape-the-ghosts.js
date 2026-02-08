function escapeGhosts(ghosts, target) {
    const myDistance = Math.abs(target[0]) + Math.abs(target[1]);
    for (const [x, y] of ghosts) {
        const ghostDistance = Math.abs(x - target[0]) + Math.abs(y - target[1]);
        if (ghostDistance <= myDistance) {
            return false;
        }
    }
    return true;
}