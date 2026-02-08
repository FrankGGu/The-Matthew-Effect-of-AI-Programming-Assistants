function maxEnergy(energyDrinkA, energyDrinkB) {
    const n = energyDrinkA.length;
    let prevA = 0, prevB = 0;

    for (let i = 0; i < n; i++) {
        const currA = Math.max(prevA, prevB + energyDrinkA[i]);
        const currB = Math.max(prevB, prevA + energyDrinkB[i]);
        prevA = currA;
        prevB = currB;
    }

    return Math.max(prevA, prevB);
}