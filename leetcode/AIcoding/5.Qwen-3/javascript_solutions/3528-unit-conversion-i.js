function unitConversion(input) {
    const units = {
        's': 1,
        'ms': 1000,
        'us': 1000000,
        'ns': 1000000000
    };

    const value = parseFloat(input);
    const unit = input.slice(-2);

    if (unit === 'ms') {
        return value / 1000;
    } else if (unit === 'us') {
        return value / 1000000;
    } else if (unit === 'ns') {
        return value / 1000000000;
    } else {
        return value;
    }
}