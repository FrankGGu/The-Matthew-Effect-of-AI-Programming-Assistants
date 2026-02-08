import pandas as pd

def find_students(students: pd.DataFrame) -> pd.DataFrame:
    return students[(students['score_after'] > students['score_before'])][['student_id']]