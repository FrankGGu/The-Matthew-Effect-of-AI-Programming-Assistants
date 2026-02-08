function scoreOfParentheses(S) {
    let stack = [];
    let score = 0;
    for (let c of S) {
        if (c === '(') {
            stack.push(score);
            score = 0;
        } else {
            score = stack.pop() + Math.max(1, score * 2);
        }
    }
    return score;
}