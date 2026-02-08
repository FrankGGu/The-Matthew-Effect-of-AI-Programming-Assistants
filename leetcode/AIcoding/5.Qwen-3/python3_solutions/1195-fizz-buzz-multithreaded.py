import threading

class FizzBuzz:
    def __init__(self, n: int):
        self.n = n
        self.count = 1
        self.lock = threading.Condition()

    def fizz(self, printFizz: 'callable') -> None:
        while self.count <= self.n:
            with self.lock:
                while self.count <= self.n and not (self.count % 3 == 0 and self.count % 5 != 0):
                    self.lock.wait()
                if self.count > self.n:
                    break
                printFizz()
                self.count += 1
                self.lock.notify_all()

    def buzz(self, printBuzz: 'callable') -> None:
        while self.count <= self.n:
            with self.lock:
                while self.count <= self.n and not (self.count % 5 == 0 and self.count % 3 != 0):
                    self.lock.wait()
                if self.count > self.n:
                    break
                printBuzz()
                self.count += 1
                self.lock.notify_all()

    def fizzbuzz(self, printFizzBuzz: 'callable') -> None:
        while self.count <= self.n:
            with self.lock:
                while self.count <= self.n and not (self.count % 3 == 0 and self.count % 5 == 0):
                    self.lock.wait()
                if self.count > self.n:
                    break
                printFizzBuzz()
                self.count += 1
                self.lock.notify_all()

    def number(self, printNumber: 'callable') -> None:
        while self.count <= self.n:
            with self.lock:
                while self.count <= self.n and not (self.count % 3 != 0 and self.count % 5 != 0):
                    self.lock.wait()
                if self.count > self.n:
                    break
                printNumber(self.count)
                self.count += 1
                self.lock.notify_all()