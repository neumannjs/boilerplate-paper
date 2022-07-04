Columns   Column
--------  -------
T         46

## Overview

* This is the template I created for my poster presentations. [@Dam2020]
* You can provide an optional \texttt{\textbackslash footimage}. [@Herrera-Joancomart2015]

----

## Options

* It's based on \texttt{beamerposter}, so you can change some options:

    size
    
    :   a0, a0b, a1, a2, a3, a4

    orientiation
    
    :   landscape, portrait
    
    scale
    :   a decimal number to scale the fonts

----

## Colour Themes

- I've included some colour themes, using the colour palettes from \url{http://colourlovers.com}
    * ComingClean (current theme)
    * Entrepreneur (light blue + grey)
    * Conspicious (a bit garish!)

---- 

## Figures and images

\tikzset{
    auto,node distance =1 cm and 1 cm,semithick,
    state/.style ={circle, draw, minimum width = 0.9 cm}
}
\begin{tikzpicture}
  \node[state] (m) at (0,0) {$M$};
  \node[state] (a) [right =of m] {$A$};
  \node[state] (b) [right =of a] {$B$};
  \path (m) edge (a);
  \path (a) edge (b);
\end{tikzpicture}

----

----

-------
Column
-------
46
-------

## This is a sample

- One, two, pick up my shoe
- Three, four, shut the door
- Five, six, pick up sticks
- Seven, eight, lay them straight
- Nine, ten, a big fat hen
- One, two, pick up my shoe
- Three, four, shut the door
- Five, six, pick up sticks
- Seven, eight, lay them straight
- Nine, ten, a big fat hen

----

## This is another sample

- Some maths material

\begin{align}
A &= U \times S \times V^T
\end{align}

----

## Tables with caption

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

:Demonstration of simple table syntax.

----

----

----
