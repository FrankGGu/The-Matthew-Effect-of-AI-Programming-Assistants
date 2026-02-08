function timeRequiredToBuy(tickets, k) {
    let time = 0;
    for (let i = 0; i < tickets.length; i++) {
        if (i < k) {
            time += Math.min(tickets[i], tickets[k]);
        } else if (i > k) {
            time += Math.min(tickets[i], tickets[k] - 1);
        } else {
            time += tickets[k];
        }
    }
    return time;
}