# Scopa2 report — diagrams

Each `.tex` file in this directory is a standalone TikZ `tikzpicture`
intended to be `\input{}` from `../distributed-systems-final-report.tex`
in place of the existing `\figph{…}{…}{…}` placeholders.

| File                  | Replaces placeholder                                              |
|-----------------------|-------------------------------------------------------------------|
| `topology.tex`        | `\figph{topology}{…}{…}` in section *Infrastructure*              |
| `class-engine.tex`    | `\figph{class-engine}{…}{…}` in section *Domain Modelling*        |
| `seq-matchmaking.tex` | `\figph{seq-matchmaking}{…}{…}` in section *Interaction Patterns* |
| `seq-action.tex`      | `\figph{seq-action}{…}{…}` in section *Interaction Patterns*      |
| `state-match.tex`     | `\figph{state-match}{…}{…}` in section *Behaviour*                |
| `deployment.tex`      | `\figph{deployment}{…}{…}` in section *Deployment*                |

## 1. Preamble additions

Add the following to the preamble of `distributed-systems-final-report.tex`
(any time before `\begin{document}`):

```latex
\usepackage{tikz}
\usetikzlibrary{
    positioning,
    arrows.meta,
    fit,
    backgrounds,
    calc,
    shapes.geometric,
    shapes.multipart
}
```

`automata` is **not** required — the state machine uses plain TikZ nodes.

## 2. Replacing a placeholder

Replace each `\figph{name}{height}{caption}` call with a real `figure`
environment. For example, for the topology diagram:

```latex
% before
\figph{topology}{3.4cm}{Global symmetric topology. …}

% after
\begin{figure}[h]
    \centering
    \resizebox{\textwidth}{!}{\input{diagrams/topology.tex}}
    \caption{Global symmetric topology. …}
    \label{fig:topology}
\end{figure}
```

The `\resizebox{\textwidth}{!}{…}` wrapper guarantees that the diagram
always fits the column width regardless of how the TikZ code grew during
authoring. For diagrams that are already narrow (e.g. `class-engine`),
you can drop the wrapper and let TikZ render at its natural size.

If you prefer a single helper, drop this macro into the preamble and use
it as a drop-in replacement for `\figph`:

```latex
\newcommand{\figtikz}[2]{%
    \begin{figure}[h]
        \centering
        \resizebox{\textwidth}{!}{\input{diagrams/#1.tex}}
        \caption{#2}
        \label{fig:#1}
    \end{figure}%
}
```

Then each placeholder becomes a single line, for example:

```latex
\figtikz{topology}{Global symmetric topology. …}
```

## 3. Editing tips

* All six files share the same TikZ style vocabulary (`actor`, `pod`,
  `res`, `svc`, `flow`, `msg`, `rmsg`, …). Tweaks to colours or sizes
  can usually be done locally inside the diagram you are editing.
* The sequence diagrams use absolute `y` coordinates declared at the
  top (`\def\ya{-0.6}`, …). To insert a new step in the middle, shift
  the labels below it down by a uniform amount (e.g. `0.45`) rather
  than recomputing.
* The class diagram uses `rectangle split` UML boxes; if `pdflatex`
  complains about a missing library, ensure `shapes.multipart` is in
  the `\usetikzlibrary` list above.
