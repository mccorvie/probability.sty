
%%
%%	   A light overlay of the mccorviescribe class to support features
%%     related to transcribing lectures, seminars and courses.
%%  
%% 
%% Copyright (c) 2017 by Ryan McCorvie
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 

\NeedsTeXFormat{LaTeX2e}[2017/04/13]
\ProvidesClass{mccorviescribe}
    [2017/10/13 v0.1 first draft pulling together commonly used templates]
\ClassInfo{mccorviescribe}{Copyright (c) 2017 Ryan McCorvie}
\RequirePackage{ifthen}
\RequirePackage[nodayofweek]{datetime}

% -----------------------------------------------------------
% -----------------------------------------------------------
%                     Process options
% -----------------------------------------------------------
% -----------------------------------------------------------


% Type (course, seminar, talk)
%   Course is a medium-length document (tens of pages)
%     structured in sections, subsections and optionally paragraphs;
%     if subsections are short, one can ask for headersection not to display
%     subsections in headers; if subsections are long, one can ask for
%     theoremsubsection to number theorems inside subsection. It has lectures
%     number as a margin note.
%   Seminar is a short unstructured document (maybe with paragraph or small
%     subsections).
%   Talk is to prepare a speech - with the same structure as seminar, but is
%     designed to write only the things one will write at the blackboard.

\DeclareOption{course}{%
  \newcommand{\mcnotes@type}{course}%
  \providecommand{\mcnotes@header}{subsection}
  \providecommand{\mcnotes@theorem}{section}
  \providecommand{\mcnotes@columns}{onecolumn}
  \providecommand{\mcnotes@side}{twoside}
  \PassOptionsToPackage{fleqn}{amsmath}%
}
\DeclareOption{seminar}{%
  \newcommand{\mcnotes@type}{seminar}%
  \providecommand{\mcnotes@header}{title}
  \providecommand{\mcnotes@theorem}{nosection}
  \providecommand{\mcnotes@columns}{onecolumn}
  \providecommand{\mcnotes@side}{twoside}
  \PassOptionsToPackage{fleqn}{amsmath}%
}
\DeclareOption{talk}{%
  \newcommand{\mcnotes@type}{talk}%
  \providecommand{\mcnotes@header}{no}
  \providecommand{\mcnotes@theorem}{nosection}
  \providecommand{\mcnotes@columns}{twocolumn}
  \providecommand{\mcnotes@side}{oneside}
  \hbadness=10000%
  \vbadness=10000%
  \tolerance=10000%
}


% Header (headertitle,headersection,headersubsection, headerno)
%   title displays speaker on left and title on right.
%   section displays section on left and right
%   headersubsection displays section on left and subsection on right
%   headerno does not display headers

\DeclareOption{headertitle}{\renewcommand{\mcnotes@header}{title}}
\DeclareOption{headersection}{\renewcommand{\mcnotes@header}{section}}
\DeclareOption{headersubsection}{\renewcommand{\mcnotes@header}{subsection}}
\DeclareOption{headerno}{\renewcommand{\mcnotes@header}{no}}
% Theorem (theoremnosection,theoremsection,theoremsubsection)
%   theoremnosection numbers theorem continuously in the document
%   theoremsection reset theorem numbering on section changes
%   theoremsubsection reset theorem numbering on subsection changes
\DeclareOption{theoremnosection}{\newcommand{\mcnotes@theorem}{nosection}}
\DeclareOption{theoremsection}{\newcommand{\mcnotes@theorem}{section}}
\DeclareOption{theoremsubsection}{\newcommand{\mcnotes@theorem}{subsection}}

% Number of sides (oneside,twoside)
\DeclareOption{oneside}{\renewcommand{\mcnotes@side}{oneside}}
\DeclareOption{twoside}{\renewcommand{\mcnotes@side}{twoside}}

% Number of columns (onecolumn,twocolumn)
\DeclareOption{onecolumn}{\renewcommand{\mcnotes@columns}{onecolumn}}
\DeclareOption{twocolumn}{\renewcommand{\mcnotes@columns}{twocolumn}}


\DeclareOption*{%
  \PackageWarning{mccorviescribe}{Unknown option ‘\CurrentOption’}%
}


\ProcessOptions \relax

% load the standard article
\LoadClass{mccorviesnotes}


% -----------------------------------------------------------
% -----------------------------------------------------------
%                      Preamble commands
% -----------------------------------------------------------
% -----------------------------------------------------------

\providecommand{\mcnotes@email}{}
\providecommand{\mcnotes@speaker}{}
\providecommand{\mcnotes@titleshort}{}
\providecommand{\mcnotes@place}{}
\providecommand{\mcnotes@conference}{}


\renewcommand{\date}[3]{\newdate{@date}{#1}{#2}{#3}}
\newcommand{\dateend}[3]{\renewcommand{\mcnotes@dateenddef}{}\newdate{@dateend}{#1}{#2}{#3}}
\newcommand{\email}[1]{\renewcommand{\mcnotes@email}{#1}}
\newcommand{\titleshort}[1]{\renewcommand{\mcnotes@titleshort}{#1}}

\newcommand{\speaker}[1]{\renewcommand{\mcnotes@speaker}{#1}}
\newcommand{\place}[1]{\renewcommand{\mcnotes@place}{#1}}
\newcommand{\conference}[1]{\renewcommand{\mcnotes@conference}{#1}}



\AtBeginDocument{
	{  \pagestyle{fancy}
		\ifthenelse{\equal{\mcnotes@header}{title}}%
	         {%
	           \renewcommand{\sectionmark}[1]{}%
	           \renewcommand{\subsectionmark}[1]{}%
	         }{}
		\ifthenelse{\equal{\mcnotes@header}{section}}%
	         {%
	           \renewcommand{\sectionmark}[1]{\markboth{\thesection.\ \smallcaps{#1}}{\thesection.\ \smallcaps{#1}}}%
	           \renewcommand{\subsectionmark}[1]{}%
	         }{}
		\ifthenelse{\equal{\mcnotes@header}{subsection}}%
	         {
	           \renewcommand{\sectionmark}[1]{\markboth{\thesection.\ \smallcaps{#1}}{}}%\thesection.\ \smallcaps{#1}}}
	           \renewcommand{\subsectionmark}[1]{\markright{\thesubsection.\ \smallcaps{#1}}}%
	         }{}
	}
  \fancyhf{}
  \ifthenelse{\equal{\mcnotes@header}{title}}%
  {\ifthenelse{\isundefined{\mcnotes@titleshort}}%
  	{\fancyhead[LE]{\smallcaps\@title}}%
  	{\fancyhead[LE]{\smallcaps\mcnotes@titleshort}}%
      \ifthenelse{\isundefined{\mcnotes@speaker}}%
	  {\fancyhead[RO]{\smallcaps\@author}}%
	  {\fancyhead[RO]{\smallcaps\mcnotes@speaker}}}%
  {\fancyhead[LE]{\smallcaps\leftmark}%
  \fancyhead[RO]{\smallcaps\rightmark}}

  \fancyfoot[RO,LE]{\smallcaps\thepage}
  \ifthenelse{\equal{\mcnotes@header}{no}}%
    {\renewcommand{\headrulewidth}{0pt}}%
    {\renewcommand{\headrulewidth}{0.5pt}}

	\hypersetup{
		pdftitle={\@title},pdfauthor={\@author},
		pdfkeywords={\mcnotes@speaker{}:\mcnotes@conference{}:\mcnotes@place{}},
	}
	\pdfinfo{/ModDate (D:\pdfdate)}

	\maketitle
	\ifthenelse{\equal{\mcnotes@type}{course}}{\tableofcontents}{}
}


% -----------------------------------------------------------
% -----------------------------------------------------------
%               Common typesetting structures
% -----------------------------------------------------------
% -----------------------------------------------------------


\renewcommand\maketitle{\par
  \begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\parindent 1em\noindent
    \hb@xt@1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \@maketitle
  \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
}

\renewcommand{\@maketitle}{
  \newpage
  \null
  \vskip 4ex%
  \begin{center}%
    \let \footnote \thanks
    {\Large\smallcaps\@title}%
    {\ifthenelse{\isundefined{\mcnotes@speaker}}{}{{\vskip 1ex\large\smallcaps\mcnotes@speaker}\par}}%
    \vskip 1.5em%
    {\large
    \begin{tabular}[t]{c}%
      \ifthenelse{\equal{\mcnotes@email}{}}{%
        {\small\itshape\@author}%
      }{%
        {\small\itshape\@author}\footnote{\href{mailto:\mcnotes@email}{\mcnotes@email}}%
      }
    \end{tabular}\par}%
    \vskip 2ex%
    \ifthenelse{\equal{\mcnotes@conference}{}}%
    {%
      \ifthenelse{\equal{\mcnotes@place}{}}{}%
      {%
        {\small\itshape\mcnotes@place}%
        \vskip 1ex%
      }%
    }%
    {%
      \ifthenelse{\equal{\mcnotes@place}{}}%
      {%
        {\small\itshape\mcnotes@conference}%
        \vskip 1ex%
      }%
      {%
        {\small\itshape\mcnotes@conference, \mcnotes@place}%
        \vskip 1ex%
      }%
    }
    \ifthenelse{\isundefined{\mcnotes@dateenddef}}{%
    {\small\itshape\displaydate{@date}}}{%
    {\small\itshape\displaydate{@date} -- \displaydate{@dateend}}}%
  \end{center}%
  \par
  \vskip 3ex
}

\newcommand{\makedefaultsection}[2][true]{
  \ifthenelse{\equal{\mcnotes@type}{course}}{
    \ifthenelse{\equal{#1}{true}}{\addcontentsline{toc}{section}{#2}}{}
    \section*{#2}
    \ifthenelse{\equal{\mcnotes@header}{section}}{\markboth{\smallcaps{#2}}{\smallcaps{#2}}}{}
    \ifthenelse{\equal{\mcnotes@header}{subsection}}{\markboth{\smallcaps{#2}}{}}{}}{}
  \ifthenelse{\equal{\mcnotes@type}{seminar}}{
    \ifthenelse{\equal{#1}{true}}{\addcontentsline{toc}{subsection}{#2}}{}
    \subsection*{#2}
    \ifthenelse{\equal{\mcnotes@header}{subsection}}{\markright{\smallcaps{#2}}}{}}{}
  \ifthenelse{\equal{\mcnotes@type}{talk}}{
    \ifthenelse{\equal{#1}{true}}{\addcontentsline{toc}{subsection}{#2}}{}
    \subsection*{#2}
    \ifthenelse{\equal{\mcnotes@header}{subsection}}{\markright{\smallcaps{#2}}}{}}{}
}

\renewcommand{\tableofcontents}{%
  \makedefaultsection[false]{\contentsname}
  \@starttoc{toc}%
}
jk
