struct Solution;

impl Solution {
    pub fn max_area(height: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = height.len() as i32 - 1;
        let mut max_area = 0;

        while left < right {
            let width = right - left;
            let height = height[left as usize].min(height[right as usize]);
            let area = width * height;
            max_area = max_area.max(area);

            if height[left as usize] < height[right as usize] {
                left += 1;
            } else {
                right -= 1;
            }
        }

        max_area
    }
}