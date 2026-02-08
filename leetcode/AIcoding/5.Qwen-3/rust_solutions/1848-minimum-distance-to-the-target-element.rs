struct Solution;

impl Solution {
    pub fn get_distance_to_target(nums: Vec<i32>, target: i32, start: i32) -> i32 {
        let mut min_dist = i32::MAX;
        for (i, &num) in nums.iter().enumerate() {
            if num == target {
                let dist = (i as i32 - start).abs();
                if dist < min_dist {
                    min_dist = dist;
                }
            }
        }
        min_dist
    }
}