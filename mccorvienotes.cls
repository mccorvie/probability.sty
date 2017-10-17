
%%
%%	   This collects Ryan's package and font preferences to make it easy to 
%%     create simple short mathematical documents, suitable for personal notes or
%%     homework solutions or short essays
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
\ProvidesClass{mccorvienotes}
    [2017/10/13 v0.1 first draft pulling together commonly used templates]
\ClassInfo{mccorvienotes}{Copyright (c) 2017 Ryan McCorvie}
\RequirePackage{ifthen}
\RequirePackage[nodayofweek]{datetime}

% -----------------------------------------------------------
% -----------------------------------------------------------
%                     Process options
% -----------------------------------------------------------
% -----------------------------------------------------------

\newdateformat{usvardate}{\monthname[\THEMONTH] \ordinal{DAY}, \THEYEAR}
\usvardate
\newcommand{\mcnotes@lang}{english}


\DeclareOption{notes}{%
  \newcommand{\mcnotes@type}{\CurrentOption}%
  \providecommand{\mcnotes@header}{title}
  \providecommand{\mcnotes@theorem}{nosection}
  \providecommand{\mcnotes@columns}{onecolumn}
  \providecommand{\mcnotes@side}{twoside}
  \PassOptionsToPackage{fleqn}{amsmath}%
}


\DeclareOption*{%
  \PackageWarning{mccorvienotes}{Unknown option ‘\CurrentOption’}%
}

\ProcessOptions \relax

% load the standard article
\LoadClass[letterpaper,11pt,\mcnotes@side]{article}

% -----------------------------------------------------------
% -----------------------------------------------------------
%                         Package section
% -----------------------------------------------------------
% -----------------------------------------------------------

\RequirePackage{geometry}
\geometry{letterpaper,portrait,left=3cm,right=3cm,top=3cm,bottom=3cm}


% --- Internationalization support

\RequirePackage[\mcnotes@lang]{babel} % Support for languages other than US english
\RequirePackage[fixlanguage]{babelbib} % extend this to bibliographies

% Input encoding is UTF8 unicode
\RequirePackage[utf8x]{inputenc}
\SetUnicodeOption{mathletters}
\SetUnicodeOption{autogenerated}


% --- Hyperlinks
% Many PDF on the web don't have hyperlinks, from the table of contents to the sections, to 
% an equation from where they refer to it, etc. With this package you can have automatically 
% all these links and also tweak PDF metadatas.
\RequirePackage[pdftex,colorlinks,linkcolor=black,urlcolor=black,citecolor=black]{hyperref}

% --- Graphics packages

% the modern interface for importing various types of graphics
\RequirePackage[pdftex]{graphicx}
\DeclareGraphicsExtensions{.pdf,.PDF,.eps,.EPS,.png,.PNG,.jpg,.JPG,.jpeg,.JPEG}

% tikz: is a high-level drawing vector graphics language, designed by Till Tantau (you can 
% remember him for software like latex-beamer); you can see a gallery with examples here.
\RequirePackage{tikz} 
\usetikzlibrary{arrows}
\usetikzlibrary{patterns}
\usetikzlibrary{shapes}


% --- Font packages
\RequirePackage{dsfont}
\RequirePackage{bera} % Let's try using bera as our default font
%\RequirePackage{stmaryrd} %St Mary's Road symbol font
%\RequirePackage{latexsym} % Defines a dozen character symbols (alread in AMS packages)
%\RequirePackage[osf,sc]{mathpazo} % the Palatino font
%\linespread{1.05} 

% --- Macros for typesetting structures (headers, tables, table of contents, etc)
\RequirePackage{fancyhdr} % to customize the content of headers and footers on each page
\newcommand{\contentsfinish}{}
\RequirePackage[titles]{tocloft} % Attractive table of contents

%\RequirePackage{titlesec}  % Serious package for typesetting of titles
%\RequirePackage{titleps}   % Serious package for typesetting page features
%\RequirePackage{titletoc}  % Serious package for typesetting of table of contents

\RequirePackage{mparhack} % workaround for a bug on LaTeX \marginpar.
\RequirePackage{booktabs} % for better looking tables (see documentation)
\RequirePackage{multirow} % tables with cells spanning multiple rows


\RequirePackage{enumerate} % fancier enumerations
\RequirePackage{boxedminipage} % boxed minipage for boxed problem environment
\RequirePackage{microtype} % adjusts microtypographical features like kerning

\RequirePackage{lastpage} % easy hook to refer to the last page, for footers


% --- Math formatting packages
\RequirePackage[leqno]{amsmath}
\RequirePackage{amsthm,amsfonts,amssymb}
\RequirePackage{amsxtra} % really rare amstex commands

% mathtools defines useful helper macros for common mathematical typographic combinations
% the documentation is an inspiring source of  tips for beautiful typesetting
\RequirePackage{mathtools} %  

\RequirePackage{mathdots} % redefines \dots and its friends so that they change size when appropriate.

\RequirePackage{xfrac} % to typeset nice inline fractions, as in ½.


% --- Ryan's math macro files
\RequirePackage{probability}  % formatting for common probability constructs
\RequirePackage{mccorviemath}  % other common mathematical notation

% -----------------------------------------------------------
% -----------------------------------------------------------
%                 General setup
% -----------------------------------------------------------
% -----------------------------------------------------------

\delimitershortfall=5pt

\frenchspacing
%\DeclareRobustCommand{\smallcaps}[1]{\scshape{#1}}%\MakeTextLowercase{#1}}

\DeclareRobustCommand{\smallcaps}[1]{\textit{#1}}%\MakeTextLowercase{#1}}

\newcommand{\mymarginpar}[1]{\marginpar{\setstretch{0.7}\textit{\scriptsize{#1}}}}
\newcommand{\separator}{\begin{center}\rule{\columnwidth}{\arrayrulewidth}\end{center}}
\newcommand{\tosay}[1]{\begin{center}\text{\fbox{\scriptsize{#1}}}\end{center}}
\newcounter{mcnotes@lecture}
\newcommand{\lecture}[4][]{%
  \addtocounter{mcnotes@lecture}{1}%
  \newdate{@datelecture#2#3#4}{#2}{#3}{#4}%
  \mymarginpar{\mcnotes@lecturename{}\ \arabic{mcnotes@lecture} \ifthenelse{\equal{#1}{}}{}{\ (#1)}\\ \displaydate{@datelecture#2#3#4}}%
}
\newcommand{\TODO}{\mymarginpar{TODO}}%



% -----------------------------------------------------------
% -----------------------------------------------------------
%                      Math environments
% -----------------------------------------------------------
% -----------------------------------------------------------

% from "notes" template
%\newtheoremstyle{itstyle}{10pt}{10pt}{\normalfont\itshape}{}{\normalfont\smallcaps}{.}{.5em}{}
%\newtheoremstyle{rmstyle}{10pt}{10pt}{\normalfont}{}{\normalfont\smallcaps}{.}{.5em}{}

\newtheoremstyle{itstyle}     % name % cf. thmtest.tex of AMSLaTeX
	{3pt}                     % Space above
	{3pt}                     % Space below
	{\itshape}                % Body font
	{}                        % Indent amount (empty = no indent,
	                          %        \parindent = para indent)
	{\bfseries\sffamily}      % Thm head font
	{.}                       % Punctuation after thm head
	{ }                       % Space after thm head: " " = normal interword space;
	                          %                       \newline = linebreak
	{}                        % Thm head spec (can be left empty, meaning `normal')
\newtheoremstyle{rmstyle} % name % cf. thmtest.tex of AMSLaTeX
	{3pt}                     % Space above
	{3pt}                     % Space below
	{}                        % Body font
	{}                        % Indent amount (empty = no indent,
	                          %        \parindent = para indent)
	{\bfseries\sffamily}      % Thm head font
	{.}                       % Punctuation after thm head
	{ }                       % Space after thm head: " " = normal interword space;
	                          %                       \newline = linebreak
	{}                        % Thm head spec (can be left empty, meaning `normal')


\swapnumbers % numbers before theorems
\theoremstyle{itstyle}
\newtheorem{theorem}{Theorem}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem{claim}[theorem]{Claim}

\theoremstyle{rmstyle}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{exercise}[theorem]{Exercise}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{fact}[theorem]{Fact}
\newtheorem{problem}[theorem]{Problem}
\newtheorem{notation}[theorem]{Notation}

\numberwithin{equation}{section}


%% Itemize and enumerate for bera
\newcommand{\@reduceitemsep}{\addtolength{\itemsep}{-0.5\baselineskip}}
\let\OLD@itemize\itemize
\renewcommand\itemize{\OLD@itemize\@reduceitemsep}
\let\OLD@enumerate\enumerate
\renewcommand\enumerate[1][1.]{\OLD@enumerate[#1]\@reduceitemsep}


%% smaller sections titles

\renewcommand{\section}{%
  \@startsection
      {section}
      {1}
      {0em}
      {\baselineskip}
      {0.5\baselineskip}
      {\normalfont\large\bfseries}}
\renewcommand{\subsection}{%
  \@startsection
      {subsection}
      {2}
      {0em}
      {\baselineskip}
      {0.25\baselineskip}
      {\normalfont\bfseries}}


% -----------------------------------------------------------
% -----------------------------------------------------------
%                      Preamble commands
% -----------------------------------------------------------
% -----------------------------------------------------------

\providecommand{\mcnotes@email}{}
\providecommand{\mcnotes@titleshort}{}


\renewcommand{\date}[3]{\newdate{@date}{#1}{#2}{#3}}
\newcommand{\email}[1]{\renewcommand{\mcnotes@email}{#1}}
\newcommand{\titleshort}[1]{\renewcommand{\mcnotes@titleshort}{#1}}


\AtBeginDocument{

  \pagestyle{fancy}
  \renewcommand{\sectionmark}[1]{}%
  \renewcommand{\subsectionmark}[1]{}%

  \fancyhf{}
  \ifthenelse{\isundefined{\mcnotes@titleshort}}%
  	{\fancyhead[LE]{\smallcaps\@title}}%
  	{\fancyhead[LE]{\smallcaps\mcnotes@titleshort}}%
	 
  \fancyhead[RO]{\smallcaps\@author}

  \fancyfoot[RO,LE]{\smallcaps\thepage}

  \renewcommand{\headrulewidth}{0.5pt}

	\hypersetup{
		pdftitle={\@title},
    pdfauthor={\@author},
	}
	\pdfinfo{/ModDate (D:\pdfdate)}

  \maketitle
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
    {\Large\@title}%
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
    \small\itshape\displaydate{@date}
    \par
  \end{center}
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

\renewenvironment{thebibliography}[1]{
  \makedefaultsection{\refname}
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
       \sloppy
       \clubpenalty4000
       \@clubpenalty \clubpenalty
       \widowpenalty4000%
       \sfcode`\.\@m%
}{
  \def\@noitemerr
      {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist%
}




