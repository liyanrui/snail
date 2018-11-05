# Snail 模块

foo.tex:

```
\usemodule[zhfonts]
\defineframed
  [SnailBox]
  [frame=off, width=6cm, autowidth=force,
    align={middle, lohi, broad}, offset=overlay]

\startMPpage
input snail;
Node a, b, c, d, e;
a := io("\SnailBox{$i\leftarrow 1$\\$s\leftarrow 0$}");
b := proc("$s\leftarrow s + i$");
c := other("$i > 100$", diamond(b));
d := proc("$i\leftarrow i + 1$");
e := io("\SnailBox{$s$}");
as_planet(b, a, "bottom"); as_planet(c, b, "bottom");
as_planet(d, c, "right"); as_star(e, c, "bottom");
draw_each a, b, c, d, e;

enrich_each a, b, d, e;
flow_each a => b, b => c, walk(d.N, (_n_ _v_(d.N, b.E)), b.E);
tagged_flow("是", "right", .4) c => e;
tagged_flow("否", "top", .4) c => d;
\stopMPpage
```

Compile foo.tex into foo.pdf which has only a single page with `context` command:

```console
$ context foo
```

The result is

![](foo.svg)

If you know Chinese and want to get more details, please see https://liyanrui.github.io/posts/snail.html
