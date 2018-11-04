# snail

foo.tex:

```
\usemodule[zhfonts]
\startMPpage
input snail;

% 构造结点
Node a, b, c, d, e;
a := io("\cbox{\vbox{$i\leftarrow 1$}\vbox{$s\leftarrow 0$}}");
b := proc_fit("$s\leftarrow s + i$");
c := proc("$i > 100$", diamond(b));
d := proc_fit("$i\leftarrow i + 1$");
e := io("$s$");

% 结点定位
as_planet(b, a, "bottom");
as_planet(c, b, "bottom");
as_planet(d, c, "right");
as_planet(e, c, "bottom");

% 为 I/O 结点构造隐式的文本框
io_frame_for_each a, e;
% 结点上的锚点定位（a.F 和 e.F 分别为结点 a 和 e 的隐式文本框）
enrich_each a.F, b, c, d, e.F;

% 绘制结点
draw_each a, b, c, d, e;
% 绘制连接
flow_each a.F => b, b => c, walk(d.N, (_n_ _v_(d.N, b.E)), b.E);
tagged_flow("是", "right", .4) c => e.F;
tagged_flow("否", "top", .4) c => d;
\stopMPpage
```

Compile foo.tex into foo.pdf which has only a single page with `context` command:

```console
$ context foo
```

The result is

![](foo.svg)
