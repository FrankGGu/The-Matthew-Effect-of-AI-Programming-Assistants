function oddString(words) {
    const map = new Map();

    for (const word of words) {
        let diff = '';
        for (let i = 1; i < word.length; i++) {
            diff += String.fromCharCode(word.charCodeAt(i) - word.charCodeAt(i - 1));
        }
        if (!map.has(diff)) {
            map.set(diff, []);
        }
        map.get(diff).push(word);
    }

    for (const [key, value] of map.entries()) {
        if (value.length === 1) {
            return value[0];
        }
    }

    return '';
}