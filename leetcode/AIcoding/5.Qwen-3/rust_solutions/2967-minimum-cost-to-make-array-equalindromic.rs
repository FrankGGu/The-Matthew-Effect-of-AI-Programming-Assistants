impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn min_cost_to_equalize_palindromes(nums: Vec<i32>, k: i32) -> i32 {
        fn is_palindrome(s: &str) -> bool {
            s.chars().eq(s.chars().rev())
        }

        fn to_string(num: i32) -> String {
            num.to_string()
        }

        fn cost(a: &str, b: &str) -> i32 {
            a.chars().zip(b.chars()).map(|(x, y)| if x != y { 1 } else { 0 }).sum()
        }

        let k = k as usize;
        let mut candidates = std::collections::HashSet::new();

        for &num in &nums {
            let s = to_string(num);
            for i in 0..s.len() {
                for j in i..s.len() {
                    let mut left = s[..i].to_string();
                    let mut right = s[j..].to_string();
                    let mid = s[i..j + 1].to_string();
                    let mut pal = left.clone();
                    pal.push_str(&mid);
                    pal.push_str(&right.chars().rev().collect::<String>());
                    if is_palindrome(&pal) {
                        candidates.insert(pal);
                    }
                }
            }
        }

        let mut candidates: Vec<String> = candidates.into_iter().collect();
        candidates.sort_by(|a, b| {
            let cost_a = nums.iter().map(|&num| cost(&to_string(num), a)).sum::<i32>();
            let cost_b = nums.iter().map(|&num| cost(&to_string(num), b)).sum::<i32>();
            cost_a.cmp(&cost_b)
        });

        if candidates.is_empty() {
            return 0;
        }

        let mut result = i32::MAX;
        for i in 0..std::cmp::min(k, candidates.len()) {
            let cost = nums.iter().map(|&num| cost(&to_string(num), &candidates[i])).sum::<i32>();
            result = std::cmp::min(result, cost);
        }

        result
    }
}
}