function minimumPenalty(customers) {
    let penalty = 0;
    let minPenalty = 0;
    let maxDifference = 0;

    for (let i = 0; i < customers.length; i++) {
        if (customers[i] === 'Y') {
            penalty--;
            if (penalty < minPenalty) {
                minPenalty = penalty;
                maxDifference = i;
            }
        } else {
            penalty++;
        }
    }

    return maxDifference;
}