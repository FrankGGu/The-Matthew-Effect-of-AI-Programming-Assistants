function splitIntoFibonacci(nums) {
    const n = nums.length;
    for (let i = 1; i < n; i++) {
        if (nums[0] === 0 && i > 1) break;
        if (nums[i] === 0 && i > 1) break;
        const first = parseInt(nums.slice(0, i));
        if (first > 2 ** 31 - 1) break;
        for (let j = i + 1; j < n; j++) {
            if (nums[i] === 0 && j > i + 1) break;
            if (nums[j] === 0 && j > i + 1) break;
            const second = parseInt(nums.slice(i, j));
            if (second > 2 ** 31 - 1) break;
            const result = [first, second];
            let a = first, b = second;
            let k = j;
            while (k < n) {
                const next = a + b;
                if (next > 2 ** 31 - 1) break;
                const current = parseInt(nums.slice(k, k + String(next).length));
                if (current !== next) break;
                result.push(current);
                a = b;
                b = current;
                k += String(next).length;
            }
            if (k === n) return result;
        }
    }
    return [nums[0]];
}