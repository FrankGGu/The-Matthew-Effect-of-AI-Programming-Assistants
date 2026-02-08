function findProductRecommendationPairs(pairs) {
    const map = new Map();
    const result = [];

    for (const [user, product] of pairs) {
        if (!map.has(user)) {
            map.set(user, new Set());
        }
        map.get(user).add(product);
    }

    const users = Array.from(map.keys());

    for (let i = 0; i < users.length; i++) {
        for (let j = i + 1; j < users.length; j++) {
            const user1 = users[i];
            const user2 = users[j];
            const set1 = map.get(user1);
            const set2 = map.get(user2);

            const commonProducts = new Set([...set1].filter(product => set2.has(product)));

            if (commonProducts.size >= 2) {
                const sorted = [...commonProducts].sort();
                result.push([user1, user2, sorted[0], sorted[1]]);
            }
        }
    }

    return result;
}