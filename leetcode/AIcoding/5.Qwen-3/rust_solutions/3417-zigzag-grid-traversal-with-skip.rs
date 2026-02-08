struct ZigzagIterator {
    data: Vec<Vec<i32>>,
    row: usize,
    col: usize,
    direction: i8,
}

impl ZigzagIterator {
    fn new(v1: Vec<i32>, v2: Vec<i32>) -> Self {
        let mut data = vec![v1, v2];
        let row = 0;
        let col = 0;
        let direction = 1;
        ZigzagIterator { data, row, col, direction }
    }

    fn next(&mut self) -> i32 {
        let val = self.data[self.row][self.col];
        self.move_next();
        val
    }

    fn has_next(&self) -> bool {
        self.row < self.data.len() && self.col < self.data[self.row].len()
    }

    fn move_next(&mut self) {
        if self.direction == 1 {
            if self.row == 0 {
                self.row += 1;
                self.col = 0;
            } else {
                self.row -= 1;
                self.col += 1;
            }
        } else {
            if self.row == self.data.len() - 1 {
                self.row -= 1;
                self.col += 1;
            } else {
                self.row += 1;
                self.col -= 1;
            }
        }

        if self.row >= self.data.len() || self.col >= self.data[self.row].len() {
            self.row = 0;
            self.col = 0;
            self.direction = -self.direction;
        }
    }
}

struct Solution;

impl Solution {
    fn zigzag_iterator(mut v1: Vec<i32>, mut v2: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut iterator = ZigzagIterator::new(v1, v2);
        while iterator.has_next() {
            result.push(iterator.next());
        }
        result
    }
}