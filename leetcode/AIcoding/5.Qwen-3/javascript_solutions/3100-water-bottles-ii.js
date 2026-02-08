function waterBottles(numBottles, numExchange) {
    let total = numBottles;
    let empty = numBottles;

    while (empty >= numExchange) {
        let newBottles = Math.floor(empty / numExchange);
        total += newBottles;
        empty = (empty % numExchange) + newBottles;
    }

    return total;
}