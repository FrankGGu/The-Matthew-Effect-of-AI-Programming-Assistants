class Solution:
    def findMinStep(self, board: str, hand: str) -> int:
        from collections import deque
        import heapq

        def remove(board):
            n = len(board)
            i = 0
            while i < n:
                j = i
                while j < n and board[j] == board[i]:
                    j += 1
                if j - i >= 3:
                    return remove(board[:i] + board[j:])
                i = j
            return board

        def get_next_states(board, hand):
            next_states = []
            for i in range(len(hand)):
                new_hand = hand[:i] + hand[i+1:]
                for j in range(len(board)+1):
                    new_board = board[:j] + hand[i] + board[j:]
                    cleaned = remove(new_board)
                    next_states.append((cleaned, new_hand))
            return next_states

        hand = ''.join(sorted(hand))
        queue = deque([(board, hand)])
        visited = set()
        visited.add((board, hand))

        while queue:
            current_board, current_hand = queue.popleft()
            if not current_board:
                return len(hand) - len(current_hand)
            for next_board, next_hand in get_next_states(current_board, current_hand):
                if (next_board, next_hand) not in visited:
                    visited.add((next_board, next_hand))
                    queue.append((next_board, next_hand))
        return -1