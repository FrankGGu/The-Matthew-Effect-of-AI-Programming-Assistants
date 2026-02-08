function isSumEqual(s1, s2, s3) {
    function wordToNumber(word) {
        let num = 0;
        for (let i = 0; i < word.length; i++) {
            num = num * 10 + (word[i].charCodeAt(0) - 'a'.charCodeAt(0));
        }
        return num;
    }

    const num1 = wordToNumber(s1);
    const num2 = wordToNumber(s2);
    const num3 = wordToNumber(s3);

    return num1 + num2 === num3;
}