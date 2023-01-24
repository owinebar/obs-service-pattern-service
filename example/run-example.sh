#!/bin/bash

/usr/lib/obs/service/pattern-service \
    --table compilers.tbl \
    --service sed \
    --template-file spec-sed-in.srv.tmpl \
    --template-file spec-sed.srv.tmpl \
    --services-file spec-sed._services \
    --outdir tmp

mv tmp/spec-sed._services .

/usr/lib/obs/service/run-services \
    --services-file spec-sed._services \
    --outdir tmp

ls -A tmp | while read fn; do
    if [ \! -L tmp/$fn ]; then
	mv tmp/$fn .
    fi
done
rm tmp/*

/usr/lib/obs/service/sed \
    --script multibuild.sed \
    --file compilers.tbl \
    --out _multibuild \
    --mode script \
    --default-print off \
    --syntax extended \
    --missing-input fail \
    --outdir tmp

mv tmp/_multibuild .
rm tmp/*


