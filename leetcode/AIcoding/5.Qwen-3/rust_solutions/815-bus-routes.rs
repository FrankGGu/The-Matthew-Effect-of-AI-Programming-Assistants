impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn num_buses_to_destination(routes: Vec<Vec<i32>>, source: i32, target: i32) -> i32 {
        if source == target {
            return 0;
        }

        let mut route_stops: Vec<HashSet<i32>> = routes
            .into_iter()
            .map(|route| route.into_iter().collect())
            .collect();

        let mut visited_routes = HashSet::new();
        let mut visited_stops = HashSet::new();
        let mut queue = VecDeque::new();

        for (i, route) in route_stops.iter().enumerate() {
            if route.contains(&source) {
                visited_routes.insert(i);
                queue.push_back((i, 1));
                visited_stops.insert(source);
            }
        }

        while let Some((route_idx, buses)) = queue.pop_front() {
            for stop in &route_stops[route_idx] {
                if *stop == target {
                    return buses;
                }
                if visited_stops.contains(stop) {
                    continue;
                }
                visited_stops.insert(*stop);
                for (i, route) in route_stops.iter().enumerate() {
                    if route.contains(stop) && !visited_routes.contains(&i) {
                        visited_routes.insert(i);
                        queue.push_back((i, buses + 1));
                    }
                }
            }
        }

        -1
    }
}
}