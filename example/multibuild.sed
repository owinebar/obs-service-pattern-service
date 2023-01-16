1 { i <multibuild>
  }
$ { a </multibuild>
  }
/\S+\.spec/! {
    d
}
:loop
/^\s*$/ {
    d
}
s/^\s+//
h
s/(\S+)(|\s.*)$/\2/
x
s/(\S+)(|\s.*)$/\1/
/^\S+\.spec$/ {
    s#^(\S+)\.spec$#<flavor>\1</flavor>#p
}
z; x
b loop

