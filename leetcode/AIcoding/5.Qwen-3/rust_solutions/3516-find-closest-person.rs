struct Solution;

impl Solution {
    pub fn meet_people(n: i32, k: Vec<i32>, target: i32) -> i32 {
        let mut positions = vec![];
        for &k in &k {
            positions.push(k);
        }
        positions.sort();
        let mut closest = -1;
        let mut min_dist = i32::MAX;
        for &pos in &positions {
            let dist = (pos - target).abs();
            if dist < min_dist {
                min_dist = dist;
                closest = pos;
            } else if dist == min_dist {
                if pos < closest {
                    closest = pos;
                }
            }
        }
        closest
    }
}