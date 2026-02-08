function maximumNumberOfBoxes(apple, capacity) {
    apple.sort((a, b) => b - a);
    capacity.sort((a, b) => b - a);

    let count = 0;
    let i = 0;
    let j = 0;

    while (i < apple.length && j < capacity.length) {
        if (apple[i] <= capacity[j]) {
            count++;
            i++;
            j++;
        } else {
            j++;
        }
    }

    return count;
}