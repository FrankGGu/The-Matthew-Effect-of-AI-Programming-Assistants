function wonderfulSubstrings(s) {
    const count = new Array(1 << 10).fill(0);
    count[0] = 1;
    let result = 0;
    let mask = 0;

    for (const char of s) {
        const index = char.charCodeAt(0) - 'a'.charCodeAt(0);
        mask ^= (1 << index);

        for (let i = 0; i < 10; i++) {
            result += count[mask ^ (1 << i)];
        }

        result += count[mask];
        count[mask]++;
    }

    return result;
}