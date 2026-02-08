function findCategoryRecommendationPairs(categories) {
    const map = {};
    for (const [id, category] of Object.entries(categories)) {
        if (!map[category]) {
            map[category] = [];
        }
        map[category].push(id);
    }

    const result = [];
    for (const [category, ids] of Object.entries(map)) {
        if (ids.length >= 2) {
            for (let i = 0; i < ids.length; i++) {
                for (let j = i + 1; j < ids.length; j++) {
                    result.push([ids[i], ids[j]]);
                }
            }
        }
    }

    return result;
}