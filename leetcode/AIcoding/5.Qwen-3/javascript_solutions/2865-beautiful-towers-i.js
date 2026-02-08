function getNumberOfBacklogCases(heights) {
    let buy = [];
    let sell = [];

    for (let i = 0; i < heights.length; i++) {
        let h = heights[i];
        while (sell.length > 0 && sell[sell.length - 1][0] <= h) {
            let [price, count] = sell.pop();
            if (count > h) {
                sell.push([price, count - h]);
                h = 0;
                break;
            } else {
                h -= count;
            }
        }
        if (h > 0) {
            buy.push([h, 1]);
        }

        while (buy.length > 0 && buy[buy.length - 1][0] >= h) {
            let [price, count] = buy.pop();
            if (count > h) {
                buy.push([price, count - h]);
                h = 0;
                break;
            } else {
                h -= count;
            }
        }
        if (h > 0) {
            sell.push([h, 1]);
        }
    }

    let total = 0;
    for (let [price, count] of buy) {
        total += count;
    }
    for (let [price, count] of sell) {
        total += count;
    }
    return total;
}