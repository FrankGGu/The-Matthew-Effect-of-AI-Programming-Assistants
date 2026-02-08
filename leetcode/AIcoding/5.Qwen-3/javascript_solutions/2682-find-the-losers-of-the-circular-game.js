function findLosers(n, k) {
    let players = new Array(n).fill(0).map((_, i) => i + 1);
    let current = 0;
    while (players.length > 1) {
        current = (current + k - 1) % players.length;
        players.splice(current, 1);
    }
    return players;
}