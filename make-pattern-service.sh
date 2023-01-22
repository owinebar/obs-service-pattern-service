#!/bin/bash

sh_quote_tmpl="$(< sh-quote.sed.in)"

ssed() {
    sed --sandbox -En "$@"
}
ssed_str() {
    local text="$1"
    shift
    ( set -o pipefail;
      # ensure we do not add an extra newline at the end
      printf "%s\n" "$text" |
	  ssed "$@" |
	  head -c -1
      )
}
ssed_file() {
    local fn="$1"
    shift
    ssed_str "$(< "$fn")" "$@"
}

sh_quote_sed() {
    local var="$1"
    local prog="$(ssed -e "s/@SHELL_VARIABLE@/${var}/g" <sh-quote.sed.in)"
    ssed_str "$2" -e "$prog"
}
copy_upto_line() {
    ssed_file "${2}" -e "0,/^${1}\$/ { p; b }; d" 
}
copy_after_line() {
    ssed_file "${2}" -e "0,/^${1}\$/! { p; b }; d" >>${2}
}
: >pattern-service
copy_upto_line "####SED_PROGRAMS" pattern-service.in >>pattern-service
sh_quote_sed re_quote_prog "$(< regexpquote.sed)" >>pattern-service
pt1="$(copy_upto_line "####SUBSTITUTIONS" process-template.sed.in)"
sh_quote_sed tmpl_prog1 "${pt1}" >>pattern-service
pt2="$(copy_after_line "####SUBSTITUTIONS" process-template.sed.in)"
sh_quote_sed tmpl_prog2 "${pt2}" >>pattern-service
copy_after_line "####SED_PROGRAMS" pattern-service.in >>pattern-service
chmod 0755 pattern-service

