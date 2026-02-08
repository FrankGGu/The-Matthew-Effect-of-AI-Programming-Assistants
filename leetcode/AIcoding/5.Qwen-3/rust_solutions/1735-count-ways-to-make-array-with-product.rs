impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_ways(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1000000007;

        fn factorize(mut n: i32, factors: &mut HashMap<i32, i32>) {
            while n % 2 == 0 {
                *factors.entry(2).or_insert(0) += 1;
                n /= 2;
            }
            let mut i = 3;
            while i * i <= n {
                while n % i == 0 {
                    *factors.entry(i).or_insert(0) += 1;
                    n /= i;
                }
                i += 2;
            }
            if n > 2 {
                *factors.entry(n).or_insert(0) += 1;
            }
        }

        let mut product = 1;
        for &num in &nums {
            product *= num;
        }

        let mut factors = HashMap::new();
        factorize(product, &mut factors);

        let mut result = 1;
        for &count in factors.values() {
            result = (result * (count + 1)) % MOD;
        }

        result
    }
}
}