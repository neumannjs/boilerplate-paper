# In the morning

## Getting up

- Turn off alarm
- Get out of bed

::: notes

This is my note.

- It can contain Markdown
- like this list

:::

## Breakfast

- Eat eggs
- Drink coffee

\tikzset{
    auto,node distance =1 cm and 1 cm,semithick,
    state/.style ={circle, draw, minimum width = 0.9 cm},
    optional/.style={dashed},
}
\begin{tikzpicture}
  \node[state] (m) at (0,0) {$M$};
  \node[state] (a) [below left =of m, xshift=0.4cm] {$A$};
  \node[state] (b) [below right =of m, xshift=-0.4cm] {$B$};
  \path (m) edge[bend right=20] (a);
  \path (a) edge[bend right=20] (b);
  \path[optional] (m) edge[bend left=20] (b);
\end{tikzpicture}

# In the evening

## Dinner

- Eat spaghetti
- Drink wine

------------------

![picture of spaghetti](./slides/images/spaghetti.jpg)

## Going to sleep

- Get in bed
- Count sheep
