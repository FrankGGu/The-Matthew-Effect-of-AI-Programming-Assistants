impl Solution {

use std::collections::HashMap;

struct DetectSquares {
    points: HashMap<(i32, i32), i32>,
}

impl DetectSquares {
    fn new() -> Self {
        DetectSquares {
            points: HashMap::new(),
        }
    }

    fn add_point(&mut self, point: Vec<i32>) {
        let (x, y) = (point[0], point[1]);
        *self.points.entry((x, y)).or_insert(0) += 1;
    }

    fn remove_point(&mut self, point: Vec<i32>) {
        let (x, y) = (point[0], point[1]);
        if let Some(count) = self.points.get_mut(&(x, y)) {
            *count -= 1;
            if *count == 0 {
                self.points.remove(&(x, y));
            }
        }
    }

    fn count_squares(&self) -> i32 {
        let mut result = 0;
        let points: Vec<((i32, i32), i32)> = self.points.iter().map(|(&k, &v)| (k, v)).collect();
        for ((x1, y1), count1) in &points {
            for ((x2, y2), count2) in &points {
                if x1 == x2 || y1 == y2 {
                    continue;
                }
                let dx = x2 - x1;
                let dy = y2 - y1;
                let x3 = x1 + dy;
                let y3 = y1 - dx;
                let x4 = x2 + dy;
                let y4 = y2 - dx;
                if let Some(count3) = self.points.get(&(x3, y3)) {
                    if let Some(count4) = self.points.get(&(x4, y4)) {
                        result += count1 * count2 * *count3 * *count4;
                    }
                }
            }
        }
        result
    }

    fn count(&self, point: Vec<i32>) -> i32 {
        let (x, y) = (point[0], point[1]);
        let mut result = 0;
        for ((x1, y1), count1) in &self.points {
            if x1 == &x || y1 == &y {
                continue;
            }
            let dx = x1 - x;
            let dy = y1 - y;
            let x2 = x + dy;
            let y2 = y - dx;
            let x3 = x1 + dy;
            let y3 = y1 - dx;
            if let Some(count2) = self.points.get(&(x2, y2)) {
                if let Some(count3) = self.points.get(&(x3, y3)) {
                    result += *count1 * *count2 * *count3;
                }
            }
        }
        result
    }
}

fn main() {
    let mut obj = DetectSquares::new();
    obj.add_point(vec![3, 10]);
    obj.add_point(vec![11, 2]);
    obj.add_point(vec![3, 2]);
    obj.add_point(vec![11, 10]);
    println!("{}", obj.count_squares());
}
}