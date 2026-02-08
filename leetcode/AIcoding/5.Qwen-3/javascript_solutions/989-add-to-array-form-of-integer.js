function addToArrayForm(num, k) {
    let i = num.length - 1;
    let carry = 0;

    while (i >= 0 || k > 0) {
        let sum = carry;
        if (i >= 0) sum += num[i];
        if (k > 0) sum += k % 10;

        num[i] = sum % 10;
        carry = Math.floor(sum / 10);

        i--;
        k = Math.floor(k / 10);
    }

    if (carry > 0) {
        num.unshift(carry);
    }

    return num;
}