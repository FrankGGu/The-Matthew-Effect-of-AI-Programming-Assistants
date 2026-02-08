function bagOfTokens(token, power) {
    token.sort((a, b) => a - b);
    let left = 0;
    let right = token.length - 1;
    let maxScore = 0;
    let currentScore = 0;

    while (left <= right) {
        if (token[left] <= power) {
            power -= token[left];
            left++;
            currentScore++;
            maxScore = Math.max(maxScore, currentScore);
        } else if (currentScore > 0) {
            power += token[right];
            right--;
            currentScore--;
        } else {
            break;
        }
    }

    return maxScore;
}