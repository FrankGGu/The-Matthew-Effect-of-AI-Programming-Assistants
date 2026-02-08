class Solution:
    def maxMaximize(self, customers: List[int], grumpy: List[int], minutes: int) -> int:
        n = len(customers)
        left = 0
        max_gain = 0
        current_gain = 0

        for right in range(n):
            if grumpy[right] == 1:
                current_gain += customers[right]

            if right - left + 1 > minutes:
                if grumpy[left] == 1:
                    current_gain -= customers[left]
                left += 1

            max_gain = max(max_gain, current_gain)

        total_customers = sum(customers)
        return total_customers - max_gain