struct Solution;

impl Solution {
    pub fn watering_plants(a: Vec<i32>, capacity: i32) -> i32 {
        let mut current = capacity;
        let mut steps = 0;
        for (i, &water) in a.iter().enumerate() {
            if current < water {
                current = capacity;
                steps += 2 * i as i32;
            }
            current -= water;
            steps += 1;
        }
        steps
    }
}