class Solution:
    def asteroidCollision(self, asteroids: List[int]) -> List[int]:
        stack = []
        for asteroid in asteroids:
            while stack and stack[-1] > 0 and asteroid < 0 and stack[-1] < -asteroid:
                stack.pop()
            if not stack or stack[-1] < 0 or asteroid > 0:
                stack.append(asteroid)
            elif stack[-1] == -asteroid:
                stack.pop()
        return stack