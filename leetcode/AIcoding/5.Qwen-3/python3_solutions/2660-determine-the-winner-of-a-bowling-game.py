class Solution:
    def isWinner(self, player1: int, player2: int) -> str:
        def calculate_score(rolls):
            score = 0
            for i in range(len(rolls)):
                if i < 10:
                    if rolls[i] == 10:
                        score += 10
                        if i + 1 < len(rolls):
                            score += rolls[i + 1]
                            if i + 2 < len(rolls):
                                score += rolls[i + 2]
                    else:
                        score += rolls[i]
                        if i + 1 < len(rolls):
                            score += rolls[i + 1]
            return score

        score1 = calculate_score([int(d) for d in str(player1)])
        score2 = calculate_score([int(d) for d in str(player2)])
        if score1 > score2:
            return "Player 1"
        elif score2 > score1:
            return "Player 2"
        else:
            return "Draw"