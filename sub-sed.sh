sub_prog=""
sub_prog+=$'\n'
sub_prog+=$'# only care about lines with a possible substitution\n'
sub_prog+=$'/\\$|\\\\/ {\n'
sub_prog+=$'    # Initialize hold space\n'
sub_prog+=$'    x;z;x\n'
sub_prog+=$'    : findnextsub\n'
sub_prog+=$'    t clear1\n'
sub_prog+=$'    : clear1\n'
sub_prog+=$'    # if we are at the end of the line\n'
sub_prog+=$'    # clean up and restart cycle\n'
sub_prog+=$'    s/^([^\\$]*)$/\\1/ ; t returnEOL\n'
sub_prog+=$'    # Otherwise if there are non-control chars, accumulate \n'
sub_prog+=$'    s/^([^\\$]+)/\\1\\n/; t accumulate\n'
sub_prog+=$'    # Must have a control sequence at the head\n'
sub_prog+=$'    s/^\\\\\\\\/\\\\\\n/ ; t accumulate\n'
sub_prog+=$'    s/^\\\\\\$/\\$\\n/ ; t accumulate\n'
sub_prog+=$'    s/^\\\\/\\\\\\n/ ; t accumulate\n'
sub_prog+=$'    s/^\\$\\{([1-9][0-9]*)\\}/\\1\\n/ ; t substitute\n'
sub_prog+=$'    s/^\\$/\\$\\n/ ; t accumulate\n'
sub_prog+=$'    # should be impossible\n'
sub_prog+=$'    b nomatcherr\n'
sub_prog+=$'    :substitute\n'
sub_prog+=$'    # commands of the form\n'
sub_prog+=$'    # s#<parameter number>\\n#<replacement text>\\n#\n'
sub_prog+=$'    \n'
sub_prog+=$'    # if not matched, provide empty value\n'
sub_prog+=$'    s/^[^\\n]+\\n//\n'
sub_prog+=$'    b findnextsub\n'
sub_prog+=$'    s@(.)@\\1\\n@\n'
sub_prog+=$'    s~^(\\[|[@.?*()|+{}/\\$\\\\])~\\\\\\1~\n'
sub_prog+=$'    x\n'
sub_prog+=$'    G\n'
sub_prog+=$'    s/^([^\\n]*)\\n([^\\n]*)\\n/\\1\\2\\n/\n'
sub_prog+=$'    h\n'
sub_prog+=$'    s/^([^\\n]+)\\n.*/\\1/\n'
sub_prog+=$'    x\n'
sub_prog+=$'    s/^[^\\n]+\\n(.*)/\\1/\n'
sub_prog+=$'    b findnextsub\n'
sub_prog+=$'\n'
sub_prog+=$'    : accumulate\n'
sub_prog+=$'    # First line of pattern space contains text to accumulate\n'
sub_prog+=$'    # second line contains unprocessed text\n'
sub_prog+=$'    # hold space contains processed text\n'
sub_prog+=$'    x\n'
sub_prog+=$'    G\n'
sub_prog+=$'    s/^([^\\n]*)\\n([^\\n]+)\\n/\\1\\2\\n/\n'
sub_prog+=$'    h\n'
sub_prog+=$'    s/^([^\\n]+)\\n(.*)/\\1/\n'
sub_prog+=$'    x\n'
sub_prog+=$'    s/^([^\\n]+)\\n(.*)/\\2/\n'
sub_prog+=$'    b findnextsub\n'
sub_prog+=$'    \n'
sub_prog+=$'    : returnEOL\n'
sub_prog+=$'    H\n'
sub_prog+=$'    x\n'
sub_prog+=$'    s/^([^\\n]+)\\n/\\1/\n'
sub_prog+=$'    p\n'
sub_prog+=$'    d\n'
sub_prog+=$'    : nomatcherr\n'
sub_prog+=$'    = ; a Impossible non-match\n'
sub_prog+=$'    q\n'
sub_prog+=$'}\n'
