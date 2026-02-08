function chalkReplacer(chalk, k) {
    let total = 0;
    for (let i = 0; i < chalk.length; i++) {
        total += chalk[i];
    }
    k %= total;
    for (let i = 0; i < chalk.length; i++) {
        if (k < chalk[i]) {
            return i;
        }
        k -= chalk[i];
    }
    return -1;
}