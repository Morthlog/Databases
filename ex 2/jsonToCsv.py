import csv
import ast

hasKeyword = [["movie_id", "key_id"]]  # initialize with proper headers
keyword = [["id", "name"]]


def read_csv(filename):
    file = open(filename, encoding="utf-8")
    csvreader = csv.reader(file)
    next(csvreader)  # skip the header row
    tempkeyword = []
    for row in csvreader:
        json_string = row[1]  # read json
        elements = ast.literal_eval(json_string)
        for data in elements:  # reads only elements where json in not empty
            hasKeyword.append((row[0], data['id']))
            tempkeyword.append((data['id'], data['name']))
    keyword.extend(set(tempkeyword))
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
