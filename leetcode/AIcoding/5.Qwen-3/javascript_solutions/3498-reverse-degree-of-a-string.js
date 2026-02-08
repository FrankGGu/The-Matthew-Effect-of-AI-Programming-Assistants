function reverseEq(s) {
    const map = new Map();
    for (let c of s) {
        map.set(c, (map.get(c) || 0) + 1);
    }
    const freq = Array.from(map.values()).sort((a, b) => b - a);
    const result = [];
    for (let i = 0; i < freq.length; i++) {
        for (let j = 0; j < freq[i]; j++) {
            result.push(String.fromCharCode(97 + i));
        }
    }
    return result.join('');
}