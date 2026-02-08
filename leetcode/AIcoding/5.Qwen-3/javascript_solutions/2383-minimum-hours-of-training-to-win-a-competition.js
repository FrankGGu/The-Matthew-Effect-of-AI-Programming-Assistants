function minTrainingHours(energy, experience) {
    let hours = 0;
    for (let i = 0; i < energy.length; i++) {
        if (energy[i] > 0) {
            hours += energy[i];
        }
        if (experience[i] > 0) {
            hours += experience[i];
        }
    }
    return hours;
}