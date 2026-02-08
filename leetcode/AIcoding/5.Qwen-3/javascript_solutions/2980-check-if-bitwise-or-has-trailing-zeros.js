function hasTrailingZeros(nums) {
    let orResult = 0;
    for (let num of nums) {
        orResult |= num;
    }
    return (orResult & 1) === 0;
}