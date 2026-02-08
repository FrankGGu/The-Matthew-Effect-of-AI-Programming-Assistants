impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_boxes(boxes: Vec<Vec<i32>>) -> i32 {
        boxes.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut result = 0;
        let mut current_height = 0;

        for box_ in boxes {
            let (x, y) = (box_[0], box_[1]);
            match x.cmp(&current_height) {
                Ordering::Less => {
                    result += 1;
                    current_height = y;
                }
                Ordering::Equal => {
                    result += 1;
                    current_height = y;
                }
                Ordering::Greater => {
                    if y > current_height {
                        result += 1;
                        current_height = y;
                    }
                }
            }
        }

        result
    }
}
}