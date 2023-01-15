
# only care about lines with a possible substitution
/\$|\\/ {
    # Initialize hold space
    x;z;x
    : findnextsub
    t clear1
    : clear1
    # if we are at the end of the line
    # clean up and restart cycle
    s/^([^\$]*)$/\1/ ; t returnEOL
    # Otherwise if there are non-control chars, accumulate 
    s/^([^\$]+)/\1\n/; t accumulate
    # Must have a control sequence at the head
    s/^\\\\/\\\n/ ; t accumulate
    s/^\\\$/\$\n/ ; t accumulate
    s/^\\/\\\n/ ; t accumulate
    s/^\$\{([1-9][0-9]*)\}/\1\n/ ; t substitute
    s/^\$/\$\n/ ; t accumulate
    # should be impossible
    b nomatcherr
    :substitute
    # commands of the form
    # s#<parameter number>\n#<replacement text>\n#
    
    # if not matched, provide empty value
    s/^[^\n]+\n//
    b findnextsub
    s@(.)@\1\n@
    s~^(\[|[@.?*()|+{}/\$\\])~\\\1~
    x
    G
    s/^([^\n]*)\n([^\n]*)\n/\1\2\n/
    h
    s/^([^\n]+)\n.*/\1/
    x
    s/^[^\n]+\n(.*)/\1/
    b findnextsub

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
    b findnextsub
    
    : returnEOL
    H
    x
    s/^([^\n]+)\n/\1/
    p
    d
    : nomatcherr
    = ; a Impossible non-match
    q
}
