function analyzeSubscriptionConversion(customers) {
    let totalSubscribed = 0;
    let totalCustomers = 0;

    for (let i = 0; i < customers.length; i++) {
        const [name, status] = customers[i];
        if (status === 'subscribed') {
            totalSubscribed++;
        }
        totalCustomers++;
    }

    return Math.round((totalSubscribed / totalCustomers) * 100);
}