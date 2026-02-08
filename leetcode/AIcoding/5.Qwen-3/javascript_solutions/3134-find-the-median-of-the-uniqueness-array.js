function medianOfUniquenessArray(arr) {
    const unique = new Set(arr);
    const sortedUnique = Array.from(unique).sort((a, b) => a - b);
    const mid = Math.floor(sortedUnique.length / 2);
    return sortedUnique[mid];
}