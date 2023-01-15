# Initialize hold space
x;z;x
: loop
t clear1; : clear1
s~^([^[@.?*()|+{}#$\]*)$~\1~; t returnEOL
s~^([^[@.?*()|+{}#$\]+)~\1\n~; t accumulate
# First character must be special
s~^([[@.?*()|+{}#$\])~\\\1\n~; t accumulate
b nomatcherr
: accumulate
# First line of pattern space contains text to accumulate
# second line contains unprocessed text
# hold space contains processed text
x
G
s/^([^\n]*)\n([^\n]+)\n/\1\2\n/
h
s/^([^\n]+)\n(.*)/\1/
x
s/^([^\n]+)\n(.*)/\2/
b loop
: returnEOL
H
x
s/^([^\n]+)\n/\1/
p
d
: nomatcherr
= ; a Impossible non-match
q
