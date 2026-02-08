impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn non_special_number_count(n: i32) -> i32 {
        let mut primes = HashSet::new();
        let mut is_prime = vec![true; n as usize + 1];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=n as usize {
            if is_prime[i] {
                primes.insert(i);
                for j in (i * i)..=n as usize {
                    is_prime[j] = false;
                }
            }
        }

        let mut count = 0;
        for i in 2..=n as usize {
            if !primes.contains(&i) {
                count += 1;
            }
        }

        count as i32
    }
}
}