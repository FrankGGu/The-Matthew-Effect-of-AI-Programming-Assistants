struct Person {
    name: String,
    age: i32,
}

impl Person {
    fn new(name: String, age: i32) -> Self {
        Person { name, age }
    }

    fn set_name(&mut self, name: String) -> &mut Self {
        self.name = name;
        self
    }

    fn set_age(&mut self, age: i32) -> &mut Self {
        self.age = age;
        self
    }

    fn build(self) -> Self {
        self
    }
}

fn main() {
    let person = Person::new("Alice".to_string(), 30)
        .set_name("Bob".to_string())
        .set_age(25)
        .build();
}