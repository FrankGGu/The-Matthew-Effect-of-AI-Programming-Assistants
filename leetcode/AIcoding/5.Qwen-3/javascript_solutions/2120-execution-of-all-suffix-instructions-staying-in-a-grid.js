function executeInstructions(n, startPos, s) {
    const result = [];
    const directions = {
        'L': [0, -1],
        'R': [0, 1],
        'U': [-1, 0],
        'D': [1, 0]
    };

    for (let i = 0; i < s.length; i++) {
        let x = startPos[0];
        let y = startPos[1];
        let count = 0;
        for (let j = 0; j < s[i].length; j++) {
            const dir = s[i][j];
            const [dx, dy] = directions[dir];
            x += dx;
            y += dy;
            if (x >= 0 && x < n && y >= 0 && y < n) {
                count++;
            } else {
                break;
            }
        }
        result.push(count);
    }

    return result;
}