uses bmp, dos, graph, crt;

const N = 4;

type punkts = record
            x, y : integer;
            name : string;
end;

var driver, mode : integer;
    i, j, t : integer;
    temp, st1, st2, st : string;
    p, sp, x, y : integer;
    pos : char;
    h, m,  hund, s : word;
    punkt : array[1..N] of punkts;
    hidden, fl : boolean;
    subPunkt : array[1..N] of punkts;
    ch : char;

procedure frame;
begin
     setColor(8);
     rectangle(5, getMaxY - 30, 175, getMaxY - 180);
     floodFill(25, getMaxY - 100, 8);
     line(5, getMaxY - 60, 175, getMaxY - 60);
     line(5, getMaxY - 95, 175, getMaxY - 95);
     line(5, getMaxY - 135, 175, getMaxY - 135);
     line(5, getMaxY - 180, 175, getMaxY - 180);
end;

procedure initPunkts;
begin

     punkt[1].x := 45;
     punkt[1].y := getMaxY - 157;
     punkt[1].name := 'Tic-Tac-Toe';

     punkt[2].x := 48;
     punkt[2].y := getMaxY - 117;
     punkt[2].name := 'Tabulation';

     punkt[3].x := 26;
     punkt[3].y := getMaxY - 80;
     punkt[3].name := 'Figures rotation';

     punkt[4].x := 72;
     punkt[4].y := getMaxY - 47;
     punkt[4].name := 'EXIT';
end;

procedure drawBackground;
var st1,st2,temp : string;
begin
     setBkColor(0);
     setFillStyle(1, lightBlue);
     bar(0, 0, getMaxX, getMaxY - 29);
     setColor(8);
     setFillStyle(1, 15);
     bar(0, getMaxY, getMaxX, getMaxY - 28);
     line(0, getMaxY - 28, getMaxX, getMaxY - 28);
     rectangle(4, getMaxY - 3, 80, getMaxY - 25);
     rectangle(getMaxX - 4, getMaxY - 3, getMaxX - 50, getMaxY - 25);
     setColor(15);
     outTextXY(getMaxX - 240, 10, '* Press ESC to show/hide menu');
     setColor(0);
     setTextStyle(0, 0, 1);
     outTextXY(40, getMaxY - 16, 'Menu');
     setTextStyle(0, 0, 1);
     getTime(h, m, s, hund);
     str(h, st1);
     str(m, st2);
     if h < 9 then st1 := '0' + st1;
     if m < 9 then st2 := '0' + st2;
     outTextXY(getMaxX - 45, getMaxY - 17, st1 + ':' + st2);
     sbmi('c:/tp/11.bmp', 5, getMaxY - 24, 0);
     sbmi('c:/tp/2.bmp', 20, 15, 0);
     outTextXY(10, 60, 'Computer');
     sbmi('c:/tp/3.bmp',getMaxX - 60, getMaxY - 100, 0);
     outTextXY(getMaxX - 60, getMaxY - 55, 'Trash');

end;

function subMenu1 : integer;
begin
      subPunkt[1].x := 230;
      subPunkt[1].y := punkt[1].y - 25;
      subPunkt[1].name := 'Play';

      subPunkt[2].x := 227;
      subPunkt[2].y := punkt[1].y + 25;
      subPunkt[2].name := 'About';
end;

function subMenu2 : integer;
begin
      subPunkt[1].x := 215;
      subPunkt[1].y := punkt[1].y + 15;
      subPunkt[1].name := 'Show graph';

      subPunkt[2].x := 233;
      subPunkt[2].y := punkt[1].y + 63;
      subPunkt[2].name := 'About';
end;

function subMenu3 : integer;
begin
      subPunkt[1].x := 200;
      subPunkt[1].y := punkt[1].y + 53;
      subPunkt[1].name := 'Show animation';

      subPunkt[2].x := 233;
      subPunkt[2].y := punkt[1].y + 103;
      subPunkt[2].name := 'About';
end;

function subMenu(i : integer) : integer;
var p, j, q : integer;
begin

     j := i;

     setColor(8);
     rectangle(175, punkt[j].y + 50, 330, punkt[j].y - 50);
     setFillStyle(1, 7);
     floodFill(178, punkt[j].y - 2, 8);
     line(175, punkt[j].y, 330, punkt[j].y);

     case j of
          1:subMenu1;
          2:subMenu2;
          3:subMenu3;
     end;

     p := 1;
     repeat
           clearDevice;
           initPunkts;
           drawBackground;
           frame;
           for q := 1 to N do
               outTextXY(punkt[q].x, punkt[q].y, punkt[q].name);
           setColor(8);
           rectangle(175, punkt[j].y + 50, 330, punkt[j].y - 50);
           setFillStyle(1, 15);
           floodFill(178, punkt[j].y - 2, 8);
           line(175, punkt[j].y, 330, punkt[j].y);
           for i := 1 to 2 do
           begin
                if (p = i) or ((t <> 0)) then
                begin
                     setFillStyle(1, green);
                     setColor(15);
                     floodFill(subpunkt[i].x, subpunkt[i].y - 5, 8);
                     setTextStyle(0, 0, 1);
                     outTextXY(180, subpunkt[i].y, '<');
                end else
                begin
                     setColor(0);
                     setTextStyle(0, 0, 1);
                end;
                outTextXY(subpunkt[i].x, subpunkt[i].y, subpunkt[i].name);
           end;

           pos := readkey;

           if pos = #72 then
           begin
                if p <= 1 then
                   p := 2
                else
                   dec(p);
           end;

           if pos = #80 then
           begin
                if p >= 2 then
                   p := 1
                else
                   inc(p);
           end;

           if pos = #75 then
           begin
              submenu := 0;
              exit;
           end;

     until (pos = #13) or (pos = #27);
     if pos = #27 then subMenu := 0 else
     subMenu := p;
end;



function menu(var s : integer) : integer;
var pos : char;
    x, y, p : integer;
begin
     p := 1;
     s := 0;
     repeat
           clearDevice;
           initPunkts;
           drawBackground;
           frame;
           for i := 1 to N do
           begin
                if (p = i) then
                begin
                     setFillStyle(1, green);
                     setColor(15);
                     floodFill(punkt[i].x, punkt[i].y - 5, 8);
                     setTextStyle(0, 0, 1);
                     if (p <> 4) then
                        outTextXY(165, punkt[i].y, '>');
                end else
                begin
                     setColor(0);
                     setTextStyle(0, 0, 1);
                end;
                outTextXY(punkt[i].x, punkt[i].y, punkt[i].name);
           end;

           pos := readkey;

           if pos = #72 then
           begin
                if p <= 1 then
                   p := N
                else
                   dec(p);
           end;

           if pos = #80 then
           begin
                if p >= N then
                   p := 1
                else
                   inc(p);
           end;
           s := 0;
           if ((pos = #77) or (pos = #13)) and (p <> 4) then s := subMenu(p);

           if s <> 0 then
           begin
                menu := p;
                exit;
           end;

     until (pos = #13) or (pos = #27);
     menu := p;
end;

procedure drawWindow(title : string);
begin
     clearDevice;
     setColor(7);
     drawBackground;
     rectangle(85, getMaxY - 3, 300, getMaxY - 25);
     outTextXY(115, getMaxY - 16, title);
     sbmi('c:/tp/4.bmp', 86, getMaxY - 24, 0);
     rectangle(200, 75, 500, 400);
     rectangle(202, 90, 498, 395);
     setFillStyle(1, 7);
     floodFill(250, 76, 0);
     setFillStyle(1, 15);
     floodFill(205, 100, 0);
     outTextXY(226, 80, title);
     rectangle(485, 78, 495, 88);
     floodFill(486, 79, 0);
     outTextXY(487, 80, 'X');
     rectangle(473, 78, 483, 88);
     floodFill(474, 79, 0);
     line(475, 86, 481, 86);
end;

procedure tabulation;
var a, b, h : real;
    i, j, x0, y0, x, y, mx, my, tx, ty : integer;
    driver, mode : integer;
    pos : char;
    temp : string;

function f(x : real) : real;
begin
     if (x < 10) then
        f := ln(10 - x) + 2
     else
        f := 3 - sqr(x);
end;

procedure printPlane;
begin
     drawBackground;

     setColor(0);
     rectangle(80, 50, 570, 405);
     rectangle(83, 70, 567, 395);
     setFillStyle(1, 7);
     floodFill(81, 51, 0);
     setFillStyle(1, 0);
     floodFill(84, 71, 0);


     setFillStyle(1, 15);
     setColor(0);
     rectangle(553, 55, 563, 65);
     rectangle(540, 55, 550, 65);
     floodFill(554, 56, 0);
     floodFill(541, 56, 0);
     setColor(0);
     outTextXY(555, 57, 'X');
     line(542, 63, 548, 63);
     outTextXY(105, 57, 'Tabulation');


     rectangle(85, getMaxY - 3, 255, getMaxY - 25);
     outTextXY(115, getMaxY - 16, 'Tabulation');
     sbmi('c:/tp/4.bmp', 86, getMaxY - 24, 0);
     setColor(15);
     line(getMaxX div 2, 100, getMaxX div 2, getMaxY - 100);
     line(100, getMaxY div 2, getMaxX - 100, getMaxY div 2);
     setTextStyle(0, 0, 1);
     outTextXY(getMaxX div 2 + 20, 85, 'y');
     outTextXY(getMaxX - 100, getMaxY div 2 + 20, 'x');
     setColor(yellow);
     setTextStyle(0, 0, 1);

     outTextXY(350, 120, 'Press ''+'' / ''-'' for zoom');
end;

begin

     x0 := getMaxX div 2;
     y0 := getMaxY div 2;

     mx := 6;
     my := 6;
     repeat
           a := -30;
           b := 30;
           h := 0.5;
           clearDevice;
           printPlane;
           setColor(10);
           while (a <= b) do
           begin
                x := x0 + round(a * mx);
                y := y0 - round(f(a) * my);
                line(x, y, x + 5, y);
                a := a + h;
           end;
           str(mx, temp);
           outTextXY(380, 145, 'Current scale: ' + temp);

           pos := readkey;
           if (pos = #43) and (mx < 8) then
           begin
                mx := mx + 1;
                my := my + 1;
           end;
           if (pos = #45) and (mx > 0) then
           begin
                mx := mx - 1;
                my := my - 1;
           end;
     until pos = #27;
end;

procedure tt;
const digits : array [1..3] of char = ('1','2','3');

var driver, mode : integer;
    q, finish, i, j, x, y, sx, sy, logsCnt : integer;
    area : array[1..3,1..3] of byte;
    a : array[1..3,1..3] of pointtype;
    winner : string;
    logs : array[1..100] of string;
    xScore,nScore : longint;
    pos : char;

procedure findFree(var x, y : integer);
var i, j : integer;
begin
     for i := 1 to 3 do
         for j := 1 to 3 do
             if (area[i,j] = 0) then
             begin
                  x := i;
                  y := j;
                  exit;
             end;
end;

procedure rocket;
begin
     setLineStyle(0, 0, 0);
     setColor(9);

     line (70,280,90,240);
     line (90,240,110,280);
     line (110,280,110,360);
     line (110,360,120,370);
     line (110,360,100,375);
     line (100,375,100,370);
     line (100,375,100,405);
     line (120,370,120,400);
     line (120,400,100,400);
     line (100,405,80,405);
     line (80,405,80,370);
     line (80,370,90,360);
     line (90,360,100,370);
     line (80,375,70,360);
     line (70,280,70,360);
     line (70,360,60,370);
     line (60,370,60,400);
     line (60,400,80,400);
     circle (90,280,10);
     circle(90,280,8);
     circle (90,310,10);
     circle(90,310,8);
     circle (90,340,10);
     circle(90,340,8);
     setFillStyle(1, red);
     line (70,410,65,420);
     line (65,420,75,440);
     line (75,440,85,425);
     line (80,415,90,440);
     line (90,440,100,415);
     line (95,425,105,440);
     line (105,440,115,420);
     line (115,420,110,410);

     line (500,280,520,240);
     line (520,240,540,280);
     line (540,280,540,360);
     line (540,360,550,370);
     line (540,360,530,375);
     line (530,375,530,370);
     line (530,375,530,405);
     line (550,370,550,400);
     line (550,400,530,400);
     line (530,405,510,405);
     line (510,405,510,370);
     line (510,370,520,360);
     line (520,360,530,370);
     line (510,375,500,360);
     line (500,280,500,360);
     line (500,360,490,370);
     line (490,370,490,400);
     line (490,400,510,400);
     circle (520,280,10);
     circle(520,280,8);
     circle (520,310,10);
     circle(520,310,8);
     circle (520,340,10);
     circle(520,340,8);
     line (500,410,495,420);
     line (495,420,505,440);
     line (505,440,515,425);
     line (510,415,520,440);
     line (520,440, 530,415);
     line (525,425,535,440);
     line (535,440, 545,420);
     line (545,420,540,410);

     setLineStyle(0, 0, 0);
end;

procedure sky;
var i : integer;
begin
      randomize;
      rocket;
      setColor(14);
      for i:=1 to 200 do
          circle(random(640), random(480),1);
end;

function isEnd : integer;
var i, j : integer;
begin
     for i := 1 to 3 do
     begin
         if (area[i,1] = area[i,2]) and (area[i,2] = area[i,3]) then
         begin
              if area[i,1] = 0 then continue;
              if area[i,1] = 1 then
              begin
                   isEnd := 1;
                   exit;
              end else
              begin
                   isEnd := 2;
                   exit;
              end;
         end;
         if (area[1,i] = area[2,i]) and (area[2,i] = area[3,i]) then
         begin
              if area[1,i] = 0 then continue;
              if area[1,i] = 1 then
              begin
                   isEnd := 1;
                   exit;
              end else
              begin
                   isEnd := 2;
                   exit;
              end;
         end;
     end;

     if (area[1,1] = area[2,2]) and (area[2,2] = area[3,3]) then
     begin
          if area[1,1] = 1 then
          begin
               isEnd := 1;
               exit;
          end else
          if area[1,1] = 2 then
          begin
               isEnd := 2;
               exit;
          end;
     end;

     if (area[1,3] = area[2,2]) and (area[2,2] = area[3,1]) then
     begin
          if area[1,3] = 1 then
          begin
               isEnd := 1;
               exit;
          end else
          if area[1,3] = 2 then
          begin
               isEnd := 2;
               exit;
          end;
     end;

     for i := 1 to 3 do
         for j := 1 to 3 do
             if area[i,j] = 0 then
             begin
                  isEnd := 0;
                  exit;
             end;
     isEnd := 3;
end;

procedure printArea;
var ch : char;
    i, j : integer;
begin
     sky;
     setColor(15);
     setTextStyle(0, 0, 1);
     outTextXY(490, getMaxY - 10, '*Press ESC to exit');
     setLineStyle(1, 1, 1);
     setColor(13);
     setTextStyle(defaultFont, horizDir, 3);
     outTextXY(455, 30, 'RESULT: ');
     outTextXY(50, 30, 'LOGS ');
     setColor(14);
     setColor(11);
     setTextStyle(defaultFont, horizDir, 1);

     for i := 1 to logsCnt do
     begin
          moveTo(40, 50 + 15 * i);
          outText(logs[i]);
     end;
     setColor(12);
     setTextStyle(defaultFont, horizDir, 3);
     outTextXy(253, 100, 'ARENA');
     setColor(white);
     rectangle(220, 140, 400, 320);
     line(340, 140, 340, 320);
     line(280, 140, 280, 320);
     line(220, 200, 400, 200);
     line(220, 260, 400, 260);
     for i := 1 to 3 do
       for j := 1 to 3 do
           if area[i,j] <> 0 then
           begin
                if area[i,j] = 1 then ch := 'X'
                else ch := '0';
                setTextStyle(defaultFont, horizDir , 3);
                outTextXY(a[i,j].y,a[i,j].x, ch);
           end;

end;

procedure initCoo;
var i, j : integer;
begin
     for i := 1 to 3 do
         for j := 1 to 3 do
             area[i,j] := 0;
     a[1,1].x := 160; a[1,1].y := 240;
     a[1,2].x := 220; a[1,2].y := 240;
     a[1,3].x := 280; a[1,3].y := 240;

     a[2,1].x := 160; a[2,1].y := 300;
     a[2,2].x := 220; a[2,2].y := 300;
     a[2,3].x := 280; a[2,3].y := 300;

     a[3,1].x := 160; a[3,1].y := 360;
     a[3,2].x := 220; a[3,2].y := 360;
     a[3,3].x := 280; a[3,3].y := 360;
end;

function move(var who : integer) : boolean;
var pos : char;
    ch : char;
    xpos, ypos : integer;
    tmp : boolean;
begin


     if (who = 1) then
        ch := 'X'
     else
        ch := '0';

     printArea;
     findFree(xpos,ypos);
     setColor(yellow);
     setTextStyle(defaultFont, horizDir , 3);
     outTextXY(a[xpos,ypos].y,a[xpos,ypos].x, ch);

     repeat

          pos := readKey;

          clearDevice;
          printArea;

          x := xpos;
          y := ypos;

          if pos = #27 then
          begin
               who := -1;
               exit;
          end;

          if pos = #75 then
          begin
               if xpos > 1 then dec(xpos)
               else xpos := 3;
          end;

          if pos = #77 then
          begin
               if xpos < 3 then inc(xpos)
               else xpos := 1;
          end;

          if pos = #80 then
          begin
               if ypos < 3 then inc(ypos)
               else ypos := 1;
          end;

          if pos = #72 then
          begin
               if ypos > 1 then dec(ypos)
               else ypos := 3;
          end;

          if (area[xpos,ypos] <> 0) then
          begin
               setFillStyle(1, red);
               bar(a[xpos,ypos].y - 18, a[xpos,ypos].x - 18, a[xpos,ypos].y + 38,a[xpos,ypos].x + 38);
               outTextXY(a[xpos,ypos].y,a[xpos,ypos].x, '!');
          end else
          begin

               setColor(yellow);
               setTextStyle(defaultFont, horizDir , 3);
               outTextXY(a[xpos,ypos].y,a[xpos,ypos].x, ch);
          end;

     until (pos = #13);
     if area[xpos,ypos] <> 0 then
     begin
          setTextStyle(defaultFont, horizDir, 1);
          inc(logsCnt);
          logs[logsCnt] := 'Can''t put ' + ch + ' here';
          tmp := move(who);
     end else
     begin
          area[xpos,ypos] := who;
          inc(logsCnt);
          logs[logsCnt] := ch + ' move to: ' + digits[xpos] + ' ' + digits[ypos];
     end;
end;
begin
    q := 2;
    initCoo;
    printArea;
    repeat
          if (q = 2) then q := 1
          else q := 2;
          move(q);
          if q = -1 then exit;
          finish := isEnd;
    until finish <> 0;
    setTextStyle(defaultFont, horizDir, 3);
    case finish of
      1: winner := 'X WIN!';
      2: winner := '0 WIN!';
      3: winner := 'DRAW!';
    end;
    setColor(lightGreen);
    outTextXY(460, 80, winner);
    pos := readKey;
end;
procedure rotation;

procedure drawPlane;
var x, y, sx, sy : integer;
    i, j : integer;

begin
     drawBackground;

     setColor(0);
     rectangle(80, 50, 570, 405);
     rectangle(83, 70, 567, 395);
     setFillStyle(1, 7);
     floodFill(81, 51, 0);
     setFillStyle(1, 0);
     floodFill(84, 71, 0);


     setFillStyle(1, 15);
     setColor(0);
     rectangle(553, 55, 563, 65);
     rectangle(540, 55, 550, 65);
     floodFill(554, 56, 0);
     floodFill(541, 56, 0);
     setColor(0);
     outTextXY(555, 57, 'X');
     line(542, 63, 548, 63);
     outTextXY(105, 57, 'Figures rotation');


     rectangle(85, getMaxY - 3, 255, getMaxY - 25);
     outTextXY(115, getMaxY - 16, 'Figures rotation');
     sbmi('c:/tp/4.bmp', 86, getMaxY - 24, 0);
     setColor(15);
     setColor(yellow);
     setTextStyle(0, 0, 1);

end;

procedure drawThis(x0, y0 : integer);
var ro, fi1, fi2, fi, a, h : real;
    x, y, k : integer;
    fl : boolean;
begin
     a := 1;
     k := 80;
     h := 0.001;
     fi1 := pi/2 + pi/4;
     fi2 := 3*pi/2 - pi/4;
     fi := fi1;
     fl := false;
     while (fi < fi2) do
     begin
          ro := a*abs(sqrt(2*abs(cos(2*fi))));
          x := trunc(x0 + (ro * cos(fi) * k));
          y := trunc(y0 - (ro * sin(fi) * k));
          putPixel(x, y, 10);
          fi := fi + h;
          if (fi >= fi2) and (not fl) then
          begin
               fi1 := -pi/4;
               fi2 := pi/4;
               fi := fi1;
               fl := true;
          end;
     end;
end;

var a, b, k : real;
    x0, y0, x, y, mx, my, prevx, prevy : integer;
    fi1, fi2, fi, x1, y1, ro, h  : real;
    fl : boolean;
begin
     clearDevice;
     drawPlane;

     x0 := getMaxX div 2;
     y0 := getMaxY div 2;

     a := 1;
     k := 80;
     h := 0.03;
     fi1 := pi/2 + pi/4;
     fi2 := 3*pi/2 - pi/4;
     fi := fi1;
     fl := false;
     while (fi < fi2) do
     begin
          prevx := x;
          prevy := y;
          ro := a*abs(sqrt(2*abs(cos(2*fi))));
          x := trunc(x0 + (ro * cos(fi) * k));
          y := trunc(y0 - (ro * sin(fi) * k));
          setColor(0);
          drawThis(x0, y0);
          circle(prevx, prevy, 15);
          setColor(11);
          circle(x, y, 15);
          fi := fi + h;
          if (fi >= fi2) and (not fl) then
          begin
               fi1 := -pi/4;
               fi2 := pi/4;
               fi := fi1;
               fl := true;
          end;
     end;
end;

label hell;

begin
     {$M 45360, 0, 655360}
hell:
     detectGraph(driver, mode);
     initGraph(driver, mode, '');
     p := 3;
     hidden := true;
     while p <> 4 do
     begin
          clearDevice;
          drawBackground;
          pos := readkey;
          if (pos = #27) then
          begin
               if (hidden) then
               begin
                    hidden := false;
                    p := menu(sp);
                    if (p = 1) then
                    begin
                        if sp = 1 then
                        begin
                             clearDevice;
                             tt;
                             closeGraph;
                             goto hell;
                        end;
                        if sp = 2 then
                        begin
                             ch := '!';
                             repeat
                                   drawWindow('About Tic-Tac-Toe');
                                   outTextXY(210, 110, 'Tic-Tac-Toe - game for two players');
                                   outTextXY(210, 125, 'X and 0 take turns marking the');
                                   outTextXY(210, 140, 'spaces in 3x3 grid. The player');
                                   outTextXY(210, 155, 'who succeeds placing three');
                                   outTextXY(210, 170, 'respective marks in a horizontal,');
                                   outTextXY(210, 185, 'vertical, or diagonal row');
                                   outTextXY(210, 200, 'wins the game');
                                   outTextXY(350, 383, '*Press ESC to exit');
                                   ch := readkey;
                             until ch = #27;
                        end;
                    end;


                    if p = 2 then
                    begin
                         if sp = 2 then
                         begin
                              ch := '!';
                              repeat
                                    drawWindow('About Tabulation');
                                    outTextXY(210, 110, 'Tabulation - program which draw');
                                    outTextXY(210, 125, 'graph of the function');
                                    outTextXY(210, 140, 'f := ln(10 - x) + 2    (x <= 10)');
                                    outTextXY(210, 155, 'f := 3 - sqr(x)        (x > 10)');
                                    outTextXY(350, 383, '*Press ESC to exit');
                                    ch := readkey;
                              until ch = #27;
                         end;
                         if sp = 1 then tabulation;
                     end;

                    if p = 3 then
                    begin
                         if sp = 2 then
                         begin
                              ch := '!';
                              repeat
                                    drawWindow('About Figures rotation');
                                    outTextXY(210, 110, 'If you want to see how to circle');
                                    outTextXY(210, 125, 'moves along the path of an infinity,');
                                    outTextXY(210, 140, 'then start this program');
                                    outTextXY(350, 383, '*Press ESC to exit');
                                    ch := readkey;
                              until ch = #27;
                         end;
                         if sp = 1 then
                         begin
                              rotation;
                              readkey;
                         end;
                    end;

                    if p = 4 then halt;

               end else hidden := true;
          end;
     end;
end.