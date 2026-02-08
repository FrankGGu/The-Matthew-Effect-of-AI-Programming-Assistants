impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct Cell {
    height: i32,
    row: usize,
    col: usize,
}

impl Ord for Cell {
    fn cmp(&self, other: &Self) -> Ordering {
        other.height.cmp(&self.height)
    }
}

impl PartialOrd for Cell {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn trap_rain_water(height_map: Vec<Vec<i32>>) -> i32 {
        if height_map.is_empty() || height_map[0].is_empty() {
            return 0;
        }

        let rows = height_map.len();
        let cols = height_map[0].len();

        let mut visited = vec![vec![false; cols]; rows];
        let mut heap = BinaryHeap::new();

        for i in 0..rows {
            visited[i][0] = true;
            visited[i][cols - 1] = true;
            heap.push(Cell {
                height: height_map[i][0],
                row: i,
                col: 0,
            });
            heap.push(Cell {
                height: height_map[i][cols - 1],
                row: i,
                col: cols - 1,
            });
        }

        for j in 0..cols {
            visited[0][j] = true;
            visited[rows - 1][j] = true;
            heap.push(Cell {
                height: height_map[0][j],
                row: 0,
                col: j,
            });
            heap.push(Cell {
                height: height_map[rows - 1][j],
                row: rows - 1,
                col: j,
            });
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut result = 0;

        while let Some(cell) = heap.pop() {
            for &(dr, dc) in &directions {
                let r = cell.row as i32 + dr;
                let c = cell.col as i32 + dc;
                if r >= 0 && r < rows as i32 && c >= 0 && c < cols as i32 && !visited[r as usize][c as usize] {
                    visited[r as usize][c as usize] = true;
                    let new_height = height_map[r as usize][c as usize];
                    if new_height < cell.height {
                        result += cell.height - new_height;
                    }
                    heap.push(Cell {
                        height: new_height,
                        row: r as usize,
                        col: c as usize,
                    });
                }
            }
        }

        result
    }
}
}