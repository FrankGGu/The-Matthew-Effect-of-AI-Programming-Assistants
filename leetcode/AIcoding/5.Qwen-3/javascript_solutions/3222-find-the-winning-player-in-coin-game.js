function findTheWinningPlayer(n) {
    const players = ["Alice", "Bob"];
    let turn = 0;
    while (n > 0) {
        n -= 1;
        turn = 1 - turn;
    }
    return players[turn];
}