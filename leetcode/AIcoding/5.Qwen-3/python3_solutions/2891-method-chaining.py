class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def say(self, message):
        print(f"{self.name}: {message}")
        return self

    def birthday(self):
        self.age += 1
        return self

    def get_age(self):
        return self.age

    def get_name(self):
        return self.name