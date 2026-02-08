function melt(df) {
    const result = {};
    const columns = Object.keys(df);
    const rows = Object.values(df)[0].length;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < columns.length; j++) {
            const key = columns[j];
            const value = df[key][i];
            if (!result[key]) {
                result[key] = [];
            }
            result[key].push(value);
        }
    }

    return result;
}