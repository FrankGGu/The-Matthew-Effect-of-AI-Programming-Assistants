impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_length_of_optimal_compression(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut memo = HashMap::new();

        fn dp(i: usize, k: usize, last: u8, count: i32, memo: &mut HashMap<(usize, usize, u8, i32), i32>, s: &[u8]) -> i32 {
            if i == s.len() {
                return 0;
            }
            if let Some(&res) = memo.get(&(i, k, last, count)) {
                return res;
            }

            let mut res = if count > 0 {
                dp(i + 1, k, s[i], count + 1, memo, s)
            } else {
                i32::MAX
            };

            if k > 0 {
                res = res.min(dp(i + 1, k - 1, last, count, memo, s));
            }

            if s[i] == last {
                let cost = if count >= 1 && count < 9 { 1 } else if count >= 9 && count < 99 { 2 } else { 3 };
                res = res.min(cost + dp(i + 1, k, last, count + 1, memo, s));
            } else {
                res = res.min(dp(i + 1, k, s[i], 1, memo, s));
            }

            memo.insert((i, k, last, count), res);
            res
        }

        dp(0, k, 0, 0, &mut memo, &s)
    }
}
}