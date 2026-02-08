function shortestBeautifulString(s) {
    const n = s.length;
    const chars = s.split('');

    function isBeautiful(s) {
        for (let i = 0; i < s.length - 1; i++) {
            if (s[i] === s[i + 1]) return false;
        }
        return true;
    }

    function nextPermutation(arr) {
        let i = arr.length - 2;
        while (i >= 0 && arr[i] >= arr[i + 1]) i--;
        if (i < 0) return false;

        let j = arr.length - 1;
        while (arr[j] <= arr[i]) j--;

        [arr[i], arr[j]] = [arr[j], arr[i]];

        let left = i + 1;
        let right = arr.length - 1;
        while (left < right) {
            [arr[left], arr[right]] = [arr[right], arr[left]];
            left++;
            right--;
        }

        return true;
    }

    let minLen = Infinity;
    let result = '';

    for (let len = n; len <= n + 10; len++) {
        if (len > n + 10) break;
        let temp = chars.slice();
        let current = temp.join('');

        if (isBeautiful(current)) {
            if (current.length < minLen || (current.length === minLen && current < result)) {
                minLen = current.length;
                result = current;
            }
        }

        while (nextPermutation(temp)) {
            current = temp.join('');
            if (isBeautiful(current)) {
                if (current.length < minLen || (current.length === minLen && current < result)) {
                    minLen = current.length;
                    result = current;
                }
            }
        }
    }

    return result;
}