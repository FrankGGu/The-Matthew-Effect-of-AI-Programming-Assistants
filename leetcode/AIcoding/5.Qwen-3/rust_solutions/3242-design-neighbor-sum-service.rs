struct NeighborSumService {
    grid: Vec<Vec<i32>>,
}

impl NeighborSumService {
    fn new(grid: Vec<Vec<i32>>) -> Self {
        NeighborSumService { grid }
    }

    fn sum(self, x: i32, y: i32) -> i32 {
        let mut sum = 0;
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        for &(dx, dy) in &directions {
            let nx = x + dx;
            let ny = y + dy;
            if nx >= 0 && ny >= 0 && nx < self.grid.len() as i32 && ny < self.grid[0].len() as i32 {
                sum += self.grid[nx as usize][ny as usize];
            }
        }
        sum
    }
}