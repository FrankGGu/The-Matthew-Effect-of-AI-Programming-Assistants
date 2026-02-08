function getHint(secret, guess) {
    let bulls = 0;
    let cows = 0;
    const secretCount = new Array(10).fill(0);
    const guessCount = new Array(10).fill(0);

    for (let i = 0; i < secret.length; i++) {
        if (secret[i] === guess[i]) {
            bulls++;
        } else {
            secretCount[parseInt(secret[i])]++;
            guessCount[parseInt(guess[i])]++;
        }
    }

    for (let i = 0; i < 10; i++) {
        cows += Math.min(secretCount[i], guessCount[i]);
    }

    return bulls + "A" + cows + "B";
}