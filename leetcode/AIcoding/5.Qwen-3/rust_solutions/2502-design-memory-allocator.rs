struct Allocator {
    memory: Vec<u8>,
}

impl Allocator {
    fn new(n: i32) -> Self {
        Allocator {
            memory: vec![0; n as usize],
        }
    }

    fn allocate(&mut self, size: i32, m_id: i32) -> i32 {
        let mut start = -1;
        let mut count = 0;

        for i in 0..self.memory.len() {
            if self.memory[i] == 0 {
                count += 1;
                if count == size as usize {
                    start = i as i32 - size + 1;
                    break;
                }
            } else {
                count = 0;
            }
        }

        if start != -1 {
            for i in start as usize..(start as usize + size as usize) {
                self.memory[i] = m_id as u8;
            }
        }

        start
    }

    fn free(&mut self, m_id: i32) -> i32 {
        let mut count = 0;

        for i in 0..self.memory.len() {
            if self.memory[i] == m_id as u8 {
                self.memory[i] = 0;
                count += 1;
            }
        }

        count
    }
}