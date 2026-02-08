var findOriginalArray = function(changed) {
    if (changed.length % 2 !== 0) return [];

    const count = new Map();
    for (const num of changed) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const sorted = [...changed].sort((a, b) => a - b);

    const result = [];

    for (const num of sorted) {
        if (count.get(num) === 0) continue;

        if (count.has(num * 2)) {
            if (num === 0) {
                if (count.get(num) >= 2) {
                    result.push(num);
                    count.set(num, count.get(num) - 2);
                } else {
                    return [];
                }
            } else {
                if (count.get(num) > 0 && count.get(num * 2) > 0) {
                    result.push(num);
                    count.set(num, count.get(num) - 1);
                    count.set(num * 2, count.get(num * 2) - 1);
                } else {
                    return [];
                }
            }
        } else {
            return [];
        }
    }

    return result;
};