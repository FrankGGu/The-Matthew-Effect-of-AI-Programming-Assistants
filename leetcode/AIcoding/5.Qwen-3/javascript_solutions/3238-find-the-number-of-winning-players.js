function winningPlayers(scores) {
    const playerScores = {};
    for (const [player, score] of scores) {
        if (!playerScores[player]) {
            playerScores[player] = 0;
        }
        playerScores[player] += score;
    }

    const sortedPlayers = Object.entries(playerScores).sort((a, b) => b[1] - a[1]);
    const maxScore = sortedPlayers[0][1];
    let count = 0;

    for (const [player, score] of sortedPlayers) {
        if (score === maxScore) {
            count++;
        } else {
            break;
        }
    }

    return count;
}