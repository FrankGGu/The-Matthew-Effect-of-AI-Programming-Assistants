function minimumPerimeter(neededApples) {
    let n = 0;
    while (true) {
        const apples = (n * (n + 1) * (2 * n + 1)) * 3;
        if (apples >= neededApples) {
            return n * 8;
        }
        n++;
    }
}