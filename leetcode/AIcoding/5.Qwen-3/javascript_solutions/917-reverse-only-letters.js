function reverseOnlyLetters(S) {
    const letters = S.split('').filter(c => /[a-zA-Z]/.test(c));
    let result = [];
    let letterIndex = letters.length - 1;
    for (let i = 0; i < S.length; i++) {
        if (/[a-zA-Z]/.test(S[i])) {
            result.push(letters[letterIndex--]);
        } else {
            result.push(S[i]);
        }
    }
    return result.join('');
}