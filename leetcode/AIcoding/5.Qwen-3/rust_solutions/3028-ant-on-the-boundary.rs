struct Solution;

impl Solution {
    pub fn ant_on_the_boundary(nums: Vec<i32>) -> i32 {
        let mut position = 0;
        for num in nums {
            position += num;
            if position == 0 {
                return 1;
            }
        }
        0
    }
}