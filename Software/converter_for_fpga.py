with open('codefpga.hex', 'w') as fpw:
    with open('code.hex', 'r') as f:
        fl = f.readline().strip()
        while fl:
            p1 = fl[0]+fl[1]+'\n'
            p2 = fl[2]+fl[3]+'\n'
            p3 = fl[4]+fl[5]+'\n'
            p4 = fl[6]+fl[7]+'\n'
            # print(fl)
            fpw.write(p4)
            fpw.write(p3)
            fpw.write(p2)
            fpw.write(p1)
            # print(p1,p2,p3,p4)
            fl = f.readline().strip()
