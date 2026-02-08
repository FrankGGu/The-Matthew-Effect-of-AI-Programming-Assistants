function lengthLongestPath(input) {
    const map = {};
    let maxLen = 0;
    const lines = input.split('\n');

    for (const line of lines) {
        let name = line;
        let depth = 0;
        while (name.startsWith('\t')) {
            depth++;
            name = name.substring(1);
        }

        if (name.includes('.')) {
            const len = map[depth - 1] + name.length;
            maxLen = Math.max(maxLen, len);
        } else {
            map[depth] = map[depth - 1] + name.length + 1;
        }
    }

    return maxLen;
}