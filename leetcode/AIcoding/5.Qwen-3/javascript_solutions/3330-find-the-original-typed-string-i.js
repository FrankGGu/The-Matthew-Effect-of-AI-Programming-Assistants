function findOriginalString(encoded) {
    let n = encoded.length;
    let result = [];
    for (let i = 0; i < n; i += 2) {
        result.push(encoded[i]);
    }
    return result.join('');
}