struct Solution;

impl Solution {
    pub fn find_radius(houses: Vec<i32>, heaters: Vec<i32>) -> i32 {
        let mut heaters = heaters;
        heaters.sort();
        let mut max_dist = 0;
        for &house in &houses {
            let mut left = 0;
            let mut right = heaters.len() as i32 - 1;
            while left < right {
                let mid = (left + right) / 2;
                if heaters[mid] < house {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            let mut dist = i32::MAX;
            if left < heaters.len() as i32 {
                dist = heaters[left] - house;
            }
            if left > 0 {
                dist = std::cmp::min(dist, house - heaters[left as usize - 1]);
            }
            max_dist = std::cmp::max(max_dist, dist);
        }
        max_dist
    }
}