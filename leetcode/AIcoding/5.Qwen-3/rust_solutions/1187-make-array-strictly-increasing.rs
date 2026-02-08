impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_min_operations(arr: Vec<i32>) -> i32 {
        fn dfs(i: usize, prev: i32, memo: &mut HashMap<(usize, i32), i32>, arr: &Vec<i32>) -> i32 {
            if i == arr.len() {
                return 0;
            }
            if let Some(&res) = memo.get(&(i, prev)) {
                return res;
            }
            let mut res = i32::MAX;
            let current = arr[i];
            // Option 1: keep the current value as is, if it's larger than previous
            if current > prev {
                res = res.min(dfs(i + 1, current, memo, arr));
            }
            // Option 2: increment the current value to be at least prev + 1
            let new_val = prev + 1;
            res = res.min(1 + dfs(i + 1, new_val, memo, arr));
            memo.insert((i, prev), res);
            res
        }

        let mut memo = HashMap::new();
        dfs(0, -1, &mut memo, &arr)
    }
}
}