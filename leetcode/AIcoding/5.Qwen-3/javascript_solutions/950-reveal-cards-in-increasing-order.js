function deckRevealedIntorder(deck) {
    const n = deck.length;
    const result = new Array(n);
    const indices = new Array(n).fill(0).map((_, i) => i);
    let index = 0;

    while (indices.length > 0) {
        const i = indices.shift();
        result[i] = deck[index++];
        if (indices.length > 0) {
            indices.push(indices.shift());
        }
    }

    return result;
}