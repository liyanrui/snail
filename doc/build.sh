#!/bin/bash
xi -c ctx.conf -w -o snail.tex ../snail.xi \
   && sed -i "s/ESC_AT/@/g; s/ESC_HASH/#/g" snail.tex \
   && context snail
