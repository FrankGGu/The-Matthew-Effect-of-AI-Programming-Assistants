function kEmptySlots(people, k) {
    const n = people.length;
    const positions = new Array(n);
    for (let i = 0; i < n; i++) {
        positions[people[i]] = i;
    }

    let result = -1;
    let left = 0;
    let right = k + 1;

    while (right < n) {
        if (positions[right] < positions[left]) {
            result = Math.max(result, positions[left], positions[right]);
            left = right;
            right = left + k + 1;
        } else if (positions[left] < positions[right]) {
            result = Math.max(result, positions[left], positions[right]);
            left = right;
            right = left + k + 1;
        } else {
            right++;
        }
    }

    return result;
}