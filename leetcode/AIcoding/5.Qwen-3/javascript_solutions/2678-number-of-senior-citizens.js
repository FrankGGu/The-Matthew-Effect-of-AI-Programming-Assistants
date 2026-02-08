function numSeniorCitizens(details) {
    let count = 0;
    for (let i = 0; i < details.length; i++) {
        const age = parseInt(details[i].substring(11, 13));
        if (age >= 60) {
            count++;
        }
    }
    return count;
}