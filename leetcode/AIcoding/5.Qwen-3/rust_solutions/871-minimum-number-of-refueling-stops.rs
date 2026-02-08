impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_refuel_stops(
        target: i32,
        start_fuel: i32,
        stations: Vec<Vec<i32>>,
    ) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut fuel = start_fuel;
        let mut stops = 0;
        let mut prev = 0;

        for station in stations {
            let distance = station[0];
            let oil = station[1];

            if fuel < distance - prev {
                while fuel < distance - prev {
                    if let Some(o) = heap.pop() {
                        fuel += o;
                        stops += 1;
                    } else {
                        return -1;
                    }
                }
            }

            fuel -= distance - prev;
            prev = distance;
            heap.push(oil);
        }

        while fuel < target - prev {
            if let Some(o) = heap.pop() {
                fuel += o;
                stops += 1;
            } else {
                return -1;
            }
        }

        stops
    }
}
}