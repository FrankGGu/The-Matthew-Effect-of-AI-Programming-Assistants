impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn maximum_number_of_distinct_primes(mut n: i32) -> i32 {
        let primes = vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47];
        let mut count = 0;
        for &p in &primes {
            while n % p == 0 {
                count += 1;
                n /= p;
            }
        }
        count
    }
}
}