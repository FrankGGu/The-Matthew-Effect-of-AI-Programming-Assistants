struct Solution;

impl Solution {
    pub fn find_maximum_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        let mut mask = 0;

        for i in (0..31).rev() {
            mask |= 1 << i;
            let mut prefixes = std::collections::HashSet::new();
            for &num in &nums {
                prefixes.insert(num & mask);
            }

            let temp = max_xor | (1 << i);
            for &prefix in &prefixes {
                if prefixes.contains(&(prefix ^ temp)) {
                    max_xor = temp;
                    break;
                }
            }
        }

        max_xor
    }
}