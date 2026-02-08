function convertDateToBinary(date) {
    const [year, month, day] = date.split('-').map(Number);
    const toBinary = (num) => num.toString(2);
    return `${toBinary(year)}-${toBinary(month)}-${toBinary(day)}`;
}