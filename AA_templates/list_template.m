\documentclass[a4paper, 12pt]{article}

\usepackage[english]{babel}
\usepackage[utf8]{inputenc}
\usepackage{amsmath}
\usepackage{indentfirst}

%Image-related packages
%\usepackage{graphicx}
%\usepackage{subcaption}
%\usepackage[export]{adjustbox}
%\usepackage{wrapfig}
%
\setlength {\marginparwidth }{2cm}
\usepackage[colorinlistoftodos]{todonotes}
\usepackage{verbatim}
\usepackage{textcomp}
\usepackage{gensymb}
\usepackage{float}
\usepackage{caption}

\usepackage{hyperref}
\usepackage{listingsutf8} % only for \lstinputlisting{...}


\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,      
    urlcolor=cyan,
    pdftitle={Overleaf Example},
    pdfpagemode=FullScreen,
    }

\usepackage{xcolor}
\usepackage{listings}
\definecolor{mygreen}{rgb}{0,0.6,0}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
\definecolor{mymauve}{rgb}{0.58,0,0.82}
\definecolor{myorange}{rgb}{0.855,0.576,0.027}
\lstset{
language=Matlab,
frame=single,   
morecomment = [l][\itshape\color{teal}]{\%},
keywordstyle=\color{blue},
commentstyle=\color{mygreen},
breakatwhitespace=false,         
breaklines=true,  
numbers=left,
numbersep=5pt,
numberstyle=\tiny\color{mygray}, 
showstringspaces=false,
showtabs=false,                  
tabsize=2,
stringstyle=\color{myorange},
title=\lstname,
literate=
{+}{{{\color{red}+}}}1
{-}{{{\color{red}-}}}1
{*}{{{\color{red}*}}}1
{,}{{{\color{red},}}}1
{=}{{{\color{red}=}}}1
%{(}{{{\color{red}(}}}1
%{)}{{{\color{red})}}}1
{;}{{{\color{red};}}}1
{:}{{{\color{red}:}}}1
{[}{{{\color{red}[}}}1
{]}{{{\color{red}]}}}1
{>}{{{\color{red}>}}}1
{á}{{\'a}}1  {é}{{\'e}}1  {í}{{\'i}}1 {ó}{{\'o}}1  {ú}{{\'u}}1
      {Á}{{\'A}}1  {É}{{\'E}}1  {Í}{{\'I}}1 {Ó}{{\'O}}1  {Ú}{{\'U}}1
      {à}{{\`a}}1  {è}{{\`e}}1  {ì}{{\`i}}1 {ò}{{\`o}}1  {ù}{{\`u}}1
      {À}{{\`A}}1  {È}{{\'E}}1  {Ì}{{\`I}}1 {Ò}{{\`O}}1  {Ù}{{\`U}}1
      {ä}{{\"a}}1  {ë}{{\"e}}1  {ï}{{\"i}}1 {ö}{{\"o}}1  {ü}{{\"u}}1
      {Ä}{{\"A}}1  {Ë}{{\"E}}1  {Ï}{{\"I}}1 {Ö}{{\"O}}1  {Ü}{{\"U}}1
      {â}{{\^a}}1  {ê}{{\^e}}1  {î}{{\^i}}1 {ô}{{\^o}}1  {û}{{\^u}}1
      {Â}{{\^A}}1  {Ê}{{\^E}}1  {Î}{{\^I}}1 {Ô}{{\^O}}1  {Û}{{\^U}}1
      {œ}{{\oe}}1  {Œ}{{\OE}}1  {æ}{{\ae}}1 {Æ}{{\AE}}1  {ß}{{\ss}}1
      {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1  {Ø}{{\O}}1   {å}{{\r a}}1
      {Å}{{\r A}}1 {ã}{{\~a}}1  {õ}{{\~o}}1 {Ã}{{\~A}}1  {Õ}{{\~O}}1
      {ñ}{{\~n}}1  {Ñ}{{\~N}}1  {¿}{{?`}}1  {¡}{{!`}}1   {>}{{>}}1
}

\usepackage{caption}

\begin{document}

\begin{titlepage}
\begin{center}
\textbf{\LARGE University of Brasília}\\[0.5cm] 
\textbf{\large Electrical Engineering Department}\\[0.2cm]
\vspace{20pt}
\includegraphics{Logo_UnB.png}\\[1cm]

\par
\vspace{32pt}
\textbf{\LARGE Topics in Biomedical Engineering}\\
\vspace{5pt}
\textbf{\Large Exercise List X}\\
\vspace{30pt}
\textbf {\Large Authors:}\\[0.2cm]
\Large {Caio Luiz Candeias Flôres 190134283}\\[0.1cm]
\Large {Felipe Carneiro da Motta 200017616}\\[0.1cm]
\Large {João Pedro Daher Aranha 190109742}\\[0.1cm]



\end{center}

\par
\vfill
\begin{center}
{{\normalsize Brasília}\\
{\normalsize \today}}
\end{center}
\end{titlepage}

%Sumário
\newpage
\tableofcontents
\thispagestyle{empty}
%End Sumário

\newpage
\section{\textbf{Exercises}}

\subsection{\textbf{Exercise X:}}
\\

The MATLAB's code:

% insert the code here
\begin{lstlisting}

\end{lstlisting}

% insert the figure here
\begin{figure}[H]
    \centering
    \includegraphics[width=\textwidth]{x}
    \caption{x}
    \label{x}
\end{figure}


\end{document}