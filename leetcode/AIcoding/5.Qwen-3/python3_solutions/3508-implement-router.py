class Router:
    def __init__(self):
        self.routes = {}

    def connect(self, path, handler):
        if path not in self.routes:
            self.routes[path] = []
        self.routes[path].append(handler)

    def dispatch(self, path, data):
        if path in self.routes:
            for handler in self.routes[path]:
                handler(data)