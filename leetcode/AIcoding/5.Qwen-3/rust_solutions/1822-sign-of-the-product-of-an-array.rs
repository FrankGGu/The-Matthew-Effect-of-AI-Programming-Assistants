struct Solution {}

impl Solution {
    pub fn sign_of_product(nums: Vec<i32>) -> i32 {
        let mut negative_count = 0;
        for num in nums {
            if num < 0 {
                negative_count += 1;
            } else if num == 0 {
                return 0;
            }
        }
        if negative_count % 2 == 0 {
            1
        } else {
            -1
        }
    }
}