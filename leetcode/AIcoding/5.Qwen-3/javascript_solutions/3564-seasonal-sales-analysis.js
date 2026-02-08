function seasonalSalesAnalysis(sales) {
    const seasonMap = {
        'Winter': [],
        'Spring': [],
        'Summer': [],
        'Autumn': []
    };

    for (const sale of sales) {
        const date = new Date(sale.date);
        const month = date.getMonth();

        if (month >= 0 && month <= 1) {
            seasonMap.Winter.push(sale.amount);
        } else if (month >= 2 && month <= 4) {
            seasonMap.Spring.push(sale.amount);
        } else if (month >= 5 && month <= 7) {
            seasonMap.Summer.push(sale.amount);
        } else {
            seasonMap.Autumn.push(sale.amount);
        }
    }

    const result = {};
    for (const season in seasonMap) {
        const sum = seasonMap[season].reduce((a, b) => a + b, 0);
        const count = seasonMap[season].length;
        result[season] = count === 0 ? 0 : sum / count;
    }

    return result;
}