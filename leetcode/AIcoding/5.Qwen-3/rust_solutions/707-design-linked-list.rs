struct MyLinkedList {
    size: usize,
    head: Option<Box<Node>>,
}

struct Node {
    val: i32,
    next: Option<Box<Node>>,
}

impl MyLinkedList {
    fn new() -> Self {
        MyLinkedList { size: 0, head: None }
    }

    fn get(&self, index: i32) -> i32 {
        let index = index as usize;
        if index >= self.size {
            return -1;
        }
        let mut current = &self.head;
        for _ in 0..index {
            if let Some(node) = current {
                current = &node.next;
            } else {
                return -1;
            }
        }
        if let Some(node) = current {
            node.val
        } else {
            -1
        }
    }

    fn add_at_head(&mut self, val: i32) {
        let new_node = Box::new(Node {
            val,
            next: self.head.take(),
        });
        self.head = Some(new_node);
        self.size += 1;
    }

    fn add_at_tail(&mut self, val: i32) {
        let new_node = Box::new(Node { val, next: None });
        if self.head.is_none() {
            self.head = Some(new_node);
        } else {
            let mut current = &mut self.head;
            while let Some(node) = current {
                if node.next.is_none() {
                    node.next = Some(new_node);
                    break;
                }
                current = &mut node.next;
            }
        }
        self.size += 1;
    }

    fn add_at_index(&mut self, index: i32, val: i32) {
        let index = index as usize;
        if index > self.size {
            return;
        }
        if index == 0 {
            self.add_at_head(val);
            return;
        }
        let mut current = &mut self.head;
        for _ in 0..index - 1 {
            if let Some(node) = current {
                current = &mut node.next;
            } else {
                return;
            }
        }
        let new_node = Box::new(Node {
            val,
            next: current.as_mut().map(|n| n.next.take()),
        });
        *current = Some(new_node);
        self.size += 1;
    }

    fn delete_at_head(&mut self) {
        if self.head.is_some() {
            self.head = self.head.as_mut().unwrap().next.take();
            self.size -= 1;
        }
    }

    fn delete_at_tail(&mut self) {
        if self.head.is_none() {
            return;
        }
        if self.size == 1 {
            self.head = None;
            self.size = 0;
            return;
        }
        let mut current = &mut self.head;
        while let Some(node) = current {
            if node.next.as_ref().is_none() {
                current.take();
                break;
            }
            current = &mut node.next;
        }
        self.size -= 1;
    }

    fn delete_at_index(&mut self, index: i32) {
        let index = index as usize;
        if index >= self.size {
            return;
        }
        if index == 0 {
            self.delete_at_head();
            return;
        }
        let mut current = &mut self.head;
        for _ in 0..index - 1 {
            if let Some(node) = current {
                current = &mut node.next;
            } else {
                return;
            }
        }
        if let Some(node) = current {
            if node.next.is_some() {
                node.next = node.next.as_mut().unwrap().next.take();
            } else {
                *current = None;
            }
        }
        self.size -= 1;
    }
}