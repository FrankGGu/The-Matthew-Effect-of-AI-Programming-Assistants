function recoverOriginalArray(deck) {
    const count = new Map();
    for (const num of deck) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const sorted = [...new Set(deck)].sort((a, b) => a - b);
    const result = [];

    while (result.length < deck.length) {
        for (const num of sorted) {
            if (count.get(num) > 0) {
                result.push(num);
                count.set(num, count.get(num) - 1);
            }
        }
        for (let i = sorted.length - 1; i >= 0; i--) {
            if (count.get(sorted[i]) > 0) {
                result.push(sorted[i]);
                count.set(sorted[i], count.get(sorted[i]) - 1);
            }
        }
    }

    return result;
}