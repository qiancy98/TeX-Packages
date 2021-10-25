\NeedsTeXFormat{LaTeX2e}[2015/01/01]
\ProvidesClass{SJTUexam}[2021/09/18 SJTU Exam class v0.0]

% Handle options
\newif\ifanswer
\answerfalse
\DeclareOption{answer}{
  \answertrue
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Packages
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{environ}
\RequirePackage{titlesec}
\RequirePackage{mdframed}
\usepackage[quiet]{fontspec} % 抑制所有报错！！！谨慎使用
\RequirePackage{ctex}
\RequirePackage{subfiles}

% Set length
\setlength{\parskip}{\medskipamount}
\setlength{\parindent}{0pt}
\setlength{\headheight}{13pt}

% Set default enumeration to (a), (b), (c), ...
\RequirePackage{enumitem}
\setenumerate{label=(\alph*)}

% Solution environment
\NewEnviron{answer}[1][1in]{
  \ifanswer
    \vspace{1ex}
    \begin{mdframed}
    \setlength{\parskip}{\medskipamount}
    \sffamily
    \BODY
    \end{mdframed}
    \vspace{1ex}
  \else
    % \begin{mdframed}
    % \vspace*{#1}
    % \end{mdframed}
  \fi
}

% Question numbering

\titleclass{\question}{straight}[\section]
\newcounter{question}

\titleformat{\question}    % command
{\heiti\large}          % format
{第 \thequestion 题：}   % label
{1ex}                      % sep
{ % before-code
}
\titlespacing{\question}{0pt}{2ex}{\smallskipamount}

% Question numbering

% \titleclass{\subquestion}{straight}[\section]
% \newcounter{subquestion}

% \titleformat{\subquestion}    % command
% {\heiti}          % format
% {\thequestion.\thesubquestion}   % label
% {1ex}                      % sep
% { % before-code
% }
% \titlespacing{\subquestion}{0pt}{1ex}{\smallskipamount}
% \ifanswer\else
%   % \newcommand{\questionbreak}{\clearpage}
% \fi

\newcounter{subquestion}
\newenvironment{subquestion}[1]
	{\refstepcounter{subquestion}\noindent \textbf{\thequestion.\thesubquestion}  #1}

\makeatletter
\@addtoreset{subquestion}{question}
\makeatother

% reference
\RequirePackage{cleveref}
\Crefname{enumi}{}{}
\crefname{enumi}{}{}
\crefname{subquestion}{}{}
\crefname{equation}{方程}{方程}

% tables
\RequirePackage{tabularx}
\newcolumntype{Y}{>{\centering\arraybackslash}X}

% Free Header and Footer
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyfoot[C]{--~ 第 \thepage 页 \ \  共 \pageref{LastPage} 页 ~--}
\renewcommand{\headrulewidth}{0pt}

% make title
\newcommand*{\minwidthbox}[2][3cm]{%
  \underline{\makebox[{\ifdim#1<1.1\width 1.1\width\else#1\fi}][c]{#2}}%
}

\makeatletter
\renewcommand{\maketitle}{%
	\ifanswer
		\title{{\ziju{0.5} \Huge 上海交通大学试卷(答案)}}
	\else
		\title{{\ziju{0.5} \Huge 上海交通大学试卷}}
	\fi
	\vspace{2pc}
	\begin{center}
		{\heiti\@title}

		\@date

		\ifx\course\undefined
			\ClassWarning{exam}{未定义课程名称\protect\course.\MessageBreak 使用\protect\newcommand{\protect\course}{课程名称}以定义之}
			\newcommand{\course}{}
		\fi
		\ifx\location\undefined
			\ClassWarning{exam}{未定义考试地点\protect\location.\MessageBreak 使用\protect\newcommand{\protect\location}{考试地点}以定义之}
			\newcommand{\location}{}
		\fi
		\ifx\quiztime\undefined
			\ClassWarning{exam}{未定义考试时间\protect\quiztime.\MessageBreak 使用\protect\newcommand{\protect\quiztime}{考试时间}以定义之}
			\newcommand{\quiztime}{}
		\fi

		\ifanswer
		{%
			\large
			\begin{tabular}{l}
				\\
				课程名称：\minwidthbox[4cm]{\course} \\
			\end{tabular}
		}
		\else
		{%
			\large
			\begin{tabular}{ll}
				\\
				班级号\underline{\hskip 3cm} 学号\underline{\hskip 3cm} & 姓名\underline{\hskip 4cm} \\
				\\
					考试时间\underline{\hskip0.55cm \quiztime \hskip 0.55cm}  & 地点\underline{\hskip0.55cm \location \hskip0.5cm} \\
				\\
				课程名称\underline{\hskip2.2cm \course \hskip1.5cm} &  成绩\underline{\hskip 4cm} \\
			\end{tabular}
			\vspace{1pc}
		}
		\fi
	\end{center}
}
\makeatother

% Newcommands
\newcommand{\qnewpage}{\ifanswer\else\newpage\fi}
\newcommand{\points}[1]{[#1\,分]}
\newcommand{\putchoice}[1]{\hfill（\ifanswer #1\else \quad \fi）}
\newcommand{\putfillblank}[1]{（\ifanswer #1\else \qquad \fi）}

\endinput
