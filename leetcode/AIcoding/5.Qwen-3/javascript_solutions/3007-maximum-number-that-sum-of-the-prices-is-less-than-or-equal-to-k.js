function maxNumberWithPriceLessThanK(k) {
    function getPrice(n) {
        let price = 0;
        while (n > 0) {
            price += n % 10;
            n = Math.floor(n / 10);
        }
        return price;
    }

    let left = 1, right = 1e18;
    let result = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let total = 0;
        let num = mid;
        while (num > 0) {
            total += num % 10;
            num = Math.floor(num / 10);
        }
        if (total <= k) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}