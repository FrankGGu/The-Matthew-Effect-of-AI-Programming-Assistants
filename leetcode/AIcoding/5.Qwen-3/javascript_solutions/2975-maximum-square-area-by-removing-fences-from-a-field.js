function maximizeSquareArea(bottomLeftX, bottomLeftY, topRightX, topRightY) {
    const left = [];
    const right = [];
    const bottom = [];
    const top = [];

    for (let x = bottomLeftX; x <= topRightX; x++) {
        left.push(x);
        right.push(x);
    }

    for (let y = bottomLeftY; y <= topRightY; y++) {
        bottom.push(y);
        top.push(y);
    }

    left.sort((a, b) => a - b);
    right.sort((a, b) => b - a);
    bottom.sort((a, b) => a - b);
    top.sort((a, b) => b - a);

    let maxSide = 0;
    let i = 0, j = 0;

    while (i < left.length && j < right.length) {
        if (left[i] === right[j]) {
            maxSide = Math.max(maxSide, left[i] - bottomLeftX);
            i++;
            j++;
        } else if (left[i] < right[j]) {
            i++;
        } else {
            j++;
        }
    }

    i = 0;
    j = 0;

    while (i < bottom.length && j < top.length) {
        if (bottom[i] === top[j]) {
            maxSide = Math.max(maxSide, bottom[i] - bottomLeftY);
            i++;
            j++;
        } else if (bottom[i] < top[j]) {
            i++;
        } else {
            j++;
        }
    }

    return maxSide * maxSide;
}