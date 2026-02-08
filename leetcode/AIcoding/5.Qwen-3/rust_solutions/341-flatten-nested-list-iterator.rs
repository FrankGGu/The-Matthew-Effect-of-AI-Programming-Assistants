pub struct NestedIterator {
    stack: Vec<Box<dyn Iterator<Item = i32>>>,
}

impl NestedIterator {
    pub fn new(nested_list: Vec<NestedInteger>) -> Self {
        let mut iter = nested_list.into_iter().map(|x| Box::new(x.into_iter()) as Box<dyn Iterator<Item = i32>>);
        let first = iter.next();
        NestedIterator { stack: vec![first.unwrap()] }
    }

    pub fn next(&mut self) -> i32 {
        let item = self.stack.last_mut().unwrap().next().unwrap();
        if self.stack.last().unwrap().next().is_none() {
            self.stack.pop();
        }
        item
    }

    pub fn has_next(&self) -> bool {
        while let Some(iter) = self.stack.last() {
            if let Some(_) = iter.next() {
                return true;
            } else {
                self.stack.pop();
            }
        }
        false
    }
}

#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

impl From<NestedInteger> for Box<dyn Iterator<Item = i32>> {
    fn from(val: NestedInteger) -> Self {
        match val {
            NestedInteger::Int(i) => Box::new(std::iter::once(i)),
            NestedInteger::List(list) => {
                let iter = list.into_iter().flat_map(|x| Box::new(x.into_iter()));
                Box::new(iter)
            }
        }
    }
}