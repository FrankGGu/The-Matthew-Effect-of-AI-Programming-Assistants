function countAndSay(n) {
    if (n === 1) return "1";
    let prev = "1";
    for (let i = 2; i <= n; i++) {
        let curr = "";
        let j = 0;
        while (j < prev.length) {
            let count = 1;
            while (j + 1 < prev.length && prev[j] === prev[j + 1]) {
                j++;
                count++;
            }
            curr += count.toString() + prev[j];
            j++;
        }
        prev = curr;
    }
    return prev;
}