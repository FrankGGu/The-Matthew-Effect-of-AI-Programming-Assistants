impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn shortest_superstring(mut A: Vec<String>) -> String {
        let n = A.len();
        let mut dist = vec![vec![0; n]; n];

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let a = &A[i];
                    let b = &A[j];
                    let min_len = std::cmp::min(a.len(), b.len());
                    let mut k = 0;
                    while k < min_len && a.as_bytes()[a.len() - 1 - k] == b.as_bytes()[k] {
                        k += 1;
                    }
                    dist[i][j] = k;
                }
            }
        }

        let mut dp = vec![vec![0; n]; 1 << n];
        let mut prev = vec![vec![-1; n]; 1 << n];

        for mask in 1..(1 << n) {
            for last in 0..n {
                if (mask >> last) & 1 == 0 {
                    continue;
                }
                for prev_mask in 0..(1 << n) {
                    if (mask & prev_mask) != prev_mask {
                        continue;
                    }
                    if prev_mask == mask {
                        continue;
                    }
                    for prev_last in 0..n {
                        if (prev_mask >> prev_last) & 1 == 0 {
                            continue;
                        }
                        if dp[prev_mask][prev_last] + dist[prev_last][last] > dp[mask][last] {
                            dp[mask][last] = dp[prev_mask][prev_last] + dist[prev_last][last];
                            prev[mask][last] = prev_last;
                        }
                    }
                }
            }
        }

        let mut best = 0;
        let mut best_len = 0;
        for i in 0..n {
            if dp[(1 << n) - 1][i] > best_len {
                best_len = dp[(1 << n) - 1][i];
                best = i;
            }
        }

        let mut mask = (1 << n) - 1;
        let mut path = VecDeque::new();
        path.push_front(best);
        while mask != 0 {
            let last = path[0];
            let p = prev[mask][last];
            path.push_front(p);
            mask ^= 1 << last;
        }

        let mut result = A[path[0]].clone();
        for i in 1..path.len() {
            let a = &A[path[i - 1]];
            let b = &A[path[i]];
            let overlap = dist[path[i - 1]][path[i]];
            result.push_str(&b[overlap..]);
        }

        result
    }
}
}