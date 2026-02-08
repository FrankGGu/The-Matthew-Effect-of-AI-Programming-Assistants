function rand10() {
    while (true) {
        let num = (rand7() - 1) * 7 + rand7();
        if (num <= 40) {
            return Math.floor((num - 1) / 4) + 1;
        }
    }
}