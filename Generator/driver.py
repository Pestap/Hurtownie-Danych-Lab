class Driver:
    def __init__(self, id, name, surname, dateOfBirth, sex):
        self.id = id
        self.name = name
        self.surname = surname
        self.dateOfBirth = dateOfBirth
        self.sex = sex
        
    def toBulk(self):
        return str(self.id) + "," + str(self.name) + "," + str(self.surname) + "," + str(self.dateOfBirth) + "," + str(self.sex)