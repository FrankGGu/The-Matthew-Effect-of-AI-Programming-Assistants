function calculateScore(operations) {
    let score = 0;
    for (let i = 0; i < operations.length; i++) {
        if (operations[i] === "++X" || operations[i] === "X++") {
            score++;
        } else if (operations[i] === "--X" || operations[i] === "X--") {
            score--;
        }
    }
    return score;
}