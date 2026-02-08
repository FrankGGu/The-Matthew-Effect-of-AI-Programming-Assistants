function minAddToMakeValid(s) {
    let balance = 0;
    let result = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            balance++;
        } else {
            balance--;
        }
        if (balance < 0) {
            result++;
            balance = 0;
        }
    }
    return result + balance;
}