function isCircularSentence(sentence) {
    const words = sentence.split(" ");
    for (let i = 0; i < words.length; i++) {
        const currentWord = words[i];
        const nextWord = words[(i + 1) % words.length];
        if (currentWord[currentWord.length - 1] !== nextWord[0]) {
            return false;
        }
    }
    return true;
}