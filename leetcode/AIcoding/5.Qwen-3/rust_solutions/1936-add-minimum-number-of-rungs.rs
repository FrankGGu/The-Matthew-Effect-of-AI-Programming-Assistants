impl Solution {
    pub fn add_rungs(rungs: Vec<i32>, rung_height: i32) -> i32 {
        let mut count = 0;
        let mut prev = 0;
        for &height in &rungs {
            if height - prev > rung_height {
                count += (height - prev - 1) / rung_height;
            }
            prev = height;
        }
        count
    }
}