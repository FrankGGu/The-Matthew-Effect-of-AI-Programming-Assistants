function monkeyCollision(directions) {
    let left = 0;
    let right = directions.length - 1;
    while (left < right && directions[left] === 'L') {
        left++;
    }
    while (right > left && directions[right] === 'R') {
        right--;
    }
    return right - left;
}