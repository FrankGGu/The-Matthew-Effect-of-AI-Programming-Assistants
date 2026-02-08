function eliminateStudents(n) {
    let left = 1;
    let right = n;
    let step = 1;
    while (left < right) {
        if ((right - left + 1) % 2 === 1) {
            if (step % 2 === 1) {
                left += step;
            } else {
                right -= step;
            }
        }
        step *= 2;
        left += step;
        right -= step;
    }
    return left;
}