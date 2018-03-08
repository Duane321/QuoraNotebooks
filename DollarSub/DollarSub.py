"""

"""

import sys

file_name = sys.argv[1]

with open(file_name,'r') as file:
    text = file.read()

first = True
while '$$' in text:
    idx = text.index('$$')
    sub = '[math]\\begin{align}' if first else '\\end{align}[/math]'
    first = not first
    text = text[:idx] + sub + text[idx+2:]

first = True
while '$' in text:
    idx = text.index('$')
    sub = '[math]' if first else '[/math]'
    first = not first
    text = text[:idx] + sub + text[idx+1:]

with open(file_name[:-4] + '_subbed.txt','w') as file:
    file.write(text)