function isWinner(game) {
    let player1 = 0;
    let player2 = 0;
    for (let i = 0; i < game.length; i++) {
        const round = game[i];
        if (round[0] === 10) {
            player1 += 10 + (game[i + 1] ? (game[i + 1][0] + (game[i + 1][1] || 0)) : 0);
        } else {
            player1 += round[0] + round[1];
        }
        if (round[1] === 10) {
            player2 += 10 + (game[i + 1] ? (game[i + 1][0] + (game[i + 1][1] || 0)) : 0);
        } else {
            player2 += round[1];
        }
    }
    return player1 > player2 ? 1 : 2;
}