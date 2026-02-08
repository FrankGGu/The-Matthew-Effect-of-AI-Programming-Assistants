class Solution:
    def asteroidsDestroyed(self, asteroids: List[int]) -> int:
        asteroids.sort()
        mass = 1
        for a in asteroids:
            if a > mass:
                return 0
            mass += a
        return 1