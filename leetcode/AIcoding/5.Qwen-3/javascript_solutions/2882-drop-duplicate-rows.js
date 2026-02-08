var dropDuplicateRows = function(df) {
    const seen = new Set();
    const result = [];
    for (const row of df) {
        const key = row.join(',');
        if (!seen.has(key)) {
            seen.add(key);
            result.push(row);
        }
    }
    return result;
};