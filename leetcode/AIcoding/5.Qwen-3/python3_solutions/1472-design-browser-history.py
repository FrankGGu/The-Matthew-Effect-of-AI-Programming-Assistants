class BrowserHistory:

    def __init__(self, homepage: str):
        self.history = [homepage]
        self.current = 0

    def visit(self, url: str) -> None:
        while len(self.history) > self.current + 1:
            self.history.pop()
        self.history.append(url)
        self.current += 1

    def back(self, steps: int) -> str:
        self.current = max(self.current - steps, 0)
        return self.history[self.current]

    def forward(self, steps: int) -> str:
        self.current = min(self.current + steps, len(self.history) - 1)
        return self.history[self.current]