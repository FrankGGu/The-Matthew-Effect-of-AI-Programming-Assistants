impl Solution {
    pub fn total_strength(arr: Vec<i32>) -> i32 {
        let mod_val = 10i64.pow(9) + 7;
        let n = arr.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut stack = Vec::new();
        for i in 0..n {
            while let Some(&j) = stack.last() {
                if arr[j] > arr[i] {
                    break;
                }
                stack.pop();
            }
            left[i] = if let Some(&j) = stack.last() { j + 1 } else { 0 };
            stack.push(i);
        }
        stack.clear();
        for i in (0..n).rev() {
            while let Some(&j) = stack.last() {
                if arr[j] >= arr[i] {
                    break;
                }
                stack.pop();
            }
            right[i] = if let Some(&j) = stack.last() { j - 1 } else { n as i32 - 1 };
            stack.push(i);
        }
        let prefix = Self::prefix_sum(&arr);
        let prefix2 = Self::prefix_sum(&prefix);
        let mut result = 0i64;
        for i in 0..n {
            let l = left[i];
            let r = right[i];
            let a = l;
            let b = i;
            let c = i;
            let d = r;
            let sum1 = (prefix2[(d + 1) as usize] - prefix2[(c + 1) as usize]) * (b - a + 1);
            let sum2 = (prefix2[(b + 1) as usize] - prefix2[(a + 1) as usize]) * (d - c + 1);
            let sum = (sum1 - sum2) % mod_val;
            let val = (arr[i] as i64 * sum) % mod_val;
            result = (result + val) % mod_val;
        }
        result as i32
    }

    fn prefix_sum(arr: &[i32]) -> Vec<i64> {
        let n = arr.len();
        let mut res = vec![0; n + 1];
        for i in 0..n {
            res[i + 1] = res[i] + arr[i] as i64;
        }
        res
    }
}