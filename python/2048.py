def init_field():
    field = [0]*16
    field = add_tile(field)
    field = add_tile(field)
    return field

def print_field(field):
    print
    for y in range(4):
        for x in range(4):
            i = y*4+x
            if field[i] > 0:
                print "%4d " % field[i],
            else:
                print ".... ",
        print
        print

def wait_input():
    c = ''
    while (c not in ['a', 'w', 's' ,'d', 'q']):
        c = raw_input('"a":left "w":up "s":down "d":right ("q":quit) -? ')
    return c

def add_tile(field):
    import random
    n_blank = len([i for i in field if i == 0])
    target = random.randint(0, n_blank-1)
    
    i = 0
    p = 0
    while i < len(field):
        if field[i] == 0:
            if p == target:
                v = 2 if random.random() < 0.9 else 4
                field[i] = v
                return field
            p += 1
        i += 1
    else:
        print "faield to add tile: n_blank=%s target=%s" % (n_blank, target)
        print field

    return field

def update_field2(field, calc_pos):
    for i in range(4):
        v = 0
        r = 0
        for j in range(4):
            p = calc_pos(i, j)
            rr = calc_pos(i, r)
            if field[p] > 0:
                if v == field[p]:
                    field[rr] = v + field[p]
                    v = 0
                    r += 1
                elif v > 0:
                    field[rr] = v
                    v = field[p]
                    r += 1
                else: # v == 0
                    v = field[p]
        for s in range(r, 4):
            ss = calc_pos(i, s)
            field[ss] = v
            v = 0

    return field

def update_field(field, direction):
    if   direction == 'a': field = update_field2(field, lambda i, j: i*4+j)
    elif direction == 'w': field = update_field2(field, lambda i, j: i+j*4)
    elif direction == 's': field = update_field2(field, lambda i, j: (4-(i+1))+(4-(j+1))*4)
    elif direction == 'd': field = update_field2(field, lambda i, j: i*4 + (4-(j+1)))
    else:
        print "invalid direction - " + dirction
        return field

    field = add_tile(field)

    return field
    

def is_clear(field):
    return (2048 in field)

def is_over(field):
    return (len([i for i in field if i == 0]) == 0)


field = init_field()

import sys
while True:
    # print field
    print_field(field)

    # input
    direction = wait_input()
    if direction == 'q':
        print "BYE!"
        sys.exit(0)

    # update field
    field = update_field(field, direction)

    # clear or not
    if is_clear(field):
        print_field(field)
        print "CLEAR!!"
        sys.exit(0)

    if is_over(field):
        print_field(field)
        print "GAME OVER..."
        sys.exit(0)

