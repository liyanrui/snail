def Node = picture enddef;
def Frame = path enddef;

def _llc_ = llcorner enddef; def _ulc_ = ulcorner enddef;
def _urc_ = urcorner enddef; def _lrc_ = lrcorner enddef;

tertiarydef a +++ b = image(draw a; draw b;) enddef;

pair __site__; 
tertiarydef a >>> b =
  if pair a:
    hide(__site__ := b shifted a) a -- __site__
  elseif path a:
    hide(__site__ := b shifted __site__) a -- __site__
  fi
enddef;
vardef walk(expr start, p, stop) =
  if pair stop:
    start -- (p shifted start) -- stop
  else:
    start -- (p shifted start)
  fi
enddef;

def _h_(expr a, b) = abs(xpart a - xpart b) enddef;
def _v_(expr a, b) = abs(ypart a - ypart b) enddef;
def _H_ expr a = _h_(a, _site_) enddef;
def _V_ expr a = _v_(a, _site_) enddef;

def _w_ expr a = (left * (a)) enddef;
def _e_ expr a = (right * (a)) enddef;
def _n_ expr a = (up * (a)) enddef;
def _s_ expr a = (down * (a)) enddef;
def _W_ expr a = (left * (_margin_ + (a))) enddef;
def _E_ expr a = (right * (_margin_ + (a))) enddef;
def _N_ expr a = (up * (_margin_ + (a))) enddef;
def _S_ expr a = (down * (_margin_ + (a))) enddef;
def _WW_ expr a = (left * (2_margin_ + (a))) enddef;
def _EE_ expr a = (right * (2_margin_ + (a))) enddef;
def _NN_ expr a = (up * (2_margin_ + (a))) enddef;
def _SS_ expr a = (down * (2_margin_ + (a))) enddef;

def _bw_ expr a = (bbwidth a) enddef;
def _bh_ expr a = (bbheight a) enddef;

vardef diamond(expr frame) =
  save w, h; numeric w, h;
  w := _bw_ frame; h := _bh_ frame;
  fulldiamond xysized (_expansion_ * (w, h))
enddef;

vardef ellipse(expr frame) =
  save w, h; numeric w, h;
  w := _bw_ frame; h := _bh_ frame;
  fullcircle xysized (_expansion_ * (w, h))
enddef;

vardef like(expr p) =
  save q; path q;
  q := (_llc_ p) -- (_ulc_ p) -- (_urc_ p) -- (_lrc_ p) -- cycle;
  q := q shifted -(center p);
  q
enddef;

vardef frame(expr p, pad) =
  save w, h, q; numeric w, h; path q;
  w := _bw_ p; h := _bh_ p;
  q := like(p);
  q := q xscaled ((w + pad) / w);
  q := q yscaled ((h + pad) / h);
  q shifted (center p)
enddef;

vardef io(expr s) =
  image(draw textext(s) withcolor _io_color_;)
enddef;

vardef fancy_io(expr s, c) =
  image(draw textext(s) withcolor c; )
enddef;

vardef proc_fit(expr s) =
  save p; path p;
  p := frame(image(draw textext(s);), _proc_pad_);
  image(fill p withcolor _bg_color_;
        drawpath p withcolor _frame_color_;
        draw textext(s) withcolor _proc_color_;)
enddef;

vardef proc(expr s, frame) =
  image(fill frame withcolor _bg_color_;
        drawpath frame withcolor _frame_color_;
        draw textext(s) withcolor _proc_color_;)
enddef;

def halign(suffix p)(expr ref) =
  p := p shifted (0, ypart (center ref - center p));
enddef;
def valign(suffix p)(expr ref) =
  p := p shifted (xpart (center ref - center p), 0);
enddef;

% 含后缀参数的宏，后缀参数的实参容易与其他参数的名字以及宏内局部变量发生冲突，
% 所以只好将其他参数以及宏内变量予以丑化。
def as_star(suffix p)(expr __SNAIL_ref__, __SNAIL_location__) =
  begingroup
    save __SNAIL_s__;
    pair __SNAIL_s__;
    __SNAIL_s__ := center __SNAIL_ref__ - center p;
    if __SNAIL_location__ = "left":
      __SNAIL_s__ := __SNAIL_s__ - (_star.sx, 0);
    elseif __SNAIL_location__ = "right":
      __SNAIL_s__ := __SNAIL_s__ + (_star.sx, 0);
    elseif __SNAIL_location__ = "top":
      __SNAIL_s__ := __SNAIL_s__ + (0, _star.sy);
    elseif __SNAIL_location__ = "bottom":
      __SNAIL_s__ := __SNAIL_s__ - (0, _star.sy);
    fi;
    p := p shifted __SNAIL_s__;
  endgroup;
enddef;

% 含后缀参数的宏，后缀参数的实参容易与其他参数的名字以及宏内局部变量发生冲突，
% 所以只好将其他参数以及宏内变量予以丑化。
def as_planet(suffix p)(expr __SNAIL_ref__, __SNAIL_location__) =
  begingroup
    save s; pair s;
    as_star(p, __SNAIL_ref__, __SNAIL_location__);
    if __SNAIL_location__ = "left":
      p := p shifted ((_h_(0.5[_lrc_ p, _urc_ p], 0.5[_llc_ __SNAIL_ref__, _ulc_ __SNAIL_ref__]) - _planet.sx), 0);
    elseif __SNAIL_location__ = "right":
      p := p shifted ((_planet.sx - _h_(0.5[_llc_ p, _ulc_ p], 0.5[_lrc_ __SNAIL_ref__, _urc_ __SNAIL_ref__])), 0);
    elseif __SNAIL_location__ = "top":
      p := p shifted (0, (_planet.sy - _v_(0.5[_llc_ p, _lrc_ p], 0.5[_ulc_ __SNAIL_ref__, _urc_ __SNAIL_ref__])));
    elseif __SNAIL_location__ = "bottom":
      p := p shifted (0, (_v_(0.5[_ulc_ p, _urc_ p], 0.5[_llc_ __SNAIL_ref__, _lrc_ __SNAIL_ref__]) - _planet.sy));
    fi;
  endgroup;
enddef;

vardef anchor(expr p, base, location) =
  save edge_origin, anchor, ll, ul, ur, lr;
  pair edge_origin, anchor, ll, ul, ur, lr;
  ll := _llc_ p; ul := _ulc_ p; ur := _urc_ p; lr := _lrc_ p;
  if base = "left":
    edge_origin := 0.5[ll, ul];
    if location >= 0:
      anchor := location[edge_origin, ul];
    else:
      anchor := location[ll, edge_origin];
    fi;
  elseif base = "right":
    edge_origin := 0.5[lr, ur];
    if location >= 0:
      anchor := location[edge_origin, ur];
    else:
      anchor := location[lr, edge_origin];
    fi;
  elseif base = "top":
    edge_origin := 0.5[ul, ur];
    if location >= 0:
      anchor := location[edge_origin, ur];
    else:
      anchor := location[ul, edge_origin];
    fi;
  elseif base = "bottom":
    edge_origin := 0.5[ll, lr];
    if location >= 0:
      anchor := location[edge_origin, lr];
    else:
      anchor := location[ll, edge_origin];
    fi;
  fi;
  anchor
enddef;

vardef mate_in(expr p, base, mate) =
  save anchor, ll, ul, ur, lr;
  pair anchor, ll, ul, ur, lr;
  ll := _llc_ p; ul := _ulc_ p; ur := _urc_ p; lr := _lrc_ p;
  if base = "left":
    anchor := (xpart ll, ypart mate);
  elseif base = "right":
    anchor := (xpart lr, ypart mate);
  elseif base = "top":
    anchor := (xpart mate, ypart ul);
  elseif base = "bottom":
    anchor := (xpart mate, ypart ll);
  fi;
  anchor
enddef;

def align(suffix p, ref)(expr s) =
  
enddef;

tertiarydef a => b =
  begingroup
    if (pair a) and (pair b):
      a -- b
    elseif ((path a) or (picture a)) and ((path b) or (picture b)):
      save out, in, va, vb; pair out, in, va[], vb[];
      va[1] := _llc_ a; va[2] := _urc_ a;
      vb[1] := _llc_ b; vb[2] := _urc_ b;
      if xpart va[2] < xpart vb[1]: % a 在 b 的左侧
        out := 0.5[_lrc_ a, _urc_ a];
        in  := (xpart vb[1], ypart out);
      elseif xpart va[1] > xpart vb[2]: % a 在 b 的右侧
        out := 0.5[_llc_ a, _ulc_ a];
        in  := (xpart vb[2], ypart out);
      elseif ypart va[1] > ypart vb[2]: % a 在 b 的上方
        out := 0.5[_llc_ a, _lrc_ a];
        in  := (xpart out, ypart vb[2]);
      elseif ypart va[2] < ypart vb[1]: % a 在 b 的下方
        out := 0.5[_ulc_ a, _urc_ a];
        in  := (xpart out, ypart vb[1]);        
      fi;
      out -- in
    fi
  endgroup
enddef;

def flow = drawarrowpath enddef;
def tagged_flow(expr tag, anchor, c) text p =
  begingroup
    save formatted_tag, pos, offset, t;
    pair pos; numeric offset; string t, formatted_tag;
    formatted_tag := "\tfx" & tag;
    pos := point c along (p); offset := .25_pad_;
    if anchor = "top":
      pos := pos shifted (0, offset);
      t := "thetextext" & ".top";
    elseif anchor = "right":
      pos := pos shifted (offset, 0);
      t := "thetextext" & ".rt";
    elseif anchor = "bottom":
      pos := pos shifted (0, -offset);
      t := "thetextext" & ".bot";
    elseif anchor = "left":
      pos := pos shifted (-offset, 0);
      t := "thetextext" & ".lft";
    fi;
    drawarrowpath (p);
    draw scantokens(t)(formatted_tag, pos);
  endgroup;
enddef;

def draw_each text s = for i = s: draw i; endfor; enddef;
def flow_each text s = for i = s: flow i; endfor; enddef;

def enrich suffix p =
  forsuffixes i = W, N, E, S, SW, NW, NE, SE: pair p.i; endfor;
  p.SW := llcorner p; p.NW := ulcorner p;
  p.NE := urcorner p; p.SE := lrcorner p;
  p.W := .5[p.SW, p.NW]; p.N := .5[p.NW, p.NE];
  p.E := .5[p.NE, p.SE]; p.S := .5[p.SE, p.SW];
enddef;

def create_io_frame suffix p = path p.F; p.F := frame(p, _io_pad_); enddef;
def io_frame_for_each text s = forsuffixes i = s: create_io_frame(i); endfor; enddef;
def enrich_each text s = forsuffixes i = s: enrich i; endfor; enddef;

%%%%%%%%
%%%% 样式
color _io_color_, _proc_color_, _flow_color_, _frame_color_, _bg_color_;
_io_color_ := black;
_proc_color_ := darkred;
_flow_color_ := .9darkgray;
_frame_color_ := .7white;
_bg_color_ := .9white;
drawpathoptions(withpen pencircle scaled 1.5 withcolor _flow_color_);
%%%% 留白与间距尺寸
numeric _pad_, _io_pad_, _proc_pad_;
_pad_ := 4; _io_pad_ := 2_pad_; _proc_pad_ := 4_pad_;
numeric _star[], _planet[], _margin_;
_star.s := 4cm; _star.sx := _star.s; _star.sy := .5_star.sx;
_planet.s := .2_star.s; _planet.sx := _planet.s; _planet.sy := _planet.sx;
_margin_ := .5_planet.s;

%%%% 椭圆、菱形由矩形变化而来之时的长度和宽度的膨胀倍数
numeric _expansion_; _expansion_ := 1.25;
