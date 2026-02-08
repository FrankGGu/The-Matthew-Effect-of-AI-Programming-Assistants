function numMatchingSubseq(s, words) {
    const map = {};
    for (const word of words) {
        if (!map[word[0]]) map[word[0]] = [];
        map[word[0]].push(word);
    }

    const queue = [];
    for (const char of s) {
        if (map[char]) {
            queue.push(...map[char]);
            delete map[char];
        }
    }

    let count = 0;
    while (queue.length > 0) {
        const word = queue.shift();
        if (word.length === 0) {
            count++;
            continue;
        }
        const firstChar = word[0];
        if (map[firstChar]) {
            map[firstChar].push(word.substring(1));
        } else {
            map[firstChar] = [word.substring(1)];
        }
    }

    return count;
}