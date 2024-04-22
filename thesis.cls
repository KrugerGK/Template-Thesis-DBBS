%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
%%%%%%%%    Clase Thesis
%%%%%%%%    Autor: Gabriel Krüger C.
%%%%%%%%    Version: 0.8.0
%%%%%%%%    Fecha: 2024-04-22
%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2022/09/22 v0.0.1 Clase LaTex para escritura de tesis DBBS]

%% Definicion de Condicionales
\newif\if@swapnum
\newif\if@contnum
\newif\if@en
\@swapnumfalse
\@contnumtrue
\@enfalse

%% Declaracion de Opciones
\DeclareOption{leftnum}{\@swapnumtrue}
\DeclareOption{rightnum}{\@swapnumfalse}
\DeclareOption{contnum}{\@contnumtrue}
\DeclareOption{english}{\@entrue}
\DeclareOption{nocontnum}{\@contnumfalse}
\DeclareOption{uprightd}{\AtEndOfPackage{\DeclareMathSymbol{d}{\mathalpha}{operators}{`d}}}
\DeclareOption{uprighte}{\AtEndOfPackage{\DeclareMathSymbol{e}{\mathalpha}{operators}{`e}}}
\DeclareOption{uprighti}{\AtEndOfPackage{\DeclareMathSymbol{i}{\mathalpha}{operators}{`i}}}
\DeclareOption{upright}{\ExecuteOptions{uprightd,uprighte,uprighti}}

%% Pasar Opciones a clase Book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt,letterpaper,oneside]{book}

%% Packages necesarios
\RequirePackage[utf8]{inputenc} %Encoding
\RequirePackage[top=2cm, left=3cm, bottom=2cm, right=2cm, paper=letterpaper]{geometry} % Margenes
\RequirePackage{amsmath, amssymb, amsthm, graphicx} % Varios

%% Caption antes de la tabla
\RequirePackage{caption}
\captionsetup[table]{position=above}

%% Agregar palabra para anexos
\RequirePackage[titletoc]{appendix}

\if@en
	\RequirePackage{babel}
\else
	\RequirePackage[spanish, es-nolists, es-lcroman]{babel} % Lenguaje
\fi
\RequirePackage[pdfpagelabels,hidelinks]{hyperref} % Links y numeracion del PDF
\RequirePackage{listings} % Codigo Fuente
\RequirePackage{pgffor} % foreach

%% Lenguaje
\addto\captionsspanish{\renewcommand\tablename{Tabla}}
\addto\captionsspanish{\renewcommand\contentsname{Índice}}

%% Agregar la bibliografía al índice
\let\oldbib\bibliography
\renewcommand{\bibliography}[1]{%
	\oldbib{#1}%
	\if@en
		\addcontentsline{toc}{chapter}{\protect\numberline{}Bibliography}%
	\else
		\addcontentsline{toc}{chapter}{\protect\numberline{}Bibliograf\'ia}%
	\fi
}
\addto\captionsspanish{\renewcommand\listtablename{Índice de Tablas}}
\addto\captionsspanish{\renewcommand\listfigurename{Índice de Figuras}}

%% Interlineado
\setlength{\parskip}{2ex} %interlineado doble

%% Renovar enumerado e itemizado
\let\oldenum\enumerate
\let\oldendenum\endenumerate
\renewenvironment{enumerate}{\oldenum\setlength{\parskip}{\smallskipamount}}{\oldendenum}
\let\olditem\itemize
\let\oldenditem\enditemize
\renewenvironment{itemize}{\olditem\setlength{\parskip}{\smallskipamount}}{\oldenditem}

%% Entornos nuevos
\newenvironment{abstract}{%
\clearpage
\if@en
	\chapter*{Abstract}
\else
	\chapter*{Resumen}
\fi
}{\vfill\null}

\newenvironment{resumen}{%
\chapter*{Resumen}
}{\vfill\null}

\newenvironment{dedicatoria}{\clearpage\null\vspace{\stretch{1}}\begin{flushright}\itshape}{\end{flushright}\vspace{\stretch{2}}\null}
\let\thanks\undefined

\newenvironment{thanks}{
	\clearpage
	\if@en
		\chapter*{Acknowledgments}
	\else
		\chapter*{Agradecimientos}
	\fi
	
}
{\vfill\null}

%% Teoremas, proofs, etc
\renewenvironment{proof}[1][\proofname] {\par\pushQED{\qed}\normalfont\topsep6\p@\@plus6\p@\relax\trivlist\item[\hskip\labelsep\scshape\footnotesize#1\@addpunct{.}]\ignorespaces}{\popQED\endtrivlist\@endpefalse}

\newtheoremstyle{miestilo}{\baselineskip}{3pt}{\itshape}{}{\bfseries}{}{.5em}{}
\newtheoremstyle{miobs}{\baselineskip}{3pt}{}{}{\bfseries}{}{.5em}{}
\if@swapnum
	\swapnumbers
\fi
\theoremstyle{miestilo}
\newtheorem{defn}{Definición}[chapter]
\if@contnum
	\if@en
		\newtheorem{teo}[defn]{Theorem}
		\newtheorem{cor}[defn]{Corollary}
		\newtheorem{lema}[defn]{Lemma}
		\newtheorem{prop}[defn]{Proposition}
	\else
		\newtheorem{teo}[defn]{Teorema}
		\newtheorem{cor}[defn]{Corolario}
		\newtheorem{lema}[defn]{Lema}
		\newtheorem{prop}[defn]{Proposición}
	\fi
\else
	\if@en
		\newtheorem{teo}{Theorem}[chapter]
		\newtheorem{cor}{Corollary}[chapter]
		\newtheorem{lema}{Lemma}[chapter]
		\newtheorem{prop}{Proposition}[chapter]
	\else
		\newtheorem{teo}{Teorema}[chapter]
		\newtheorem{cor}{Corolario}[chapter]
		\newtheorem{lema}{Lema}[chapter]
		\newtheorem{prop}{Proposición}[chapter]
	\fi
\fi
\theoremstyle{miobs}

\if@en
	\newtheorem*{ej}{Example}
	\newtheorem*{obs}{Observation}
\else
	\newtheorem*{ej}{Ejemplo}
	\newtheorem*{obs}{Observación}
\fi

%% Comandos y variables para la portada
\global\def\@universidad{Universidad Andrés Bello}
\newcommand{\setuniversidad}[1]{\def\@carrera{#1}}
\let\universidad\setuniversidad
\let\setuniversidad\relax

\global\def\@facultad{Facultad de Ciencias de la Vida}
\newcommand{\setfacultad}[1]{\def\@carrera{#1}}
\let\facultad\setfacultad
\let\setfacultad\relax

\global\def\@doctorado{Doctorado en Bioinformática y Biología de Sistema}
\newcommand{\setdoctorado}[1]{\def\@carrera{#1}}
\let\doctorado\setdoctorado
\let\setdoctorado\relax

\global\def\@lugar{Santiago de Chile}
\newcommand{\setlugar}[1]{\def\@lugar{#1}}
\let\lugar\setlugar
\let\setlugar\relax

\global\let\@tesis\@empty
\newcommand{\settesis}[1]{\def\@tesis{#1}}
\let\tesis\settesis
\let\settesis\relax

\global\let\@cotutela\@empty
\newcommand{\setcotutela}[1]{\def\@cotutela{#1}}
\let\cotutela\setcotutela
\let\setcotutela\relax

\global\let\@tutor\@empty
\newcommand{\settutor}[1]{\def\@tutor{#1}}
\let\tutor\settutor
\let\settutor\relax

\global\let\@cotutor\@empty
\newcommand{\setcotutor}[1]{\def\@cotutor{#1}}
\let\cotutor\setcotutor
\let\setcotutor\relax

\global\let\@comision\@empty
\newcommand{\setcomision}[1]{\def\@comision{#1}}
\let\comision\setcomision
\let\setcomision\relax

\global\let\@auspicio\@empty
\newcommand{\setauspicio}[1]{\def\@auspicio{#1}}
\let\auspicio\setauspicio
\let\setauspicio\relax

\global\def\@anho{\the\year{}}
\newcommand{\setanho}[1]{\def\@anho{#1}}
\let\anho\setanho
\let\setanho\relax

%% Funcion Portada
\renewcommand{\maketitle}{
	\begin{titlepage}
		\begin{center}
		    \includegraphics[scale=1]{Logos/Logo_UNAB.png}
		\end{center}
		\begin{center}
            \MakeUppercase\@universidad\\\MakeUppercase\@facultad\\\MakeUppercase\@doctorado
		\end{center}

		\vspace{1cm}
		\centering
			\MakeUppercase\@title

		\vspace{1.5cm}
		\if\@tesis\@empty\else
			TESIS ENTREGADA PARA OPTAR AL GRADO DE\\\MakeUppercase\@tesis
            \if\@cotutela\@empty\else
				\\\bigskip EN COTUTELA CON \MakeUppercase\@cotutela
			\fi
		\fi


		\vspace{1cm}
			\MakeUppercase\@author

		\vspace{2cm}
			\foreach \x [count=\xi] in \@tutor {
				DIRECTOR DE TESIS \ifnum\xi>1 \ \xi \fi\\ \MakeUppercase\x\\
			}

		\vspace{1cm}
			\foreach \x [count=\xi] in \@cotutor {
				CO-DIRECTOR DE TESIS\ifnum\xi>1 \ \xi \fi\\ \MakeUppercase\x\\
			}

		\vspace{1cm}
		\if\@comision\@empty\else
			MIEMBROS DE LA COMISIÓN:\\
			\foreach \x in \@comision { \MakeUppercase\x\\ }
        \fi
        
		\if\@auspicio\@empty\else
		\vfill
			\normalfont
			Este trabajo ha sido parcialmente financiado por \@auspicio
		\fi

		\vfill
			\MakeUppercase\@lugar\\ \MakeUppercase\@anho
	\end{titlepage}
	
	%% Configuración de hyperref
	%%  (... tenemos en título, autor, etc., acá)
	\hypersetup{
		pdfauthor = {\@author},
		pdftitle = {\@title}
	}
}

%%Estilo del frontmatter
\newcommand{\ps@front}{
	\renewcommand{\thepage}{\Roman{page}}
	\renewcommand{\@oddhead}{}
	\renewcommand{\@evenhead}{}
	\renewcommand{\@oddfoot}{\hfill\thepage\hfill}
	\renewcommand{\@evenfoot}{\hfill\thepage\hfill}
}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{
	\pagestyle{front}
	\oldfrontmatter
}
\let\oldfrontmatter\relax

%% Evitar problemas con tildes
\RequirePackage{etoolbox}
\makeatletter
\appto{\appendices}{\def\Hy@chapapp{Appendix}}
\makeatother

%% Miscelaneos
\newcommand{\A}{\mathcal{A}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\D}{\mathbb{D}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\G}{\mathcal{G}}
\renewcommand{\H}{\mathcal{H}}
\newcommand{\K}{\mathcal{K}}
\renewcommand{\L}{\mathcal{L}}
\newcommand{\M}{\mathcal{M}}
\newcommand{\N}{\mathbb{N}}
\renewcommand{\M}{\mathcal{M}}
\renewcommand{\P}{\mathbb{P}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\renewcommand{\S}{\mathcal{S}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\1}{\mathbf{1}}
\let\epsilon\varepsilon
