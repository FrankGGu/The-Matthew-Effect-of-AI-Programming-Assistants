function customSortString(S, T) {
    const count = {};
    for (const c of T) {
        count[c] = (count[c] || 0) + 1;
    }

    let result = '';

    for (const c of S) {
        if (count[c]) {
            result += c.repeat(count[c]);
            delete count[c];
        }
    }

    for (const c in count) {
        result += c.repeat(count[c]);
    }

    return result;
}