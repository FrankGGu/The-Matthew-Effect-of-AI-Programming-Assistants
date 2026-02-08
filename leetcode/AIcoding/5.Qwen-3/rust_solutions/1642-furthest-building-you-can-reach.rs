impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn furthest_building(mut buildings: Vec<i32>, mut bricks: i32, mut ladders: i32) -> i32 {
        let mut heap = BinaryHeap::new();

        for i in 0..buildings.len() - 1 {
            let diff = buildings[i + 1] - buildings[i];
            if diff > 0 {
                heap.push(diff);
                if heap.len() > ladders as usize {
                    bricks -= heap.pop().unwrap();
                }
                if bricks < 0 {
                    return i as i32;
                }
            }
        }

        buildings.len() as i32 - 1
    }
}
}