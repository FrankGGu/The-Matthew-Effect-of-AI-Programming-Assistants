function judgeSquareSum(c) {
    const sqrtC = Math.sqrt(c);
    for (let i = 0; i <= sqrtC; i++) {
        const j = Math.sqrt(c - i * i);
        if (j === Math.floor(j)) {
            return true;
        }
    }
    return false;
}