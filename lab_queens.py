from docplex.cp.model import CpoModel
from sys import stdout

n = 8
R = range(n)

mdl = CpoModel(name='queens')
q = mdl.integer_var_list(n, 1, n, "queens")

# write a function that states the queens constraints and returns all the solutions
# as an array of solutions (i.e., an assignment to the q variables

def find_all_solutions(q):
    # queen constraints
    for i in R:
        for j in R:
            if i < j:
                mdl.add(q[i] != q[j])
                mdl.add(q[i] + i != q[j] + j)
                mdl.add(q[i] - i != q[j] - j)



    # inputs the answer into queens array
    queens = []
    solutions = mdl.start_search()
    for sol in solutions:
        answer = []
        for i in q:
            answer.append(sol[i])
        queens.append(answer)
    return queens

print(find_all_solutions(q))
