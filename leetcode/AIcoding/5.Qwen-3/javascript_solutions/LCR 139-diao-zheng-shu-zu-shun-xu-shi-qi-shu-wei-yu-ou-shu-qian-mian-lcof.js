function trainningPlan(fitList) {
    let count = 0;
    for (let i = 0; i < fitList.length; i++) {
        if (fitList[i] % 2 === 0) {
            count++;
        }
    }
    return count;
}