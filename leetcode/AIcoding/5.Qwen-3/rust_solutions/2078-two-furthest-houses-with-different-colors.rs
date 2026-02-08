struct Solution;

impl Solution {
    pub fn max_distance(mut colors: Vec<i32>) -> i32 {
        let n = colors.len();
        let mut max_dist = 0;
        let mut left = 0;
        let mut right = n - 1;

        while left < right {
            if colors[left] != colors[right] {
                max_dist = (right - left) as i32;
                break;
            }

            if colors[left] == colors[0] {
                left += 1;
            } else {
                right -= 1;
            }
        }

        if max_dist == 0 {
            for i in 0..n {
                for j in (i + 1)..n {
                    if colors[i] != colors[j] {
                        max_dist = (j - i) as i32;
                    }
                }
            }
        }

        max_dist
    }
}