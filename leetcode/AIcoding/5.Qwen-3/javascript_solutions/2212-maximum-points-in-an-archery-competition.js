function maximumPointsInAnArcheryCompetition(numArrows, aliceArrows) {
    const n = aliceArrows.length;
    let maxPoints = 0;
    let bestShot = new Array(n).fill(0);

    function dfs(index, arrowsLeft, points, shot) {
        if (index === n) {
            if (points > maxPoints) {
                maxPoints = points;
                bestShot = [...shot];
            }
            return;
        }

        // Skip this arrow
        dfs(index + 1, arrowsLeft, points, shot);

        // Take this arrow if possible
        if (arrowsLeft >= 1) {
            const newShot = [...shot];
            newShot[index] = 1;
            dfs(index + 1, arrowsLeft - 1, points + index, newShot);
        }
    }

    dfs(0, numArrows, 0, new Array(n).fill(0));

    return bestShot;
}