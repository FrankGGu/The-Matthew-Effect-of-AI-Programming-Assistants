class Solution:
    def displayTable(self, orders: List[List[str]]) -> List[List[str]]:
        from collections import defaultdict

        tables = set()
        foods = set()
        table_food = defaultdict(lambda: defaultdict(int))

        for order in orders:
            table_num = order[1]
            food = order[2]
            tables.add(table_num)
            foods.add(food)
            table_food[table_num][food] += 1

        tables = sorted(tables)
        foods = sorted(foods)

        result = []
        header = ["Table"] + foods
        result.append(header)

        for table in tables:
            row = [table]
            for food in foods:
                row.append(str(table_food[table][food]))
            result.append(row)

        return result