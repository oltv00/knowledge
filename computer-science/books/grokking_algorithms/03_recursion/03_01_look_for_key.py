class Key:
    pass

# fix it
class Box:
    def __init__(self, boxes, key):
        self.boxes = boxes
        self.key = key

    def grab_a_box(self):
        if len(self.boxes) != 0:
            return self.boxes.pop()
        else:
            return None

    def is_a_box(self):
        if len(self.boxes) == 0:
            return False
        else:
            return True

    def is_a_key(self):
        if self.key is not None:
            return True
        else:
            return False

# fix it
def look_for_key(main_box):
    boxes = [main_box]
    while len(boxes) != 0:
        box = boxes.pop()
        for item in box.boxes:
            if item.is_a_box():
                boxes.append(item)
            elif item.is_a_key():
                print('Found the key!')
            else:
                print('Box is empty')

# fix it
def look_for_key_recursive(box):
    for item in box.boxes:
        if item.is_a_box():
            return look_for_key_recursive(item)
        elif item.is_a_key():
            print('Found the key!')

# fix it
boxes = [
    Box([
        Box([
            Box([], None)
        ], None),
        Box([
            Box([], Key())
        ], None),
    ], None),
    Box([
        Box([
            Box([], None)
        ], None),
        Box([
            Box([], None)
        ], None),
    ], None),
]

main_box = Box(boxes, None)

# look_for_key(main_box)
look_for_key_recursive(main_box)
