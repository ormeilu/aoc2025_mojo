from pathlib import Path

struct IDRange(Writable):
    var start: Int
    var end: Int

    fn __init__(out self, start: Int, end: Int): # TODO: constructor from_str??
        self.start = start
        self.end = end

    fn write_to(self, mut writer: Some[Writer]):
        writer.write('IDRange(start=' + String(self.start) + ', end=' + String(self.end) + ')')
    
    @staticmethod
    fn from_string(region: String) raises -> Self:
        start, end = Self.parse_region(region)
        return Self(start, end)

    @staticmethod
    fn parse_region(region: String) raises -> Tuple[Int, Int]:
        range_splitted = region.split('-')
        start: Int = Int(range_splitted[0])
        end: Int = Int(range_splitted[1])
        return start, end

    fn list_simple_ids(self) -> List[Int]:
        ids = range(self.start, self.end + 1)
        var simple_ids: List[Int] = []
        for _id in ids:
            id_str = String(_id)
            if len(id_str) % 2 != 0:
                continue  # because there no simple ids in X, XXX, XXXXX, etc.
            else:
                first_part, second_part = id_str[:len(id_str) // 2], id_str[len(id_str) // 2:]
                if first_part == second_part:
                    simple_ids.append(_id)
        return simple_ids^
            

fn _run_file(file_path: Path) escaping -> Int:
    total_sum = 0
    try:
        with open('day_2.txt', 'r') as file:
            var _ranges = file.read().split(',')
            for _range in _ranges:
                id_range = IDRange.from_string(String(_range))
                simple_ids = id_range.list_simple_ids()
                for simple_id in simple_ids:
                    total_sum += simple_id
    except:
        print('Error reading file')
    return total_sum


fn main():
    example = 'day_2_example.txt'
    real = 'day_2.txt' 

    output = _run_file(example)
    # output = _run_file(real)

    print(output)
