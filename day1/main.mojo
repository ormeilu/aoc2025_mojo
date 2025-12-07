

struct Dial(Writable, Movable, ImplicitlyCopyable):
    var position: Int
    var clicks: Int

    fn write_to(self, mut writer: Some[Writer]):
        writer.write('Dial(position=' + String(self.position) + ', clicks=' + String(self.clicks) + ')')

    fn __init__(out self, position: Int = 50, clicks: Int = 0):
        self.position = position
        self.clicks = clicks

    fn __add__(mut self, value: Int) -> Self:
        self.position = self.position + (value % 100)
        if self.position >= 100:
            self.position -= 100
        return self

    fn __sub__(mut self, value: Int) -> Self:
        self.position = self.position - (value % 100)
        if self.position < 0:
            self.position += 100
        return self
        

    fn move_dial(mut self, direction: String, amount: Int):
        """Accepts direction and amount in LXX..X or RXX.X,
        move dial and return number of clicks within this move.
        """
        if direction == "L":
            self = self - amount
        elif direction == "R":
            self = self + amount
        
        if self.position == 0:
            self.clicks += 1


fn _test_dial():
    var dial = Dial(position=98)

    print(dial)
    print()

    dial = dial + 103
    print(dial)
    print()

    dial = dial - 3
    print(dial)

    _ = dial.move_dial('R', 3)
    print(dial)

def main():

    #_test_dial()

    with open("day_1.txt", 'r') as file:
        content = file.read()

    var dial = Dial()

    for line in content.split('\n'):
        dial.move_dial(line[0], Int(line[1:]))
    
    print()
    print(dial)
    print('Password:', dial.clicks)
    print()
