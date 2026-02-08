struct Solution;

impl Solution {
    pub fn sort_by_bit(mut nums: Vec<i32>) -> Vec<i32> {
        nums.sort_by(|&a, &b| {
            let bits_a = a.count_ones();
            let bits_b = b.count_ones();
            if bits_a == bits_b {
                a.cmp(&b)
            } else {
                bits_a.cmp(&bits_b)
            }
        });
        nums
    }
}