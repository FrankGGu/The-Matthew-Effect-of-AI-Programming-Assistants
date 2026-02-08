impl Solution {
    pub fn count_hill_valley_sequences(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prev = nums[0];
        let mut direction = 0; // 0: flat, 1: increasing, -1: decreasing

        for i in 1..nums.len() {
            let current = nums[i];
            if current > prev {
                if direction == -1 {
                    count += 1;
                    direction = 1;
                } else if direction == 0 {
                    direction = 1;
                }
            } else if current < prev {
                if direction == 1 {
                    count += 1;
                    direction = -1;
                } else if direction == 0 {
                    direction = -1;
                }
            }
            prev = current;
        }

        count
    }
}