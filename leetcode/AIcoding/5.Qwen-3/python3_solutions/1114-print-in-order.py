class Foo:
    def __init__(self):
        self.first_done = False
        self.second_done = False

    def first(self, printFirst: 'Callable[[], None]') -> None:
        printFirst()
        self.first_done = True

    def second(self, printSecond: 'Callable[[], None]') -> None:
        while not self.first_done:
            pass
        printSecond()
        self.second_done = True

    def third(self, printThird: 'Callable[[], None]') -> None:
        while not self.second_done:
            pass
        printThird()