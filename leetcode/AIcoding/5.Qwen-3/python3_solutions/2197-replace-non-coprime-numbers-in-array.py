from typing import List
from math import gcd

class Solution:
    def replaceNonCoprimeNumbersInArray(self, nums: List[int]) -> List[int]:
        stack = []
        for num in nums:
            while stack:
                g = gcd(stack[-1], num)
                if g == 1:
                    break
                num = stack.pop() * num // g
            stack.append(num)
        return stack