#-*- coding: utf-8 -*-

class CourseCarriage:
    def __init__(self, carriage_id, course_id):
        self.carriage_id = carriage_id
        self.course_id = course_id

    def toBulk(self):
        return str(self.carriage_id) + "," + str(self.course_id)
