function areNumbersAscending(s) {
    const words = s.split(" ");
    let prev = -1;
    for (const word of words) {
        if (!isNaN(word)) {
            const num = parseInt(word);
            if (num <= prev) {
                return false;
            }
            prev = num;
        }
    }
    return true;
}