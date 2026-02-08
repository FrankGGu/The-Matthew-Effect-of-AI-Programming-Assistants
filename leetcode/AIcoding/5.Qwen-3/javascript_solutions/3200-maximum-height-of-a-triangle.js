function maxHeight(n) {
    let height = 0;
    while (n > 0) {
        height++;
        n -= height;
    }
    return height;
}