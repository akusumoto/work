#!/usr/bin/python3
# -*- coding: utf-8 -*-

import openpyxl
import sys
import copy

sheet_names = ['A室(AM)', 'A室(PM)', 'B室(AM)', 'B室(PM)', 'C室(AM)', 'C室(PM)', 'D室(AM)', 'D室(PM)']

class Hyoka:
    def __init__(self, room, hyokasha, laboratory, shidou, present_cat, present_num, 
                 student, title, tech_point, qa_point, comment):
        self.room = room
        self.hyokasha = hyokasha
        self.laboratory = laboratory
        self.shidou = shidou
        self.present_cat = present_cat
        self.present_num = present_num
        self.student = student
        self.title = title
        self.tech_point = tech_point
        self.qa_point = qa_point
        self.comment = comment

    def __str__(self):
        return ("(%s) %s %s %s %s %s%d %s %s %d %d %s" % 
                (('学生' if self.is_student() else '教員'), 
                 self.room, self.hyokasha, self.laboratory, self.shidou, 
                 self.present_cat, self.present_num, self.student, self.title, 
                 self.tech_point, self.qa_point, self.comment))

    def is_student(self):
        lab = copy.copy(self.laboratory)
        lab.replace('研究室','')
        lab.replace(' ', '')
        lab.replace('　','')
        return (len(lab) > 0)

def get_hyokas(book):
    hyokas = []

    for sheet_name in sheet_names:
        try:
            sheet = book[sheet_name]
        except KeyError as e:
            print("sheet not found - %s (%s)" % (sheet_name, e))
            continue
        except IndexError as e:
            print("sheet not found - %s (%s)" % (sheet_name, e))
            continue
    
        hyokasha = sheet['H1'].value.replace(' ','').replace('　','')
        laboratory = sheet['H2'].value.replace(' ','').replace('　','')

        #print("%s %s %s" % (sheet_name, hyokasha, laboratory))
        print("DEBUG %s" % sheet_name)
        shidou = None
        for row in sheet.iter_rows(min_row=5):        
            if row[0].value:
                shidou = row[0].value
            present_cat = row[1].value
            present_num = row[2].value
            student = row[3].value
            title = row[4].value
            tech_point = row[5].value
            qa_point = row[6].value
            comment = row[7].value if row[7].value else ""

            if not tech_point and not qa_point:
                #print("no hyoka - %s %s %s%s %s" % (sheet_name, shidou, present_cat, present_num, student))
                continue
            print("%s" % present_num)
            hyoka = Hyoka(room=sheet_name, hyokasha=hyokasha, laboratory=laboratory,
                          shidou=shidou, present_cat=present_cat, present_num=int(present_num),
                          student=student, title=title, 
                          tech_point=(int(tech_point) if tech_point else 0),
                          qa_point=(int(qa_point) if qa_point else 0), 
                          comment=comment)
            print(hyoka)
            hyokas.append(hyoka)
        
    return hyokas

def find_sheet(book, present_cat, present_num):
    present_cat.replace('-','')
    room = '%s室(%s)' % (present_cat, 'AM' if present_num.startwith('1') else 'PM')
    return book[room]


def update_shukei(shukei_book, hyoka_book):
    hyokas = get_hyokas(hyoka_book)

    for hyoka in hyokas:
        try:
            #hyoka.is_student
            sheet = shukei_book[hyoka.room]
        except KeyError:
            print("sheet not found '%s' in shukei book - %s" % (hyoka.room, hyoka))
            continue

        #sheet = find_sheet(shukei_book, hyoka.present_cat, hyoka.present_num)

shukei_xls = sys.argv[1]
hyoka_xlss = sys.argv[2:]

shukei_book = openpyxl.load_workbook(shukei_xls)
for hyoka_xls in hyoka_xlss:
    try:
        print("%s" % hyoka_xls)
        update_shukei(shukei_book, openpyxl.load_workbook(hyoka_xls, read_only=True, data_only=True))
    except:
        print("failed to process shukei '%s' - %s" % (hyoka_xls, sys.exc_info()[0]))
