import csv
import ast

hasKeyword = [["movie_id", "key_id"]]  # initialize with proper headers
keyword = [["id", "name"]]


def read_csv(filename):
    file = open(filename, encoding="utf-8")
    csvreader = csv.reader(file)
    next(csvreader)  # skip the header row
    for row in csvreader:
        json_string = row[1]  # read json
        element = ast.literal_eval(json_string)
        for data in element:  # reads only elements where json in not empty
            has_keyword_entry = [row[0], data['id']]
            if has_keyword_entry not in hasKeyword:  # dont include duplicates
                hasKeyword.append(has_keyword_entry)
            keyword_entry = [data['id'], data['name']]
            if keyword_entry not in keyword:  # dont include duplicates
                keyword.append(keyword_entry)
    file.close()


def write_csv(filename, array):
    f = open(filename, 'w', newline='', encoding="utf-8")
    writer = csv.writer(f)
    for row in array:
        writer.writerow(row)
    f.close()


read_csv("keywords.csv")
write_csv("keyword.csv", keyword)
write_csv("hasKeyword.csv", hasKeyword)
