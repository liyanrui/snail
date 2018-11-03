# snail

foo.tex:

```MetaPost
\startMPpage
input snail;
Node a, b, c, d, e, f;
a := proc("context", fullsquare xysized (2.5cm, 1cm));
b := as_star(proc("mpost", like(a)), a, "right");
c := as_star(a, b, "right");
d := as_planet(io("foo.tex"), a, "left");
e := as_planet(io("snail.mp"), b, "top");
f := as_planet(io("foo.pdf"), c, "right");
forsuffixes i = d, e, f: Frame i.frm; i.frm := io_frame(i); endfor;

for i = a, b, c, d, e, f: draw i; endfor;
d.frm => a; a => b; e.frm => b; b => c; c => f.frm;
\stopMPpage
```

Compile foo.tex into foo.pdf which has only a single page:

```console
$ context foo
```

The result is

![](foo.svg)
