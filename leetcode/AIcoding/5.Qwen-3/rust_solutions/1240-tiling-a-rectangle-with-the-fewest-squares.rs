struct Solution;

impl Solution {
    pub fn min_tiles(n: i32, m: i32) -> i32 {
        use std::collections::HashSet;

        fn dfs(n: i32, m: i32, memo: &mut HashSet<(i32, i32)>, res: &mut i32) {
            if n == 0 || m == 0 {
                return;
            }
            if n == m {
                *res = *res + 1;
                return;
            }
            if n > m {
                std::mem::swap(&mut n, &mut m);
            }
            if let Some(&v) = memo.get(&(n, m)) {
                *res += v;
                return;
            }
            let mut min = i32::MAX;
            for k in 1..n {
                dfs(k, m - k, memo, res);
                dfs(n - k, k, memo, res);
                min = min.min(*res);
                *res = 0;
            }
            for k in 1..n {
                dfs(k, m, memo, res);
                dfs(n - k, m, memo, res);
                min = min.min(*res);
                *res = 0;
            }
            for k in 1..m {
                dfs(n, k, memo, res);
                dfs(n, m - k, memo, res);
                min = min.min(*res);
                *res = 0;
            }
            *res = min + 1;
            memo.insert((n, m), *res);
        }

        let mut memo = HashSet::new();
        let mut res = 0;
        dfs(n, m, &mut memo, &mut res);
        res
    }
}