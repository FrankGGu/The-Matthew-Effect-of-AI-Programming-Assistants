function minimumTimeToRevert(word, k) {
    let n = word.length;
    let time = 0;
    let i = 0;
    while (i < n) {
        time++;
        i += k;
        if (i >= n) break;
        let j = 0;
        while (j < n && word[j] === word[i + j]) {
            j++;
        }
        if (j === n) break;
    }
    return time;
}