function inventoryManagement(warehouse, amount) {
    warehouse.sort((a, b) => a - b);
    let total = 0;
    let count = 0;
    for (let i = 0; i < warehouse.length && total < amount; i++) {
        total += warehouse[i];
        count++;
    }
    return count;
}