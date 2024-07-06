\NeedsTeXFormat{LaTeX2e}[2006/01/01]% LaTeX date must January 2006 or later

\ProvidesClass{SSMH_nonOA}[2020/11/27 v1.1]

\DeclareOption*{\OptionNotUsed}
\ProcessOptions\relax

\LoadClass[b5paper,reqno]{amsart}[2000/10/26 v2.08]

%%%%% Basic Packages
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{varwidth}
\RequirePackage{mathtools}
\RequirePackage[british]{babel}
\RequirePackage{url}

%%%%% Font Types

\RequirePackage{ifxetex}
\RequirePackage{ifthen}

\ifxetex
\RequirePackage{libertine}
\RequirePackage{fontspec} 

\setmainfont[Ligatures={Common,TeX}]{Linux Libertine O}
\setromanfont[Mapping=tex-text]{Linux Libertine O}
\setsansfont{Cabin Condensed}
\setmonofont{Linux Libertine Mono O}
\newfontfamily\scshape[Letters=SmallCaps,Scale=1.15]{Linux Libertine O C}
\newfontfamily{\textit}{Linux Libertine O Italic}
\newfontfamily{\textbf}{Linux Libertine O Bold}
\newfontfamily{\textbold}{Cabin Condensed Bold Condensed}
\newfontfamily{\bfseries}{Cabin Condensed Bold Condensed}
\renewcommand{\em}{\textit}

\RequirePackage{xunicode}
\RequirePackage{xltxtra}

\else
    \RequirePackage{libertine}
\RequirePackage{libertinust1math}
\RequirePackage[condensed]{cabin}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \RequirePackage{textcomp}
  \RequirePackage[final,expansion=true,protrusion=true,spacing=true,kerning=true]{microtype}
\newcommand{\textbold}{\sffamily\bfseries}
\fi

%%%%% Colors
\RequirePackage{xcolor}
\definecolor{coolblack}{rgb}{0.0, 0.18, 0.39}

%%%%% Watermark

%\RequirePackage[printwatermark]{xwatermark}


%\newwatermark[allpages,color=gray!20,angle=60,scale=2.5,xpos=-5,ypos=0]{\textsf{UNCORRECTED PROOF}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% certain lines in amsart.cls 2000/10/26 v2.08 are modified
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% line 222 in amsart.cls
\RequirePackage[b5paper, top=3.5cm, outer=3.5cm, inner=3.5cm, bottom=4cm, headsep=1cm
%width=14.6 cm,height=22.5cm
]{geometry}

%%%%% line 240 in amsart.cls
\parskip=0pt plus 1pt

%%%%%  AK Heather & Footer
\RequirePackage{fancyhdr}
\RequirePackage[export]{adjustbox}
\renewcommand{\headrule}{\hbox to\headwidth{
  \color{black}\leaders\hrule height \headrulewidth\hfill}}
\setlength{\headheight}{21pt}

\pagestyle{fancy}
\fancyhf[HLE,HRO]{\sf \thepage} 
\fancyhf[HLO,HRE]{\rule[-1ex]{0pt}{1ex}
\textsf{{\textbold{SSc. Math. \textit{(CoGeTo)}}} \textsf{\biblinfo}}}
\clearpage
%\setlength{\headsep}{1cm}
\fancyhf[FLE,FRO]{
\vspace{.6cm}
{\includegraphics[scale=0.13,valign=c]{AKlogo}}}
\fancyhf[FCE,FCO]{}

\fancypagestyle{firstpage}
{\lhead{
\rule[-1ex]{0pt}{1ex}{{\textsf{\textbold{\small Studia Scientiarum Mathematicarum Hungarica \\
\textit{Combinatorics, Geometry and Topoplogy}}} \\
\textsf{\small \biblinfo}}} 
\\
\rule[-2ex]{0pt}{2ex}{\textsf{DOI: {\color{coolblack} \DOI}}}}
\rfoot{\vspace{.6cm}\includegraphics[scale=.18,valign=c]{AKJournals2}}
\rhead{\raisebox{.7cm}{\includegraphics[scale=.2,valign=c]{AKlogoText}}}}
\clearpage
%\setlength{\headsep}{3cm}

\usepackage{xpatch}
\xapptocmd{\titlepage}{\thispagestyle{firstpage}}{}{}


%%%%% Corresponding Author footnote
\RequirePackage{scrextend}
\deffootnote{2em}{0em}{\thefootnotemark \quad}

\newcommand\note[2][*]{%
\if!#1!%
\stepcounter{footnote}\footnotetext{Corresponding author. E-mail: \CorrespondingAuthorEmail}%
\else%
{\renewcommand\thefootnote{#1}%
\footnotetext{\hspace{-.3cm} Corresponding author. E-mail: \CorrespondingAuthorEmail}}%
\fi}

%%%%% and between authors, etc.
%%%%% line 587-589 in amsart.cls
\def\@@and{\protect\@@@and}
\def\@@@and{\normalfont{and}}
\renewcommand{\andify}{%
  \nxandlist{\unskip, }{\unskip{} \@@and~}{\unskip{} \@@and~}}

%%%%% affiliation toks
\newtoks\affil@toks\newif\ifaffil\affilfalse
\newcommand{\affiliation}[2][]{%
\affiltrue
  \if!#1!%
    \affil@toks=\expandafter{\the\affil@toks{\item[]#2}}%
  \else
    \affil@toks=\expandafter{\the\affil@toks{\item[$^{#1}$]#2}}%
  \fi
}

\makeatletter


%%%% maketitle
%%%% lines 632-653 in amsart.cls
\def\@maketitle{% 
\vspace*{10mm}
%%%% Title
  {\normalfont   \let\bfseries\relax \LARGE
%\normalsize
  \@adminfootnotes
  \global\topskip42\p@\relax % reduced
  \@settitle}
%%%% Author
{\let\MakeUppercase\relax % this disables uppercasing authors
 \ifx\@empty \author \else \@setauthors \fi
  \ifx\@empty\@dedicatory
  \else
    \baselineskip18\p@
    \vtop{\centering{\Small(\@dedicatory)\@@par}% font change
                                % and ()
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi}
\vspace{.6cm}
%%%% Affiliation
\ifaffil\begin{list}{}{%
\setlength{\leftmargin}{5pt}%
\setlength{\labelsep}{3pt}%
\setlength{\itemsep}{0pt}%
\setlength{\topsep}{-\parskip}}
\itshape\small%
\normalfont{\the\affil@toks}
\end{list}\fi
\vspace{.2cm}
%%%% Communicated by
{\small \textit{Communicated by \HandlingEditor}}
\vspace{.2cm} 

%%%% Article type
\noindent
{\small \textsf{\textbold{\articletype}}} 
\vspace{-.3cm}

%%%% Copyright
\noindent
\begin{minipage}[l]{7cm}
{\small
\textsf{\textbold{Received:\ {\received} \ \textbullet \ \ Accepted:\  {\accepted}}} 
\bigskip

\textbold{\textcopyright}\ \textsf{\textbold{2021 
Akad\'emiai Kiad\'o, Budapest}}}
\end{minipage}
\hspace{1.4cm} 
\begin{minipage}{2cm}
\raisebox{15pt}{ \includegraphics[width=\textwidth]{CrossMark}}
\end{minipage}
\vspace{-.5cm}

  \@setabstract
\vspace{.2cm}
  \@setkeyword
  \@setsubjclass
  \normalsize
  \if@titlepage
    \newpage
  \else
    \dimen@34\p@ \advance\dimen@-\baselineskip
    \vskip\dimen@\relax
  \fi
} % end \@maketitle

%%%%% title
%%%%% lines 785-791
%\def\@settitle{\begin{center}%
%{\huge \bfseries {\MakeUppercase{\@title}} \par
%  \end{center}%
%}

%%%%%% author list
%%%%%% lines 792--796
\def\author@andify{%
  \nxandlist {\unskip ,\penalty-1 \space\ignorespaces}%
    {\unskip {} \@@and~}%
    {\unskip {}\penalty-2 \space \@@and~}%
}

%%%%% ABSTRACT
%%%%% lines 742-759  in amsart.cls
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in this documentclass}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
    \normalfont\Small
    \list{}{\labelwidth\z@
      \leftmargin0pc \rightmargin\leftmargin   %%%%%3pc -> 0pc
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
\hrule
\vspace{.5cm}
    \item[\hskip\labelsep\bfseries{\normalsize\sffamily\MakeUppercase\abstractname}]\mbox{}\\[1ex]%
                                              %%%%%sc->bf
                                                    %%%%% . -> mbox\\
}
{%
\vspace{.5cm}

\hrule
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi}

%%%%% Keywords

\def\@setkeyword{\noindent
  {\sffamily
  \bfseries
  \MakeUppercase{Keywords} \\
  \sffamily
  \bfseries
  {\scriptsize {\KeyWords}}}
  \par
}

%%%%% Subjectclass
\def\@setsubjclass{
\vspace{.5cm}
\hrule 
\vspace{.5cm}
\noindent
  {\sffamily
  \bfseries
  \MakeUppercase{Mathematics Subject Classification (2020)} \\
\normalfont \footnotesize
  {{Primary \PrimarySubjectClass; 
    Secondary  \SecondarySubjectClass}}}
  \par
}

%%%%% descriptions
%%%%% line 932 in amsart.cls
\renewcommand{\descriptionlabel}[1]{\hspace\labelsep\scshape #1:}

%%%%% STARTSECTION
%%%%% lines 937-946 in amsart.cls
\g@addto@macro\bfseries{\boldmath}

\def\@startsection#1#2#3#4#5#6{%
 \if@noskipsec \leavevmode \fi
 \par \@tempskipa #4\relax
 \@afterindentfalse                 %%%%% true -> false
 \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
 \if@nobreak \everypar{}\else
     \addpenalty\@secpenalty\addvspace\@tempskipa\fi
 \@ifstar{\@dblarg{\@sect{#1}{\@m}{#3}{#4}{#5}{#6}}}%
         {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}

%%%%% no intendation in the first line of a section
\let\@afterindenttrue\@afterindentfalse
\@afterindentfalse

\RequirePackage{titlesec}

\titleformat{\section}[block]{}{\Large \sffamily\bfseries\thesection.\;}{0pt}{\formatsectiontitle}
\newcommand{\formatsectiontitle}[1]{\Large \sffamily\bfseries\MakeUppercase{#1} \noindent}

\titleformat{\subsection}[block]{}{\Large \sffamily\bfseries\thesubsection.\;}{0pt}{\formatsubsectiontitle}
\newcommand{\formatsubsectiontitle}[1]{\Large\sffamily\bfseries{#1} \noindent}

\titleformat{\subsubsection}[block]{}{\sffamily\bfseries\thesubsubsection.\;}{0pt}{\formatsubsubsectiontitle}
\newcommand{\formatsubsubsectiontitle}[1]{\sffamily\bfseries{#1} \noindent}

%%%%%BIBLIOGRAPHY
%%%%%lines 1162-1174 in amsart.cls

\RequirePackage{placeins}

\newenvironment{references}[1]
{\par
\vspace{-.2cm}

\hrule
\vspace{-.4cm}

\renewcommand\refname{}
%\bibliographystyle{acm}
\bibliographystyle{plain}

\bibliography{#1}
}


%%%%%
%%%%% THEOREMSTYLE
%%%%% lines 1485-1494 in amsart.cls
%%%%% plain
\def\th@plain{%
    \thm@headfont{\footnotesize\sffamily\bfseries}% heading font is bold   scshape
  \normalfont % body font
}

\RequirePackage{amsthm}

\newtheoremstyle{MathPann}% name of the style to be used
 {3pt}%Space above
 {3pt}%Space below
 {}%Body font
 {}%Indent amount
 {}%Theorem head font
 {.}%Punctuation after theorem head
 {.5em}%Space after theorem head
 {\small\textbold{
%\textsf
{\MakeUppercase{\thmname{#1}} \thmnumber{#2}}}}% Theorem head spec (can be left empty, meaning ‘normal’)


\theoremstyle{MathPann}
 \newtheorem{proposition}{{Proposition}}[section]
  \newtheorem{lemma}[proposition]{Lemma}
  \newtheorem{corollary}[proposition]{Corollary}
  \newtheorem{theorem}[proposition]{Theorem}
  \newtheorem{definition}[proposition]{Definition}
  \newtheorem{example}[proposition]{Example}
  \newtheorem{construction}[proposition]{Construction}
  \newtheorem{claim}[proposition]{}
  \newtheorem{assumption}[proposition]{Assumption}
  \newtheorem{remark}[proposition]{Remark}


 \newcommand{\Section}{\setcounter{definition}{0}\section}
  \newcounter{c}
  \renewcommand{\[}{\setcounter{c}{1}$$}
  \newcommand{\etyk}[1]{\vspace{-7.4mm}$$\begin{equation}\Label{#1}
  \addtocounter{c}{1}}
  \renewcommand{\]}{\ifnum \value{c}=1 $$\else \end{equation}\fi}
  \setcounter{tocdepth}{2}

\renewcommand{\theequation}{\thesection.\arabic{equation}}

\numberwithin{equation}{section}

%%%%% PROOF ENVIRONMENT
%%%%% lines 1695-1704 in amsart.cls

\renewenvironment{proof}{\paragraph{\sffamily{Proof}.}}
{\hfill$\square$}

%%%%% Additional constructs

\newcommand{\any}{\mkern1mu\cdot\mkern1mu}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}

\frenchspacing
%%%%% END OF FILE  MathPannX.cls
