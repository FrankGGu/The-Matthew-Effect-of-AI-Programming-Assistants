function calculateTax(brackets, income) {
    let tax = 0;
    let prevLevel = 0;
    for (const [level, percent] of brackets) {
        if (income <= 0) break;
        const currentLevel = Math.min(income, level - prevLevel);
        tax += currentLevel * percent / 100;
        income -= currentLevel;
        prevLevel = level;
    }
    return tax;
}