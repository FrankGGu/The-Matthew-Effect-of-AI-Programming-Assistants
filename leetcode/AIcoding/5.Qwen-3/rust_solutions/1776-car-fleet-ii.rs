struct Solution {}

impl Solution {
    pub fn car_fleetII(mut target: i32, mut position: Vec<i32>, mut speed: Vec<i32>) -> Vec<i32> {
        let n = position.len();
        let mut cars = Vec::with_capacity(n);

        for i in 0..n {
            cars.push((position[i], speed[i]));
        }

        cars.sort_by(|a, b| b.0.cmp(&a.0));

        let mut stack = Vec::new();

        for (pos, sp) in cars {
            let time = (target - pos) as f64 / sp as f64;
            while let Some(&last_time) = stack.last() {
                if time > last_time {
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(time);
        }

        stack.into_iter().map(|t| t as i32).collect()
    }
}