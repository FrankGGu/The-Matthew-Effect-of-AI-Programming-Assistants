impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn max_total_fruits(boxes: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = boxes.len();
        let mut positions = Vec::new();
        for i in 0..n {
            positions.push((boxes[i][0], boxes[i][1]));
        }
        positions.sort();

        let mut prefix = vec![0; n];
        prefix[0] = positions[0].1;
        for i in 1..n {
            prefix[i] = prefix[i - 1] + positions[i].1;
        }

        let mut max_fruits = 0;
        let mut heap = BinaryHeap::new();

        for i in 0..n {
            let (pos, fruits) = positions[i];
            let mut total = fruits;
            let mut left = i;
            let mut right = i;

            while left > 0 || right < n - 1 {
                let mut next_left = None;
                let mut next_right = None;

                if left > 0 {
                    let dist_left = positions[left - 1].0 - pos;
                    next_left = Some((positions[left - 1].0, left - 1));
                }
                if right < n - 1 {
                    let dist_right = positions[right + 1].0 - pos;
                    next_right = Some((positions[right + 1].0, right + 1));
                }

                if next_left.is_none() && next_right.is_none() {
                    break;
                }

                if next_left.is_some() && next_right.is_none() {
                    let (next_pos, next_idx) = next_left.unwrap();
                    let dist = next_pos - pos;
                    if dist <= k {
                        total += positions[next_idx].1;
                        left = next_idx;
                        pos = next_pos;
                    } else {
                        break;
                    }
                } else if next_right.is_some() && next_left.is_none() {
                    let (next_pos, next_idx) = next_right.unwrap();
                    let dist = next_pos - pos;
                    if dist <= k {
                        total += positions[next_idx].1;
                        right = next_idx;
                        pos = next_pos;
                    } else {
                        break;
                    }
                } else {
                    let (next_pos_l, next_idx_l) = next_left.unwrap();
                    let (next_pos_r, next_idx_r) = next_right.unwrap();
                    let dist_l = next_pos_l - pos;
                    let dist_r = next_pos_r - pos;

                    if dist_l <= k && dist_r <= k {
                        if dist_l < dist_r {
                            total += positions[next_idx_l].1;
                            left = next_idx_l;
                            pos = next_pos_l;
                        } else {
                            total += positions[next_idx_r].1;
                            right = next_idx_r;
                            pos = next_pos_r;
                        }
                    } else if dist_l <= k {
                        total += positions[next_idx_l].1;
                        left = next_idx_l;
                        pos = next_pos_l;
                    } else if dist_r <= k {
                        total += positions[next_idx_r].1;
                        right = next_idx_r;
                        pos = next_pos_r;
                    } else {
                        break;
                    }
                }
            }

            max_fruits = std::cmp::max(max_fruits, total);
        }

        max_fruits
    }
}
}