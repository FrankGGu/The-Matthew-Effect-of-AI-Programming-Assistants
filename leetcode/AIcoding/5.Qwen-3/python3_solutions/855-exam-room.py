class ExamRoom:
    def __init__(self, n: int):
        self.n = n
        self.seats = []

    def seat(self) -> int:
        if not self.seats:
            self.seats.append(0)
            return 0
        max_dist = 0
        insert_pos = 0
        for i in range(len(self.seats)):
            if i == 0:
                dist = self.seats[i]
            elif i == len(self.seats) - 1:
                dist = self.n - 1 - self.seats[i]
            else:
                dist = (self.seats[i] - self.seats[i - 1]) // 2
            if dist > max_dist:
                max_dist = dist
                insert_pos = self.seats[i - 1] + dist if i > 0 else 0
        if max_dist == 0:
            self.seats.append(0)
            return 0
        self.seats.insert(insert_pos, insert_pos)
        return insert_pos

    def leave(self, p: int) -> None:
        self.seats.remove(p)