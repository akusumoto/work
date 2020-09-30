#!/usr/bin/python3
# -*- coding: utf-8 -*-

import openpyxl
import sys
import os
import copy

sheet_names = ['A室(AM)', 'A室(PM)', 'B室(AM)', 'B室(PM)', 'C室(AM)', 'C室(PM)', 'D室(AM)', 'D室(PM)']

class NotMemberException(Exception):
    pass

class Hyoka:
    def __init__(self, room, name, laboratory, category, number, shidou, present_cat, present_num, 
                 student, title, tech_point, qa_point, comment):
        self.room = room
        self.name = name
        self.laboratory = laboratory
        self.category = category
        self.number = number
        self.shidou = shidou
        self.present_cat = present_cat
        self.present_num = present_num
        self.student = student
        self.title = title
        self.tech_point = tech_point
        self.qa_point = qa_point
        self.comment = comment

        self.is_student = self._is_student()

    def __str__(self):
        return ("(%s) %s %s %s %s%d - %s %s%d %s %s %s %s %s" % 
                (('学生' if self.is_student else '教員'), 
                 self.room, self.name, self.laboratory, self.category, self.number,
                 self.shidou, self.present_cat, self.present_num, self.student, self.title, 
                 (self.tech_point if self.tech_point else ''),
                 (self.qa_point if self.qa_point else ''),
                 self.comment))

    def _is_student(self):
        lab = copy.copy(self.laboratory)
        lab.replace('研究室','')
        lab.replace(' ', '')
        lab.replace('　','')
        return (len(lab) > 0)

def find_owner_number(sheet, owner):
    owner = owner.replace(' ', '').replace('　','')
    for row in sheet.iter_rows(min_row=5):        
        try:
            cat = row[1].value
            num = int(row[2].value)
            name = row[3].value.replace(' ', '').replace('　', '')
        except:
            pass
        
        if name == owner:
            return (cat, num)
    else:
        raise NotMemberException("%s is not member of %s" % (owner, sheet.title))

def get_room(category, number):
    return "%s室(%s)" % (category, ("AM" if number < 200 else "PM"))

def get_hyokas(category, number, book):
    hyokas = []

    room = get_room(category, number)
    sheet = book[room]
    
    name = sheet['H1'].value.replace(' ','').replace('　','')
    laboratory = sheet['H2'].value.replace(' ','').replace('　','')

    shidou = None
    for row in sheet.iter_rows(min_row=5):        
        if row[0].value:
            shidou = row[0].value
        present_cat = row[1].value
        present_num = row[2].value

        if not present_cat:
            break

        student = row[3].value
        title = row[4].value
        tech_point = row[5].value
        qa_point = row[6].value
        comment = row[7].value if row[7].value else ""

        hyoka = Hyoka(room=room, name=name, laboratory=laboratory,
                        category=category, number=number,
                        shidou=shidou, present_cat=present_cat, present_num=int(present_num),
                        student=student, title=title, 
                        tech_point=tech_point,
                        qa_point=qa_point, 
                        comment=comment)
        print(hyoka)
        hyokas.append(hyoka)
        
    return hyokas

def find_sheet(book, present_cat, present_num):
    present_cat.replace('-','')
    room = '%s室(%s)' % (present_cat, 'AM' if present_num.startwith('1') else 'PM')
    return book[room]

def find_hyoka_column_num(shukei_book, hyoka, is_student):
    if is_student:
        pass
    else:
        pass

def update_shukei(shukei_book, category, number, hyoka_book):
    hyokas = get_hyokas(category, number, hyoka_book)

    for hyoka in hyokas:
        try:
            sheet = shukei_book[hyoka.room]
        except KeyError:
            print("sheet not found '%s' in shukei book - %s" % (hyoka.room, hyoka))
            continue

        # AN = 39
        # 102 -> (hyoka.number % 100 - 1) * 2 = 2 -> 39 + 2 = 41 -> AP
        column_num = 39 + (hyoka.number % 100 - 1) * 2
        if sheet.cell(row=3, column=column_num).value != hyoka.number:
            print("student number is wrong - %d vs %d" % (hyoka.number, sheet.cell(row=3, column=column_num).value))
        #sheet = find_sheet(shukei_book, hyoka.present_cat, hyoka.present_num)

        hyoka_column_num = find_hyoka_column_num(shukei_book, hyoka, False)
        #hyoka_column_num = find_hyoka_column_num(shukei_book, hyoka, hyoka.is_student)


if __name__ == '__main__':
    shukei_xls = sys.argv[1]
    basedir = os.path.dirname(shukei_xls)
    shukei_book = openpyxl.load_workbook(shukei_xls)
    for c in ['A', 'B', 'C', 'D']:
        for n in [i for i in range(101, 121)] + [i for i in range(201, 221)]:
            try:
                xls_name = "%s-%d.xlsx" % (c, n)
                xls_path = os.path.join(basedir, xls_name)
                if not os.path.exists(xls_path):
                    continue

                print("loading %s ... " % xls_path)
                update_shukei(shukei_book, c, n, openpyxl.load_workbook(xls_path, read_only=True, data_only=True))
            except:
                print("NG - %s\n%s" % (sys.exc_info()[0], sys.exc_info[2]))
