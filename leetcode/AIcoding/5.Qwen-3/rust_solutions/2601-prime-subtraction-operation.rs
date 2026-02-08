impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn prime_subtraction_operation(nums: Vec<i32>) -> bool {
        let max_num = *nums.iter().max().unwrap();
        let primes = Self::generate_primes(max_num);

        let mut nums_sorted = nums.clone();
        nums_sorted.sort_by(|a, b| b.cmp(a));

        for i in 0..nums_sorted.len() {
            let mut found = false;
            for &p in &primes {
                if p < nums_sorted[i] {
                    let target = nums_sorted[i] - p;
                    if i + 1 < nums_sorted.len() && target <= nums_sorted[i + 1] {
                        nums_sorted[i] = target;
                        found = true;
                        break;
                    }
                }
            }
            if !found {
                return false;
            }
        }

        true
    }

    fn generate_primes(n: i32) -> Vec<i32> {
        let n = n as usize;
        let mut is_prime = vec![true; n + 1];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=n {
            if is_prime[i] {
                for j in (i * i)..=n {
                    is_prime[j] = false;
                }
            }
        }

        let mut primes = Vec::new();
        for i in 2..=n {
            if is_prime[i] {
                primes.push(i as i32);
            }
        }

        primes
    }
}
}