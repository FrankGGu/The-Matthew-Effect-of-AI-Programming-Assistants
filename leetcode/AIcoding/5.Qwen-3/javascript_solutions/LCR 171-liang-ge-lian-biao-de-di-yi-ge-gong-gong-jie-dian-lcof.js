function trainingPlan(fit) {
    let count = 0;
    for (let i = 0; i < fit.length; i++) {
        if (fit[i] % 2 === 1) {
            count++;
        }
    }
    return count;
}