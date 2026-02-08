var stoneGameIX = function(stones) {
    const count = new Array(3).fill(0);
    for (const stone of stones) {
        count[stone % 3]++;
    }

    if (count[1] === 0 || count[2] === 0) {
        return false;
    }

    if (count[1] === count[2]) {
        return true;
    }

    return Math.abs(count[1] - count[2]) > 0;
};