var inventoryManagement = function(stock) {
    let min = stock[0];
    for (let i = 1; i < stock.length; i++) {
        if (stock[i] < min) {
            min = stock[i];
        }
    }
    return min;
};