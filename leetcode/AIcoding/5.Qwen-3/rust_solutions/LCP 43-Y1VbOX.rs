struct Solution;

impl Solution {
    pub fn traffic_light(cars: Vec<Vec<i32>>) -> i32 {
        let mut time = 0;
        let mut cars_left = cars.len();

        while cars_left > 0 {
            for i in 0..cars.len() {
                if cars[i].is_empty() {
                    continue;
                }
                if cars[i][0] <= time {
                    cars[i].remove(0);
                    cars_left -= 1;
                }
            }
            time += 1;
        }

        time
    }
}