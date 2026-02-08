struct Solution;

impl Solution {
    pub fn count_max_sq(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut max_side = 0;
        let mut count = 0;

        for rect in rectangles {
            let side = rect[0].min(rect[1]);
            if side > max_side {
                max_side = side;
                count = 1;
            } else if side == max_side {
                count += 1;
            }
        }

        count
    }
}