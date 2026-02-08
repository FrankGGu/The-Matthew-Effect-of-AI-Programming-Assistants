struct Solution;

impl Solution {
    pub fn min_elements(mut nums: Vec<i32>, mut limit: i32, mut target: i32) -> i32 {
        let mut count = 0;
        while target > 0 {
            let mut add = 0;
            for &num in &nums {
                if num <= target {
                    add += num;
                }
            }
            if add == 0 {
                return -1;
            }
            target -= add;
            count += 1;
        }
        count
    }
}