function numberToWords(num) {
    if (num === 0) return "Zero";

    const lessThan20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
    const tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
    const thousands = ["", "Thousand", "Million", "Billion"];

    function helper(num) {
        if (num === 0) return "";
        if (num < 20) return lessThan20[num];
        if (num < 100) return tens[Math.floor(num / 10)] + (num % 10 !== 0 ? " " + lessThan20[num % 10] : "");
        if (num < 1000) {
            return lessThan20[Math.floor(num / 100)] + " Hundred" + (num % 100 !== 0 ? " " + helper(num % 100) : "");
        }
        for (let i = 3; i >= 1; i--) {
            const value = Math.pow(1000, i);
            if (num >= value) {
                return helper(Math.floor(num / value)) + " " + thousands[i] + (num % value !== 0 ? " " + helper(num % value) : "");
            }
        }
        return "";
    }

    return helper(num).trim();
}