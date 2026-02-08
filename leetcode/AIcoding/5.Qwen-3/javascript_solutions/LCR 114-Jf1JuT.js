function alienOrder(words) {
    const graph = {};
    const inDegree = {};

    for (const word of words) {
        for (const char of word) {
            if (!graph[char]) {
                graph[char] = new Set();
                inDegree[char] = 0;
            }
        }
    }

    for (let i = 0; i < words.length - 1; i++) {
        const word1 = words[i];
        const word2 = words[i + 1];
        const minLength = Math.min(word1.length, word2.length);
        let found = false;

        for (let j = 0; j < minLength; j++) {
            const char1 = word1[j];
            const char2 = word2[j];
            if (char1 !== char2) {
                if (!graph[char1].has(char2)) {
                    graph[char1].add(char2);
                    inDegree[char2]++;
                }
                found = true;
                break;
            }
        }

        if (!found && word1.length > word2.length) {
            return "";
        }
    }

    const queue = [];
    for (const char in inDegree) {
        if (inDegree[char] === 0) {
            queue.push(char);
        }
    }

    const result = [];

    while (queue.length > 0) {
        const char = queue.shift();
        result.push(char);

        for (const neighbor of graph[char]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    if (result.length !== Object.keys(inDegree).length) {
        return "";
    }

    return result.join("");
}