import os
import commands
import time

l = 0
first = (0.01, 0.01, 0.01, 0.01, 0.01, 0.21, 0.01, 0.01, 0.01, 0.01)
result1 = ("SATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "SATISFIABLE", "SATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE")


x = 1
b = 10
while (x<=b):
    mmm = "./a.out < random3SAT/vars-100-" + str(x) + ".cnf"
    ini = time.time()
    a = commands.getstatusoutput(mmm)
    fin = time.time()
    tiempo_total = fin - ini
    tiempo_total = tiempo_total*1.2
    if(a[1] == result1[l]):
        res = 'correcto'
        esp3 = '      '
    else:
        res = 'incorrecto'
        esp3 = '    '

    if(a[1] == "SATISFIABLE"):
        esp = '     '
    else:
        esp = '   '

    if(tiempo_total > first[l]):
        velocidad = 'Lento'
    else:
        velocidad = 'Rapid'

    if (x == 10):
        esp2 = '  '
    else:
        esp2 = '   '

    print "   100-", x, esp2, a[1], esp, res, "    ", velocidad, "   ",  first[l], "   ", tiempo_total
    x = x+1
    l = l+1

print " "


second = (0.05, 0.06, 0.04, 0.16, 0.17, 0.03, 0.11, 0.01, 0.16, 0.08)
result2 = ("SATISFIABLE", "SATISFIABLE", "SATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "SATISFIABLE", "UNSATISFIABLE")
l = 0
x = 1
b = 10
while (x<=b):
    mmm = "./a.out < random3SAT/vars-150-" + str(x) + ".cnf"
    ini = time.time()
    a = commands.getstatusoutput(mmm)
    fin = time.time()
    tiempo_total = fin - ini
    tiempo_total = tiempo_total*1.2
    if(a[1] == result2[l]):
        res = 'correcto'
        esp3 = '      '
    else:
        res = 'incorrecto'
        esp3 = '    '

    if(a[1] == "SATISFIABLE"):
        esp = '     '
    else:
        esp = '   '

    if(tiempo_total > second[l]):
        velocidad = 'Lento'
    else:
        velocidad = 'Rapid'

    if (x == 10):
        esp2 = '  '
    else:
        esp2 = '   '

    print "   150-", x, esp2, a[1], esp, res, "    ", velocidad, "   ",  second[l], "   ", tiempo_total
    x = x+1
    l = l+1

print " "




third = (1.47, 0.03, 2.21, 0.62, 2.72, 5.45, 5.94, 0.45, 0.63, 2.53)
result3 = ("UNSATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "SATISFIABLE", "UNSATISFIABLE")
l = 0
x = 1
b = 10
while (x<=b):
    mmm = "./a.out < random3SAT/vars-200-" + str(x) + ".cnf"
    ini = time.time()
    a = commands.getstatusoutput(mmm)
    fin = time.time()
    tiempo_total = fin - ini
    tiempo_total = tiempo_total*1.2
    if(a[1] == result3[l]):
        res = 'correcto'
        esp3 = '      '
    else:
        res = 'incorrecto'
        esp3 = '    '

    if(a[1] == "SATISFIABLE"):
        esp = '     '
    else:
        esp = '   '

    if(tiempo_total > third[l]):
        velocidad = 'Lento'
    else:
        velocidad = 'Rapid'

    if (x == 10):
        esp2 = '  '
    else:
        esp2 = '   '

    print "   200-", x, esp2, a[1], esp, res, "    ", velocidad, "   ",  third[l], "   ", tiempo_total
    x = x+1
    l = l+1

print " "

fourth = (23.91, 70.31, 21.41, 2.781, 25.41, 118.1, 2.181, 28.51, 14.91, 5.011)
result4 = ("UNSATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "SATISFIABLE")
l = 0
x = 1
b = 10
while (x<=b):
    mmm = "./a.out < random3SAT/vars-250-" + str(x) + ".cnf"
    ini = time.time()
    a = commands.getstatusoutput(mmm)
    fin = time.time()
    tiempo_total = fin - ini
    tiempo_total = tiempo_total*1.2
    if(a[1] == result4[l]):
        res = 'correcto'
        esp3 = '      '
    else:
        res = 'incorrecto'
        esp3 = '    '

    if(a[1] == "SATISFIABLE"):
        esp = '     '
    else:
        esp = '   '

    if(tiempo_total > fourth[l]):
        velocidad = 'lento'
    else:
        velocidad = 'rapid'

    if (x == 10):
        esp2 = '  '
    else:
        esp2 = '   '

    print "   250-", x, esp2, a[1], esp, res, "    ", velocidad, "   ",  fourth[l], "  ", tiempo_total
    x = x+1
    l = l+1

print " "




fiveth = (63.541, 1445.1, 284.11, 301.31, 789.81, 443.41, 7.5211, 920.41, 295.41, 201.81)
result5= ("SATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "UNSATISFIABLE", "SATISFIABLE", "SATISFIABLE")
l = 0
x = 1
b = 10
while (x<=b):
    mmm = "./a.out < random3SAT/vars-300-" + str(x) + ".cnf"
    ini = time.time()
    a = commands.getstatusoutput(mmm)
    fin = time.time()
    tiempo_total = fin - ini
    tiempo_total = tiempo_total*1.2
    if(a[1] == result5[l]):
        res = 'correcto'
        esp3 = '      '
    else:
        res = 'incorrecto'
        esp3 = '    '

    if(a[1] == "SATISFIABLE"):
        esp = '     '
    else:
        esp = '   '

    if(tiempo_total > fiveth[l]):
        velocidad = 'lento'
    else:
        velocidad = 'rapid'

    if (x == 10):
        esp2 = '  '
    else:
        esp2 = '   '

    print "   300-", x, esp2, a[1], esp, res, "    ", velocidad, "   ",  fiveth[l], " ", tiempo_total
    x = x+1
    l = l+1











