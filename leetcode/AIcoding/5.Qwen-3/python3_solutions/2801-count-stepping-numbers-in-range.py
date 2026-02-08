class Solution:
    def countSteppingNumbers(self, low: str, high: str) -> int:
        from collections import deque

        def is_stepping(num):
            prev = -1
            for ch in num:
                curr = int(ch)
                if prev != -1 and abs(curr - prev) != 1:
                    return False
                prev = curr
            return True

        def generate_stepping_numbers():
            queue = deque()
            for i in range(1, 10):
                queue.append(str(i))
            result = set()
            while queue:
                num = queue.popleft()
                if is_stepping(num):
                    result.add(num)
                if len(num) < 10:
                    last = int(num[-1])
                    if last > 0:
                        queue.append(num + str(last - 1))
                    if last < 9:
                        queue.append(num + str(last + 1))
            return result

        stepping_numbers = generate_stepping_numbers()

        low_int = int(low)
        high_int = int(high)

        count = 0
        for num_str in stepping_numbers:
            num = int(num_str)
            if low_int <= num <= high_int:
                count += 1
        return count