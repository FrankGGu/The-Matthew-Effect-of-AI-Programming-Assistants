impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_printable(plate: Vec<Vec<i32>>) -> bool {
        let rows = plate.len();
        let cols = plate[0].len();
        let mut color_regions = std::collections::HashMap::new();

        for i in 0..rows {
            for j in 0..cols {
                let color = plate[i][j];
                color_regions.entry(color).or_insert_with(Vec::new).push((i, j));
            }
        }

        let mut graph = std::collections::HashMap::new();
        let mut in_degree = std::collections::HashMap::new();

        for (&color, regions) in &color_regions {
            let (min_row, max_row, min_col, max_col) = regions.iter().fold(
                (rows as i32, -1, cols as i32, -1),
                |(min_r, max_r, min_c, max_c), &(r, c)| {
                    (
                        std::cmp::min(min_r, r as i32),
                        std::cmp::max(max_r, r as i32),
                        std::cmp::min(min_c, c as i32),
                        std::cmp::max(max_c, c as i32),
                    )
                },
            );

            for i in min_row..=max_row {
                for j in min_col..=max_col {
                    let neighbor_color = plate[i as usize][j as usize];
                    if neighbor_color != color {
                        graph.entry(color).or_insert_with(Vec::new).push(neighbor_color);
                        in_degree.entry(neighbor_color).or_insert(0);
                        *in_degree.get_mut(&neighbor_color).unwrap() += 1;
                    }
                }
            }
        }

        let mut queue = VecDeque::new();
        for (&color, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(color);
            }
        }

        let mut visited = HashSet::new();
        while let Some(color) = queue.pop_front() {
            visited.insert(color);
            if let Some(neighbors) = graph.get(&color) {
                for &neighbor in neighbors {
                    *in_degree.get_mut(&neighbor).unwrap() -= 1;
                    if *in_degree.get(&neighbor).unwrap() == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        visited.len() == color_regions.len()
    }
}
}