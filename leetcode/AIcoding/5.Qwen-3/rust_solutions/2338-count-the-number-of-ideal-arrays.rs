impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn ideal_arrays(n: i32, m: i32) -> i32 {
        let mut dp = vec![0; 100001];
        let mut freq = HashMap::new();
        let mut res = 0;

        for i in 1..=m as usize {
            let mut x = i;
            let mut factors = Vec::new();
            let mut j = 2;
            while j * j <= x {
                while x % j == 0 {
                    factors.push(j);
                    x /= j;
                }
                j += 1;
            }
            if x > 1 {
                factors.push(x);
            }

            let mut cnt = 1;
            let mut prev = -1;
            for &f in &factors {
                if f != prev {
                    cnt *= 2;
                    prev = f;
                }
            }

            if cnt > 1 {
                *freq.entry(cnt).or_insert(0) += 1;
            }
        }

        for (k, &count) in freq.iter() {
            let mut ways = 1;
            for i in 1..*k {
                ways = ways * (n - i + 1) / i;
            }
            res = (res + ways * count) as i32;
        }

        res
    }
}
}