function minFlipsMonoIncr(s) {
    let flip = 0;
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            count++;
        } else {
            flip++;
            if (flip > count) {
                flip = count;
            }
        }
    }
    return flip;
}