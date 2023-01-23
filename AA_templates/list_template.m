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
{�}{{\'a}}1  {�}{{\'e}}1  {�}{{\'i}}1 {�}{{\'o}}1  {�}{{\'u}}1
      {�}{{\'A}}1  {�}{{\'E}}1  {�}{{\'I}}1 {�}{{\'O}}1  {�}{{\'U}}1
      {�}{{\`a}}1  {�}{{\`e}}1  {�}{{\`i}}1 {�}{{\`o}}1  {�}{{\`u}}1
      {�}{{\`A}}1  {�}{{\'E}}1  {�}{{\`I}}1 {�}{{\`O}}1  {�}{{\`U}}1
      {�}{{\"a}}1  {�}{{\"e}}1  {�}{{\"i}}1 {�}{{\"o}}1  {�}{{\"u}}1
      {�}{{\"A}}1  {�}{{\"E}}1  {�}{{\"I}}1 {�}{{\"O}}1  {�}{{\"U}}1
      {�}{{\^a}}1  {�}{{\^e}}1  {�}{{\^i}}1 {�}{{\^o}}1  {�}{{\^u}}1
      {�}{{\^A}}1  {�}{{\^E}}1  {�}{{\^I}}1 {�}{{\^O}}1  {�}{{\^U}}1
      {�}{{\oe}}1  {�}{{\OE}}1  {�}{{\ae}}1 {�}{{\AE}}1  {�}{{\ss}}1
      {�}{{\c c}}1 {�}{{\c C}}1 {�}{{\o}}1  {�}{{\O}}1   {�}{{\r a}}1
      {�}{{\r A}}1 {�}{{\~a}}1  {�}{{\~o}}1 {�}{{\~A}}1  {�}{{\~O}}1
      {�}{{\~n}}1  {�}{{\~N}}1  {�}{{?`}}1  {�}{{!`}}1   {>}{{>}}1
}

\usepackage{caption}

\begin{document}

\begin{titlepage}
\begin{center}
\textbf{\LARGE University of Bras�lia}\\[0.5cm] 
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
\Large {Caio Luiz Candeias Fl�res 190134283}\\[0.1cm]
\Large {Felipe Carneiro da Motta 200017616}\\[0.1cm]
\Large {Jo�o Pedro Daher Aranha 190109742}\\[0.1cm]



\end{center}

\par
\vfill
\begin{center}
{{\normalsize Bras�lia}\\
{\normalsize \today}}
\end{center}
\end{titlepage}

%Sum�rio
\newpage
\tableofcontents
\thispagestyle{empty}
%End Sum�rio

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