impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn closest_primes(left: i32, right: i32) -> Vec<i32> {
        let mut primes = vec![];
        let mut is_prime = vec![true; (right + 1) as usize];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=(right as usize) {
            if is_prime[i] {
                primes.push(i as i32);
                for j in (i * i)..=(right as usize) {
                    is_prime[j] = false;
                }
            }
        }

        let mut min_diff = i32::MAX;
        let mut result = vec![-1, -1];

        for i in 1..primes.len() {
            if primes[i] - primes[i - 1] < min_diff {
                min_diff = primes[i] - primes[i - 1];
                result = vec![primes[i - 1], primes[i]];
            }
        }

        if min_diff == i32::MAX {
            vec![-1, -1]
        } else {
            result
        }
    }
}
}