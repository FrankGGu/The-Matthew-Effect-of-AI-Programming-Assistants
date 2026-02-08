function oddEvenTransaction(transactions) {
    let oddSum = 0;
    let evenSum = 0;
    for (let i = 0; i < transactions.length; i++) {
        if (i % 2 === 0) {
            evenSum += transactions[i];
        } else {
            oddSum += transactions[i];
        }
    }
    return [evenSum, oddSum];
}