%% columncv.cls
%%
%% Package to typeset a cv, using two colmns. The left one contains
%% the labels and the right one the descriptions. These should be 
%% contained within an environment defined by \begin{cvenv} ... 
%% \end{cvenv}. This environment takes an optional parameter which
%% specifies the separator to be used between the columns. By default,
%% this is none, but [|] may be specified. If any other character needs 
%% to be used, it must be specified as [!{decl.}] -- this is due to the 
%% implementation of the array package used in this package.  Labels and 
%% entries are defined by using \cvitem{}{}. Sections are defined by 
%% using the sectioning environments. The CV title is created with 
%% \makecvtitle.
%%
%% Lengths specific to this package that can be redefined:
%%  \implevel  importance threshold -- al entries with value less and
%%             equal to this will be inserted into document
%%  \cvsecsep  vertical space between sections
%%  \cvitemsep vertical space between entries within an environment
%%  \lcolwidth width of the left column as a percentage of \textwidth
%%  \rcolwidth width of the right column as a percentage of \textwidth
%%
%% Author and Copyright: Pieter Rautenbach
%% Date: 23/09/2004-22/04/2005

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{columncv}[2005/04/22 v1.0 Column-based curriculum vitae class]

%\renewcommand{\normalsize}{\fontsize{10pt}{12pt}\selectfont}
%\pagenumbering{arabic}

%% pass all options to the article class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

\ProcessOptions\relax

%% this class builds on the article class
\LoadClass{article}

%% additional packages needed
\RequirePackage{ifthen}
\RequirePackage{longtable}
\RequirePackage{array}
%% \RequirePackage{fancyhdr}

%\DeclareRobustCommand{cmd}[num][default]{def}
%\ClassError{class}{error}{help}
%\PackageWarning
%\PackageInfo

%% \DeclareOption{}{}
%% \DeclareOption*{}
%% \ExecuteOptions{}
%% \ProcessOptions

%% margins
\setlength{\hoffset}{0pt}
\setlength{\voffset}{0pt}
\setlength{\oddsidemargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\evensidemargin}{0pt}
\setlength{\topskip}{0pt}
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2in}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2in}
\setlength{\marginparsep}{0pt}
\setlength{\headsep}{1ex}%0pt
\setlength{\marginparwidth}{0pt}
\setlength{\headheight}{2em}%20pt
\setlength{\textfloatsep}{0pt}
%% \footnotesep=3ex

%% importance level
\newcounter{implevel}
\setcounter{implevel}{0}

%% vspace between (sub)(sub)sections
\newlength{\cvsecsep}
\setlength{\cvsecsep}{1ex plus 0.5ex minus 0ex}
%% vspace between environment interline spacing
%% it must be a rubber length
\newlength{\cvitemsep}
\setlength{\cvitemsep}{0.5ex} 
%% \DeclareOption{ex}{\setlength{\cvitemsep}{5ex}}
%% \DeclareOption*{\setlength{\cvitemsep}{0.5ex}}
%% percentage of pagewidth of left column
\newlength{\lcolwidth}
\setlength{\lcolwidth}{0.26\textwidth}
%% percentage of pagewidth of right column
\newlength{\rcolwidth}
\setlength{\rcolwidth}{0.74\textwidth}

%% cv environment
%% start a longtable with two columns: 
%%   the left-hand column is right aligned
%%   the right-hand column is left aligned
\newenvironment{cvenv}[1][]%!{decl.}
{\begin{longtable}{>{\raggedleft}p{0.9\lcolwidth}#1>{\raggedright}p{0.9\rcolwidth}}%
\cvitemtoks={}}%
{\the\cvitemtoks\end{longtable}}%

%% cv item command
%% typeset one line in the table:
%%    the left-hand column in bold font and
%%    the right-hand column in normal font
%% implevel defines the importance level:
%%    if the optional parameter #1 is greater than
%%    implevel, it won't be inserted into the table
\newtoks\cvitemtoks
\newcommand{\cvitem}[3][0]{%
  \ifthenelse{\value{implevel}<#1}{}{%
    \cvitemtoks=\expandafter{\the\cvitemtoks \textit{#2}&#3\tabularnewline}%
  }%
}

%% sectioning commands, based on the standard ones,
%% but without numbering
%% \newcommand{\cvsection}[1]{%
%%   \section*{#1}
%% }
\newcommand{\cvsection}{%
  \@startsection{section}{1}{0pt}%
  {\cvsecsep}%
  {\cvsecsep}%
  {\bfseries\Large}*}
%% \newcommand{\cvsubsection}[1]{%
%%   \subsection*{#1}
%% }
\newcommand{\cvsubsection}{%
  \@startsection{subsection}{2}{0pt}%
  {\cvsecsep}%
  {\cvsecsep}%
  {\bfseries\large}*}
\newcommand{\cvsubsubsection}{%
  \@startsection{subsubsection}{3}{0pt}%
  {\cvsecsep}%
  {\cvsecsep}%
  {\bfseries\normalsize}*}

%% creates a heading ``Curriculum Vitae'' with today's date
\newcommand{\makecvtitle}{% [1][Curriculum Vitae]{%
\thispagestyle{plain}
\begin{center}
  {\LARGE \textbf{Curriculum Vitae}} \\[\cvitemsep]
  \today{}
\end{center}
}
