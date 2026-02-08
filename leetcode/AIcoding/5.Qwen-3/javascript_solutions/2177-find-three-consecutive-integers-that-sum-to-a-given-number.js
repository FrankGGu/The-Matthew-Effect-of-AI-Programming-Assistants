function sumOfThree( num) {
    if (num % 3 !== 0) return [];
    const mid = num / 3;
    return [mid - 1, mid, mid + 1];
}