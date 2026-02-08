impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_days(n: i32) -> i32 {
        fn dfs(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
            if n <= 1 {
                return n;
            }
            if let Some(&res) = memo.get(&n) {
                return res;
            }
            let res = 1 + (n % 2) + dfs(n / 2, memo);
            let res = std::cmp::min(res, 1 + (n % 3) + dfs(n / 3, memo));
            memo.insert(n, res);
            res
        }
        let mut memo = HashMap::new();
        dfs(n, &mut memo)
    }
}
}