function reorganizeString(s) {
    const count = {};
    for (const c of s) {
        count[c] = (count[c] || 0) + 1;
    }

    const maxHeap = [];
    for (const [char, freq] of Object.entries(count)) {
        maxHeap.push({ char, freq });
    }

    maxHeap.sort((a, b) => b.freq - a.freq);

    let result = [];
    let prev = null;

    while (maxHeap.length > 0 || prev !== null) {
        if (prev !== null) {
            if (prev.freq > 0) {
                maxHeap.push(prev);
            }
            prev = null;
        }

        if (maxHeap.length === 0) return "";

        const curr = maxHeap.shift();
        result.push(curr.char);
        curr.freq--;
        prev = curr;

        maxHeap.sort((a, b) => b.freq - a.freq);
    }

    return result.join("");
}