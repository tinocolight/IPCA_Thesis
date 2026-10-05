%% UPCAThesis.cls
%% Modelo LaTeX para Dissertações, Projetos, Relatórios de Estágio e Teses da
%% Universidade Politécnica do Cávado e do Ave (UPCA), antigo IPCA.
%%
%% Os valores de formatação (margens, letras, títulos, capa, ...) estão em
%% Configuracao/Regras.tex. Este ficheiro só os aplica: não é necessário editá-lo.
\NeedsTeXFormat{LaTeX2e}[2022/06/01]
\ProvidesClass{UPCAThesis}[2026/10/05 v2.0 Modelo de trabalhos finais UPCA/IPCA]

%% ============================================================== Opções
%% Em cada grupo vale a opção declarada mais abaixo (ordem de \ProcessOptions).
\newcommand*\upca@tipo{dissertacao}
\DeclareOption{dissertacao}{\renewcommand*\upca@tipo{dissertacao}}
\DeclareOption{projeto}{\renewcommand*\upca@tipo{projeto}}
\DeclareOption{estagio}{\renewcommand*\upca@tipo{estagio}}
\DeclareOption{tese}{\renewcommand*\upca@tipo{tese}}
\newif\ifupca@en
\DeclareOption{pt}{\upca@enfalse}
\DeclareOption{en}{\upca@entrue}
\newif\ifupca@ipca
\DeclareOption{upca}{\upca@ipcafalse}
\DeclareOption{ipca}{\upca@ipcatrue}
\newif\ifupca@final
\DeclareOption{provas}{\upca@finalfalse}
\DeclareOption{versaofinal}{\upca@finaltrue}
\newif\ifupca@ieee
\DeclareOption{apa}{\upca@ieeefalse}
\DeclareOption{ieee}{\upca@ieeetrue}
\newif\ifupca@oneside
\DeclareOption{twoside}{\upca@onesidefalse}
\DeclareOption{oneside}{\upca@onesidetrue}
\newif\ifupca@integridade
\DeclareOption{integridade}{\upca@integridadetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%% ============================================================== Regras
%% Valores por omissão = modelo Word oficial (2018). São substituídos pelos de
%% Configuracao/Regras.tex, através de \regrasUPCA{chave = valor, ...}.
\ExplSyntaxOn
\prop_new:N \g__upca_regras_prop
\prop_gset_from_keyval:Nn \g__upca_regras_prop
  {
    pagina/margem-topo = 3.5cm, pagina/margem-baixo = 3.5cm,
    pagina/margem-interior = 3cm, pagina/margem-exterior = 2.5cm,
    pagina/declaracao-impar = false,
    texto/tamanho = 10, texto/entrelinha = 1.5, texto/indentacao = 0.6cm,
    texto/indentar-primeiro = true, texto/espaco-paragrafos = 0pt,
    texto/alinhamento = justificado,
    titulos/fonte = sans,
    titulo1/tamanho = 12, titulo1/negrito = true, titulo1/italico = false,
    titulo1/maiusculas = true, titulo1/antes = 0pt, titulo1/depois = 18pt,
    titulo2/tamanho = 10, titulo2/negrito = true, titulo2/italico = false,
    titulo2/maiusculas = true, titulo2/antes = 14pt, titulo2/depois = 6pt,
    titulo3/tamanho = 10, titulo3/negrito = false, titulo3/italico = false,
    titulo3/maiusculas = true, titulo3/antes = 12pt, titulo3/depois = 6pt,
    titulo4/tamanho = 10, titulo4/negrito = true, titulo4/italico = false,
    titulo4/maiusculas = false, titulo4/antes = 12pt, titulo4/depois = 6pt,
    titulo5/tamanho = 10, titulo5/negrito = false, titulo5/italico = true,
    titulo5/maiusculas = false, titulo5/antes = 10pt, titulo5/depois = 6pt,
    indice/margens-laterais = 4.25cm, indice/tamanho-capitulos = 9,
    indice/tamanho = 8, indice/pontos = true,
    legendas/tamanho = 8, legendas/negrito = true, legendas/separador = endash,
    citacoes/recuo = 1.5cm, citacoes/italico = true,
    cabecalho/conteudo = nenhum, cabecalho/distancia = 1.25cm,
    cabecalho/tamanho = 8, cabecalho/negrito = true, cabecalho/linha = false,
    rodape/numero = centro, rodape/distancia = 1.25cm, rodape/tamanho = 10,
    capa/faixa = cor, capa/faixa-cor = 00C83C, capa/faixa-altura = 6.28cm,
    capa/faixa-imagem = , capa/logo = Imagens/Institucional/upca-logo-branco,
    capa/logo-altura = 2.2cm, capa/logo-esquerda = 3.25cm, capa/logo-topo = 2.4cm,
    rosto/faixa = nenhuma, rosto/faixa-cor = 00C83C, rosto/faixa-altura = 6.28cm,
    rosto/faixa-imagem = , rosto/logo = Imagens/Institucional/upca-logo,
    rosto/logo-altura = 2.2cm, rosto/logo-esquerda = 3.25cm, rosto/logo-topo = 2.4cm,
    capa/texto-esquerda = 6.5cm, capa/texto-topo = 11.5cm,
    capa/texto-largura = 11.25cm, capa/tamanho-titulo = 14,
    capa/tamanho-nomes = 12, capa/tamanho-texto = 9,
    instituicao/nome = Universidade~Politécnica~do~Cávado~e~do~Ave,
    instituicao/artigo-a = à, instituicao/artigo-de = da,
    fontes/texto = Times~New~Roman, fontes/titulos = Arial,
    fontes/capa = Lucida~Sans~Unicode,
  }
\NewDocumentCommand \regrasUPCA { m }
  { \keyval_parse:NNn \__upca_regra:n \__upca_regra:nn {#1} }
\cs_new_protected:Npn \__upca_regra:n #1 { \__upca_regra:nn {#1} { } }
\cs_new_protected:Npn \__upca_regra:nn #1#2
  {
    \prop_if_in:NnTF \g__upca_regras_prop {#1}
      { \prop_gput:Nnn \g__upca_regras_prop {#1} {#2} }
      { \ClassWarningNoLine { UPCAThesis } { Regra~desconhecida~ignorada:~#1 } }
  }
% \upca@r{chave} devolve o valor; \upca@se{chave}{sim}{não} testa "true";
% \upca@seigual{chave}{valor}{sim}{não}; \upca@sevazio{chave}{sim}{não}.
\cs_new:Npn \upca@r #1 { \prop_item:Nn \g__upca_regras_prop {#1} }
\cs_new:Npn \upca@se #1 { \str_if_eq:eeTF { \upca@r {#1} } { true } }
\cs_new:Npn \upca@seigual #1#2 { \str_if_eq:eeTF { \upca@r {#1} } {#2} }
\cs_new:Npn \upca@sevazio #1 { \tl_if_blank:eTF { \upca@r {#1} } }
\ExplSyntaxOff

\InputIfFileExists{Configuracao/Regras.tex}{}
  {\ClassWarningNoLine{UPCAThesis}{Configuracao/Regras.tex não encontrado:
   usam-se as regras do modelo oficial de 2018}}
% Opção "ipca": designação e faixas do modelo oficial de 2018.
\ifupca@ipca
  \regrasUPCA{instituicao/nome = Instituto Politécnico do Cávado e do Ave,
    instituicao/artigo-a = ao, instituicao/artigo-de = do,
    capa/faixa = imagem, capa/faixa-imagem = Imagens/Institucional/ipca-capa.png,
    capa/logo = , rosto/faixa = imagem,
    rosto/faixa-imagem = Imagens/Institucional/ipca-rosto.png, rosto/logo = }
\fi

\edef\upca@tamanho{\upca@r{texto/tamanho}}
\ifupca@oneside
  \LoadClass[a4paper,\upca@tamanho pt,oneside,openany]{report}
\else
  \LoadClass[a4paper,\upca@tamanho pt,twoside,openright]{report}
\fi

%% ============================================================== Tipos de letra
%% pdfLaTeX (Overleaf): clones livres de Times e de Arial (também na capa).
%% XeLaTeX/LuaLaTeX: as fontes indicadas nas regras, se estiverem instaladas.
\RequirePackage{iftex}
\RequirePackage{etoolbox}
\RequirePackage{amsmath}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  % Times (texto) e TeX Gyre Heros (títulos) à escala real, como Times/Arial no Word.
  \RequirePackage[helvratio=1]{newtxtext}
  \RequirePackage{newtxmath}
  \newcommand*\upca@capafont{\sffamily}
\else
  \RequirePackage{unicode-math}
  \edef\upca@f{\upca@r{fontes/texto}}
  \expandafter\IfFontExistsTF\expandafter{\upca@f}
    {\setmainfont{\upca@f}}{\setmainfont{TeX Gyre Termes}}
  \edef\upca@f{\upca@r{fontes/titulos}}
  \expandafter\IfFontExistsTF\expandafter{\upca@f}
    {\setsansfont{\upca@f}}{\setsansfont{TeX Gyre Heros}}
  \IfFontExistsTF{TeX Gyre Termes Math}{\setmathfont{TeX Gyre Termes Math}}{}
  \edef\upca@f{\upca@r{fontes/capa}}
  \expandafter\IfFontExistsTF\expandafter{\upca@f}
    {\newfontfamily\upca@capafamily{\upca@f}}
    {\newfontfamily\upca@capafamily{TeX Gyre Heros}}
  \newcommand*\upca@capafont{\upca@capafamily}
\fi
% Os símbolos do amssymb já vêm com o tipo de letra matemático: evita erros
% se o utilizador fizer \usepackage{amssymb}.
\@namedef{ver@amssymb.sty}{}
\@namedef{ver@amsfonts.sty}{}
% \upca@tam{12} = letra de 12 pt com entrelinha simples (compensa o \setstretch
% do texto sem o alterar, para não afetar os parágrafos seguintes).
\newcommand*\upca@tam[1]{\fontsize{#1}{\fpeval{1.2*(#1)/\baselinestretch}}\selectfont}

%% ============================================================== Língua
\ifupca@en
  \RequirePackage[portuguese,main=english,shorthands=off]{babel}
\else
  \RequirePackage[english,main=portuguese,shorthands=off]{babel}
\fi
\RequirePackage[autostyle]{csquotes}

%% ============================================================== Página
\RequirePackage{geometry}
\geometry{a4paper,
  top=\upca@r{pagina/margem-topo}, bottom=\upca@r{pagina/margem-baixo},
  inner=\upca@r{pagina/margem-interior}, outer=\upca@r{pagina/margem-exterior},
  headheight=14pt,
  headsep=\dimexpr\upca@r{pagina/margem-topo}-\upca@r{cabecalho/distancia}-14pt\relax,
  footskip=\dimexpr\upca@r{pagina/margem-baixo}-\upca@r{rodape/distancia}-0.1cm\relax}
\RequirePackage{setspace}
\RequirePackage{ragged2e}
\RequirePackage{microtype}
\setlength\parindent{\upca@r{texto/indentacao}}
\setlength\parskip{\upca@r{texto/espaco-paragrafos}}
\AtBeginDocument{%
  % Entrelinha "como no Word": a linha simples do Word é 1,15 x o tamanho da letra.
  \setstretch{\fpeval{\upca@r{texto/entrelinha}*1.15*\f@size/\strip@pt\dimexpr\f@baselineskip\relax}}%
  \upca@seigual{texto/alinhamento}{esquerda}{\RaggedRight}{}}
\clubpenalty=5000
\widowpenalty=5000

\RequirePackage{graphicx}
\graphicspath{{Imagens/}}
\RequirePackage{xcolor}
\RequirePackage{eso-pic}

%% ============================================================== Cabeçalho e rodapé
\newcommand*\upca@numero{{\upca@capafont\upca@tam{\upca@r{rodape/tamanho}}\thepage}}
\newcommand*\upca@rodapeimpar{%
  \upca@seigual{rodape/numero}{centro}{\hfil\upca@numero\hfil}
    {\upca@seigual{rodape/numero}{exterior}{\hfil\upca@numero}{}}}
\newcommand*\upca@rodapepar{%
  \upca@seigual{rodape/numero}{centro}{\hfil\upca@numero\hfil}
    {\upca@seigual{rodape/numero}{exterior}{\upca@numero\hfil}{}}}
\newcommand*\upca@cabecalho{%
  \upca@seigual{cabecalho/conteudo}{capitulo}
    {\parbox[b]{\textwidth}{\centering\upca@capafont\upca@tam{\upca@r{cabecalho/tamanho}}%
       \upca@se{cabecalho/negrito}{\bfseries}{}\leftmark\strut
       \upca@se{cabecalho/linha}{\par\vspace{2pt}\hrule}{}}}{}}
\renewcommand*\ps@plain{%
  \let\@mkboth\@gobbletwo
  \renewcommand*\@oddhead{}\renewcommand*\@evenhead{}%
  \renewcommand*\@oddfoot{\upca@rodapeimpar}\renewcommand*\@evenfoot{\upca@rodapepar}}
\newcommand*\ps@upca{%
  \let\@mkboth\markboth
  \renewcommand*\@oddhead{\upca@cabecalho}\renewcommand*\@evenhead{\upca@cabecalho}%
  \renewcommand*\@oddfoot{\upca@rodapeimpar}\renewcommand*\@evenfoot{\upca@rodapepar}}
\renewcommand*\chaptermark[1]{\markboth{\MakeUppercase{#1}}{}}
\pagestyle{upca}
% Páginas em branco (antes de um capítulo em página ímpar): só o número.
\renewcommand*\cleardoublepage{\clearpage\if@twoside\ifodd\c@page\else
  \hbox{}\thispagestyle{plain}\newpage\fi\fi}

%% ============================================================== Títulos
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\newcommand*\upca@hfont{\normalfont
  \upca@seigual{titulos/fonte}{serif}{\rmfamily}{\sffamily}}
% Estilo e maiúsculas do título de nível #1 (1 = capítulo ... 5 = \paragraph).
\newcommand*\upca@estilo[1]{\upca@hfont
  \upca@se{titulo#1/negrito}{\bfseries}{}\upca@se{titulo#1/italico}{\itshape}{}%
  \upca@tam{\upca@r{titulo#1/tamanho}}}
\newcommand*\upca@maiusc[1]{\upca@se{titulo#1/maiusculas}{\MakeUppercase}{\@firstofone}}
\newcommand*\upca@chaplabel{\makebox[0.75cm][l]{\thechapter.}}
\titleformat{\chapter}[hang]{\upca@estilo1}{\upca@chaplabel}{0pt}{\upca@maiusc1}
\titleformat{name=\chapter,numberless}[hang]{\upca@estilo1}{}{0pt}{\upca@maiusc1}
\titleformat{\section}{\upca@estilo2}{\thesection}{0.6em}{\upca@maiusc2}
\titleformat{\subsection}{\upca@estilo3}{\thesubsection}{0.6em}{\upca@maiusc3}
\titleformat{\subsubsection}{\upca@estilo4}{\thesubsubsection}{0.6em}{\upca@maiusc4}
\titleformat{\paragraph}[block]{\upca@estilo5}{\theparagraph}{0.6em}{\upca@maiusc5}
% Espaço antes/depois; o asterisco do titlesec tira a indentação do 1.º parágrafo.
\newcommand*\upca@espaco[2]{%
  \upca@se{texto/indentar-primeiro}
    {\titlespacing{#1}{0pt}{\upca@r{titulo#2/antes} plus 3pt minus 2pt}{\upca@r{titulo#2/depois}}}
    {\titlespacing*{#1}{0pt}{\upca@r{titulo#2/antes} plus 3pt minus 2pt}{\upca@r{titulo#2/depois}}}}
\upca@espaco{\chapter}{1}
\upca@espaco{\section}{2}
\upca@espaco{\subsection}{3}
\upca@espaco{\subsubsection}{4}
\upca@espaco{\paragraph}{5}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}

% \chapter*{...} (Introdução, Conclusões, ...) entra no índice e as suas
% secções ficam sem número, tal como no modelo oficial.
\let\upca@chapter\chapter
\RenewDocumentCommand\chapter{s o m}{%
  \IfBooleanTF{#1}
    {\upca@novapagina
     \phantomsection\addcontentsline{toc}{chapter}{#3}%
     \upca@chapter*{#3}\markboth{\MakeUppercase{#3}}{}%
     \setcounter{secnumdepth}{-1}}%
    {\setcounter{secnumdepth}{4}%
     \IfNoValueTF{#2}{\upca@chapter{#3}}{\upca@chapter[#2]{#3}}}}
\newcommand*\upca@novapagina{\if@openright\cleardoublepage\else\clearpage\fi}

% Figuras, tabelas e equações num capítulo sem número ficam "1", "2", ...
\renewcommand*\thefigure{\ifnum\c@chapter>\z@\thechapter.\fi\arabic{figure}}
\renewcommand*\thetable{\ifnum\c@chapter>\z@\thechapter.\fi\arabic{table}}
\renewcommand*\theequation{\ifnum\c@chapter>\z@\thechapter.\fi\arabic{equation}}

%% ============================================================== Índices
\contentsmargin{2.5em}
\newcommand*\upca@tocfill{%
  \upca@se{indice/pontos}{\titlerule*[0.45em]{.}}{\hfill}\contentspage}
\newcommand*\upca@tocchaplabel{\thecontentslabel.\enspace}
\newcommand*\upca@toc[1]{\upca@hfont\upca@tam{\upca@r{indice/tamanho#1}}%
  \setlength\baselineskip{1.45\baselineskip}}
\titlecontents{chapter}[0pt]{\addvspace{4pt}\upca@toc{-capitulos}}
  {\upca@tocchaplabel\MakeUppercase}{\MakeUppercase}{\upca@tocfill}
\titlecontents{section}[0pt]{\upca@toc{}\bfseries}
  {\thecontentslabel\enspace\MakeUppercase}{\MakeUppercase}{\upca@tocfill}
\titlecontents{subsection}[0.3cm]{\upca@toc{}}
  {\thecontentslabel\enspace\MakeUppercase}{\MakeUppercase}{\upca@tocfill}
\titlecontents{subsubsection}[0.6cm]{\upca@toc{}\bfseries}
  {\thecontentslabel\enspace}{}{\upca@tocfill}
\titlecontents{paragraph}[1.2cm]{\upca@toc{}\itshape}
  {\thecontentslabel\enspace}{}{\upca@tocfill}
\titlecontents{figure}[0pt]{\upca@toc{}}
  {\figurename~\thecontentslabel\ -- }{}{\upca@tocfill}
\titlecontents{table}[0pt]{\upca@toc{}}
  {\tablename~\thecontentslabel\ -- }{}{\upca@tocfill}

%% ============================================================== Legendas e objetos
\RequirePackage{caption}
\DeclareCaptionFont{upca}{\upca@hfont\upca@tam{\upca@r{legendas/tamanho}}%
  \upca@se{legendas/negrito}{\bfseries}{}}
\edef\upca@sep{\upca@r{legendas/separador}}
\captionsetup{font=upca,labelsep=\upca@sep,justification=centering,skip=6pt}
\captionsetup[table]{position=top}
% Fonte de uma figura/tabela (estilo "Nota" do modelo oficial).
\NewDocumentCommand\fonte{m}{%
  \par\vspace{3pt}{\centering\upca@hfont\upca@tam{\upca@r{legendas/tamanho}}%
   \upca@fontename: #1\par}}

% Citações longas (environment quote ou citacao).
\renewenvironment{quote}
  {\list{}{\leftmargin\upca@r{citacoes/recuo}\rightmargin\leftmargin\topsep6pt}%
   \item\relax\upca@se{citacoes/italico}{\itshape}{}}
  {\endlist}
\newenvironment{citacao}{\quote}{\endquote}

\RequirePackage{float}
\RequirePackage{booktabs,tabularx,multirow,longtable}
\RequirePackage{enumitem}
\setlist{itemsep=0pt,topsep=4pt}
\RequirePackage{listings}
\lstset{basicstyle=\ttfamily\footnotesize\setstretch{1},columns=fullflexible,
  keepspaces,breaklines,frame=tb,numbers=left,numberstyle=\tiny,xleftmargin=1.5em,captionpos=t,
  showstringspaces=false,tabsize=2,upquote=true,
  literate={á}{{\'a}}1 {à}{{\`a}}1 {â}{{\^a}}1 {ã}{{\~a}}1 {é}{{\'e}}1
    {ê}{{\^e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ô}{{\^o}}1 {õ}{{\~o}}1 {ú}{{\'u}}1
    {ç}{{\c c}}1 {Á}{{\'A}}1 {À}{{\`A}}1 {Â}{{\^A}}1 {Ã}{{\~A}}1 {É}{{\'E}}1
    {Ê}{{\^E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ô}{{\^O}}1 {Õ}{{\~O}}1 {Ú}{{\'U}}1
    {Ç}{{\c C}}1 {º}{{\textordmasculine}}1 {ª}{{\textordfeminine}}1
    {€}{{\texteuro}}1}

\RequirePackage[figure,table]{totalcount}
\RequirePackage{pdfpages}

%% ============================================================== Referências
\ifupca@ieee
  \RequirePackage[backend=biber,style=ieee]{biblatex}
\else
  \RequirePackage[backend=biber,style=apa]{biblatex}
\fi
\defbibheading{upca}[\upca@refname]{\chapter*{#1}}

%% ============================================================== Ligações
\RequirePackage[hidelinks,bookmarksnumbered]{hyperref}
\RequirePackage{bookmark}

%% ============================================================== Siglas
%% Só aparecem na lista as siglas usadas no texto (\gls{...}), por ordem alfabética.
\RequirePackage[acronym,nomain,nonumberlist,nopostdot,nogroupskip,toc=false]{glossaries}
\makenoidxglossaries
\setacronymstyle{long-short}
\newglossarystyle{upca}{%
  \setglossarystyle{long}%
  \renewenvironment{theglossary}
    {\setlength\LTleft{0pt}\setlength\LTright{0pt}%
     \begin{longtable}{@{}l@{\quad--\quad}p{0.75\linewidth}@{}}}
    {\end{longtable}}%
  \renewcommand*\glossaryheader{}%
  \renewcommand*\glsgroupheading[1]{}%
  \renewcommand*\glsgroupskip{}%
  \renewcommand*\glossentry[2]{%
    \glsentryitem{##1}\glstarget{##1}{\glossentryname{##1}} &
    \glossentrydesc{##1}\tabularnewline}%
  \renewcommand*\subglossentry[3]{}}

%% ============================================================== Textos fixos
\newcommand*\upca@nomespt{%
  \renewcommand*\contentsname{Índice}%
  \renewcommand*\listfigurename{Índice de Figuras}%
  \renewcommand*\listtablename{Índice de Tabelas}%
  \renewcommand*\figurename{Figura}%
  \renewcommand*\tablename{Tabela}%
  \renewcommand*\upca@refname{Referências Bibliográficas}%
  \renewcommand*\upca@apoiosname{Apoios}%
  \renewcommand*\upca@agradecimentosname{Agradecimentos}%
  \renewcommand*\upca@dedicatorianame{Dedicatória}%
  \renewcommand*\upca@siglasname{Lista de Abreviaturas e Siglas}%
  \renewcommand*\upca@anexoname{Anexo}%
  \renewcommand*\upca@anexosname{Anexos}%
  \renewcommand*\upca@apendicename{Apêndice}%
  \renewcommand*\upca@apendicesname{Apêndices}%
  \renewcommand*\upca@fontename{Fonte}%
  \renewcommand*\lstlistingname{Listagem}%
  \def\chapterautorefname{Capítulo}%
  \def\sectionautorefname{Secção}%
  \def\subsectionautorefname{Secção}%
  \def\subsubsectionautorefname{Secção}%
  \def\figureautorefname{Figura}%
  \def\tableautorefname{Tabela}%
  \def\equationautorefname{Equação}%
  \def\lstlistingautorefname{Listagem}}
\newcommand*\upca@nomesen{%
  \renewcommand*\contentsname{Table of Contents}%
  \renewcommand*\listfigurename{List of Figures}%
  \renewcommand*\listtablename{List of Tables}%
  \renewcommand*\figurename{Figure}%
  \renewcommand*\tablename{Table}%
  \renewcommand*\upca@refname{References}%
  \renewcommand*\upca@apoiosname{Funding}%
  \renewcommand*\upca@agradecimentosname{Acknowledgements}%
  \renewcommand*\upca@dedicatorianame{Dedication}%
  \renewcommand*\upca@siglasname{List of Abbreviations and Acronyms}%
  \renewcommand*\upca@anexoname{Annex}%
  \renewcommand*\upca@anexosname{Annexes}%
  \renewcommand*\upca@apendicename{Appendix}%
  \renewcommand*\upca@apendicesname{Appendices}%
  \renewcommand*\upca@fontename{Source}%
  \renewcommand*\lstlistingname{Listing}%
  \def\chapterautorefname{Chapter}%
  \def\sectionautorefname{Section}%
  \def\subsectionautorefname{Section}%
  \def\subsubsectionautorefname{Section}%
  \def\figureautorefname{Figure}%
  \def\tableautorefname{Table}%
  \def\equationautorefname{Equation}%
  \def\lstlistingautorefname{Listing}}
\newcommand*\upca@refname{}
\newcommand*\upca@apoiosname{}
\newcommand*\upca@agradecimentosname{}
\newcommand*\upca@dedicatorianame{}
\newcommand*\upca@siglasname{}
\newcommand*\upca@anexoname{}
\newcommand*\upca@anexosname{}
\newcommand*\upca@apendicename{}
\newcommand*\upca@apendicesname{}
\newcommand*\upca@fontename{}
% Os títulos seguem a língua principal do trabalho.
\ifupca@en
  \addto\captionsenglish{\upca@nomesen}\addto\captionsportuguese{\upca@nomesen}
\else
  \addto\captionsportuguese{\upca@nomespt}\addto\captionsenglish{\upca@nomespt}
\fi

\newcommand*\upca@instituicao{\upca@r{instituicao/nome}}
\newcommand*\upca@ainstituicao{\upca@r{instituicao/artigo-a} \upca@r{instituicao/nome}}
\newcommand*\upca@dainstituicao{\upca@r{instituicao/artigo-de} \upca@r{instituicao/nome}}

% Designação do trabalho, concordância, grau e ciclo de estudos.
\newcommand*\upca@settipo[6]{%
  \renewcommand*\upca@designacao{#1}\renewcommand*\upca@apresentado{#2}%
  \renewcommand*\upca@grau{#3}\renewcommand*\upca@ciclo{#4}%
  \renewcommand*\upca@dotrabalho{#5}\renewcommand*\upca@estudante{#6}}
\newcommand*\upca@designacao{}\newcommand*\upca@apresentado{}
\newcommand*\upca@grau{}\newcommand*\upca@ciclo{}
\newcommand*\upca@dotrabalho{}\newcommand*\upca@estudante{}
\ifdefstring\upca@tipo{dissertacao}{\upca@settipo{Dissertação}{apresentada}{Mestre}{Mestrado}{da Dissertação}{mestrando}}{}
\ifdefstring\upca@tipo{projeto}{\upca@settipo{Projeto}{apresentado}{Mestre}{Mestrado}{do Projeto}{mestrando}}{}
\ifdefstring\upca@tipo{estagio}{\upca@settipo{Relatório de Estágio}{apresentado}{Mestre}{Mestrado}{do Relatório de Estágio}{mestrando}}{}
\ifdefstring\upca@tipo{tese}{\upca@settipo{Tese}{apresentada}{Doutor}{Doutoramento}{da Tese}{doutorando}}{}

%% ============================================================== Dados do trabalho
\newcommand*\upca@titulo{}       \newcommand*\titulo[1]{\renewcommand*\upca@titulo{#1}}
\newcommand*\upca@subtitulo{}    \newcommand*\subtitulo[1]{\renewcommand*\upca@subtitulo{#1}}
\newcommand*\upca@tituloEN{}     \newcommand*\tituloEN[1]{\renewcommand*\upca@tituloEN{#1}}
\newcommand*\upca@subtituloEN{}  \newcommand*\subtituloEN[1]{\renewcommand*\upca@subtituloEN{#1}}
\newcommand*\upca@autor{}        \newcommand*\autor[1]{\renewcommand*\upca@autor{#1}}
\newcommand*\upca@email{}        \newcommand*\email[1]{\renewcommand*\upca@email{#1}}
\newcommand*\upca@curso{}        \newcommand*\curso[1]{\renewcommand*\upca@curso{#1}}
\newcommand*\upca@data{}         \newcommand*\data[1]{\renewcommand*\upca@data{#1}}
\newcommand*\upca@palavraschave{}\newcommand*\palavraschave[1]{\renewcommand*\upca@palavraschave{#1}}
\newcommand*\upca@keywords{}     \newcommand*\keywords[1]{\renewcommand*\upca@keywords{#1}}
\newcommand*\upca@reproducao{}   \newcommand*\reproducao[1]{\renewcommand*\upca@reproducao{#1}}
\newcommand*\upca@assinatura{}   \newcommand*\assinatura[1]{\renewcommand*\upca@assinatura{#1}}
\newcommand*\upca@declaracaopdf{}\newcommand*\declaracaoassinada[1]{\renewcommand*\upca@declaracaopdf{#1}}
% Título na língua do trabalho (capa, folha de rosto, declaração e PDF).
\newcommand*\upca@tituloP{}\newcommand*\upca@subtituloP{}
\AtBeginDocument{%
  \ifupca@en\let\upca@tituloP\upca@tituloEN\let\upca@subtituloP\upca@subtituloEN
  \else\let\upca@tituloP\upca@titulo\let\upca@subtituloP\upca@subtitulo\fi}
\newcommand*\upca@tituloPnome{\ifupca@en Title of the work\else Título do trabalho\fi}
\newcommand*\upca@datadeclaracao{\_\_\_/\_\_\_/\_\_\_\_\_\_}
\newcommand*\datadeclaracao[1]{\renewcommand*\upca@datadeclaracao{#1}}
\newcommand*\upca@orientadorlabel{}\newcommand*\upca@orientador{}
\newcommand*\orientador[2][Orientador]{%
  \renewcommand*\upca@orientadorlabel{#1}\renewcommand*\upca@orientador{#2}}
\newcommand*\upca@coorientadorlabel{}\newcommand*\upca@coorientador{}
\newcommand*\coorientador[2][Coorientador]{%
  \renewcommand*\upca@coorientadorlabel{#1}\renewcommand*\upca@coorientador{#2}}
\newcommand*\upca@entidadelabel{}\newcommand*\upca@entidade{}
\newcommand*\orientadorentidade[2][Orientador da entidade de acolhimento]{%
  \renewcommand*\upca@entidadelabel{#1}\renewcommand*\upca@entidade{#2}}
% Substitui "Projeto" por, p. ex., "Trabalho de Projeto" (concordância opcional).
\newcommand*\designacao[2][]{%
  \renewcommand*\upca@designacao{#2}%
  \ifblank{#1}{}{\renewcommand*\upca@apresentado{#1}}}
% Substitui por completo a frase "... apresentada à ... para obtenção do grau ..."
% (útil em cursos em associação com outras instituições).
\newcommand*\upca@textoapresentacao{}
\newcommand*\textoapresentacao[1]{\renewcommand*\upca@textoapresentacao{#1}}
\newcommand*\upca@notajuri{Este trabalho não inclui as críticas e sugestões feitas pelo Júri.}
\newcommand*\notajuri[1]{\renewcommand*\upca@notajuri{#1}}

% Campo obrigatório: se estiver vazio aparece a vermelho e é emitido um aviso.
\newcommand*\upca@campo[2]{%
  \expandafter\ifblank\expandafter{#1}
    {\textcolor{red}{[#2]}\ClassWarningNoLine{UPCAThesis}{Falta preencher: #2}}
    {#1}}
\newcommand\upca@seexiste[2]{\expandafter\ifblank\expandafter{#1}{}{#2}}

\newcommand*\upca@mes{\ifcase\month\or janeiro\or fevereiro\or março\or abril\or
  maio\or junho\or julho\or agosto\or setembro\or outubro\or novembro\or dezembro\fi}
\newcommand*\upca@datacapa{%
  \expandafter\ifblank\expandafter{\upca@data}{\upca@mes, \the\year}{\upca@data}}

%% ============================================================== Capa e folha de rosto
%% Faixa (cor ou imagem) e logótipo no topo; bloco de texto na posição das regras.
\newcommand\upca@fundo[1]{% #1 = capa | rosto
  \AtPageUpperLeft{%
    \upca@seigual{#1/faixa}{cor}
      {\put(0,\LenToUnit{-\upca@r{#1/faixa-altura}}){%
         \textcolor[HTML]{\upca@r{#1/faixa-cor}}{\rule{\paperwidth}{\upca@r{#1/faixa-altura}}}}}{}%
    \upca@seigual{#1/faixa}{imagem}
      {\put(0,0){\raisebox{-\height}{\includegraphics[width=\paperwidth]{\upca@r{#1/faixa-imagem}}}}}{}%
    \upca@sevazio{#1/logo}{}
      {\put(\LenToUnit{\upca@r{#1/logo-esquerda}},\LenToUnit{-\upca@r{#1/logo-topo}}){%
         \raisebox{-\height}{\includegraphics[height=\upca@r{#1/logo-altura}]{\upca@r{#1/logo}}}}}}}
\newcommand*\upca@tamcapa[2]{\fontsize{\upca@r{capa/tamanho-#1}}{#2}\selectfont}
\newcommand\upca@pessoa[2]{%
  {\upca@tamcapa{texto}{11pt}\itshape #1\par}%
  {\upca@tamcapa{nomes}{18pt}#2\par}}
\newcommand\upca@apresentacao{%
  \expandafter\ifblank\expandafter{\upca@textoapresentacao}
    {\upca@designacao\ \upca@apresentado\\\upca@ainstituicao\par
     para obtenção do Grau de \upca@grau\ em \upca@campo\upca@curso{Nome do curso}\par}
    {\upca@textoapresentacao\par}}
\newcommand\upca@blococapa{%
  \parbox[t]{\upca@r{capa/texto-largura}}{\raggedright\upca@capafont\setstretch{1}%
    {\upca@tamcapa{titulo}{18pt}\bfseries
     \MakeUppercase{\upca@campo{\upca@tituloP}{\upca@tituloPnome}}\par
     \mdseries\upca@seexiste{\upca@subtituloP}{\MakeUppercase{\upca@subtituloP}\par}}%
    \vspace{60pt}%
    {\upca@tamcapa{nomes}{18pt}\upca@campo\upca@autor{Nome completo do \upca@estudante}\par}%
    \upca@pessoa{\upca@orientadorlabel}{\upca@campo\upca@orientador{Nome do orientador}}%
    \upca@seexiste\upca@coorientador{\upca@pessoa{\upca@coorientadorlabel}{\upca@coorientador}}%
    \upca@seexiste\upca@entidade{\upca@pessoa{\upca@entidadelabel}{\upca@entidade}}%
    \vspace{11pt}%
    {\upca@tamcapa{texto}{11pt}\upca@apresentacao}%
    \ifupca@final\else
      \upca@seexiste\upca@notajuri{\vspace{11pt}{\upca@tamcapa{texto}{11pt}\itshape\upca@notajuri\par}}%
    \fi
    \vspace{22pt}%
    {\upca@tamcapa{nomes}{18pt}\upca@datacapa\par}}}
\newcommand\upca@paginacapa[1]{%
  \clearpage\thispagestyle{empty}%
  \AddToShipoutPictureBG*{\upca@fundo{#1}}%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{%
    \put(\LenToUnit{\upca@r{capa/texto-esquerda}},
         \LenToUnit{-\dimexpr\upca@r{capa/texto-topo}+0.5cm\relax}){\upca@blococapa}}}%
  \null\clearpage}
\newcommand\upca@paginavazia{\clearpage\if@twoside\thispagestyle{empty}\null\clearpage\fi}
\newcommand\upca@duplavazia{%
  \clearpage\if@twoside\ifodd\c@page\else\thispagestyle{empty}\null\clearpage\fi\fi}

%% ============================================================== Declarações
% Quadrado de escolha (desenhado, para funcionar com qualquer tipo de letra).
\newcommand*\upca@quadrado[1]{{\setlength\fboxsep{0pt}\setlength\fboxrule{0.5pt}%
  \fbox{\makebox[1.5ex]{\rule{0pt}{1.5ex}\raisebox{0.2ex}{\upca@hfont\scriptsize#1}}}}}
\newcommand*\upca@caixa[1]{%
  \ifdefstring\upca@reproducao{#1}{\upca@quadrado{X}}{\upca@quadrado{}}}
\newcommand\upca@titulodeclaracao[1]{%
  {\noindent\upca@capafont\setstretch{1}\upca@tamcapa{titulo}{18pt}\bfseries #1\par}\vspace{18pt}}
\newcommand\upca@declaracao{%
  \clearpage\thispagestyle{empty}%
  \begin{otherlanguage}{portuguese}%
  \upca@titulodeclaracao{DECLARAÇÃO}%
  {\noindent
   Nome: \upca@campo\upca@autor{Nome completo do \upca@estudante}\par\noindent
   \upca@seexiste\upca@email{Endereço eletrónico: \upca@email\par\noindent}%
   Título \upca@dotrabalho: \upca@campo{\upca@tituloP}{\upca@tituloPnome}\par\noindent
   \upca@seexiste{\upca@subtituloP}{Subtítulo \upca@dotrabalho: \upca@subtituloP\par\noindent}%
   \upca@orientadorlabel: \upca@campo\upca@orientador{Nome do orientador}\par\noindent
   \upca@seexiste\upca@coorientador{\upca@coorientadorlabel: \upca@coorientador\par\noindent}%
   \upca@seexiste\upca@entidade{\upca@entidadelabel: \upca@entidade\par\noindent}%
   Ano de conclusão: \upca@datacapa\par\noindent
   Designação do Curso de \upca@ciclo: \upca@ciclo\ em \upca@campo\upca@curso{Nome do curso}\par}%
  \vspace{12pt}%
  \noindent Nos exemplares das Dissertações /Projetos/ Relatórios de Estágio de
  mestrado ou de outros trabalhos entregues para prestação de Provas Públicas, e
  dos quais é obrigatoriamente enviado exemplares para depósito legal, deve constar
  uma das seguintes declarações:\par
  \begin{list}{}{\leftmargin1cm\labelwidth0.6cm\labelsep0.4cm\topsep9pt\itemsep6pt}
  \item[\upca@caixa{integral}] É AUTORIZADA A REPRODUÇÃO INTEGRAL DESTA
    DISSERTAÇÃO/TRABALHO APENAS PARA EFEITOS DE INVESTIGAÇÃO, MEDIANTE DECLARAÇÃO
    ESCRITA DO INTERESSADO, QUE A TAL SE COMPROMETE;
  \item[\upca@caixa{parcial}] É AUTORIZADA A REPRODUÇÃO PARCIAL DESTA
    DISSERTAÇÃO/TRABALHO (indicar, caso tal seja necessário, nº máximo de páginas,
    ilustrações, gráficos, etc.), APENAS PARA EFEITOS DE INVESTIGAÇÃO, MEDIANTE
    DECLARAÇÃO ESCRITA DO INTERESSADO, QUE A TAL SE COMPROMETE;
  \item[\upca@caixa{nenhuma}] DE ACORDO COM A LEGISLAÇÃO EM VIGOR, NÃO É
    PERMITIDA A REPRODUÇÃO DE QUALQUER PARTE DESTA DISSERTAÇÃO/TRABALHO
  \end{list}
  \vspace{6pt}%
  \noindent\upca@instituicao, \upca@datadeclaracao\par
  \vspace{18pt}%
  \upca@linhaassinatura
  \end{otherlanguage}}
\newcommand\upca@linhaassinatura{%
  \noindent Assinatura: \expandafter\ifblank\expandafter{\upca@assinatura}
    {\rule{9cm}{0.4pt}}
    {\raisebox{-0.25\height}{\includegraphics[height=1.4cm]{\upca@assinatura}}}\par}
% Opção "integridade": declaração de autoria (art. 14.º, n.º 1, do regulamento).
\newcommand\upca@integridade{%
  \clearpage\thispagestyle{empty}%
  \begin{otherlanguage}{portuguese}%
  \upca@titulodeclaracao{DECLARAÇÃO DE INTEGRIDADE}%
  Declaro, sob compromisso de honra, que o presente trabalho é da minha exclusiva
  autoria e que a utilização de quaisquer contribuições ou textos de terceiros se
  encontra devidamente referenciada, nos termos do Código de Ética, Conduta e
  Integridade \upca@dainstituicao.\par
  \vspace{12pt}%
  \noindent\upca@instituicao, \upca@datadeclaracao\par
  \vspace{18pt}%
  \upca@linhaassinatura
  \end{otherlanguage}}

%% ============================================================== Comandos de estrutura
% Capa, página em branco, folha de rosto e declaração(ões).
\newcommand\paginasiniciais{%
  \pagenumbering{alph}%
  \upca@paginacapa{capa}%
  \upca@paginavazia
  \upca@paginacapa{rosto}%
  \upca@se{pagina/declaracao-impar}{\upca@paginavazia}{}%
  % Declaração(ões) geradas, ou o PDF assinado indicado em \declaracaoassinada.
  \expandafter\ifblank\expandafter{\upca@declaracaopdf}
    {\upca@declaracao\ifupca@integridade\upca@integridade\fi}
    {\clearpage\includepdf[pages=-,pagecommand={\thispagestyle{empty}}]{\upca@declaracaopdf}}
  \upca@duplavazia
  \pagenumbering{Roman}}

\newcommand\upca@tituloinicial[1]{%
  {\noindent\upca@estilo1\upca@maiusc1{#1}\par}\vspace{\upca@r{titulo1/depois}}}
\newcommand\upca@entradainicial[1]{%
  \upca@novapagina\phantomsection\addcontentsline{toc}{chapter}{#1}\markboth{}{}}
\newcommand\upca@blocotitulo[2]{%
  {\noindent\raggedright\upca@capafont\setstretch{1}\upca@tamcapa{titulo}{18pt}%
   \bfseries\MakeUppercase{#1}\par
   \mdseries\upca@seexiste{#2}{\MakeUppercase{#2}\par}}%
  \vspace{18pt}}
\newcommand\upca@palavras[2]{%
  \par\vspace{12pt}\textbf{#1:} \upca@campo{#2}{#1}\par}

\newenvironment{apoios}
  {\upca@entradainicial{\upca@apoiosname}\upca@tituloinicial{\upca@apoiosname}}{}
\newenvironment{agradecimentos}
  {\upca@entradainicial{\upca@agradecimentosname}\upca@tituloinicial{\upca@agradecimentosname}}{}
\newenvironment{dedicatoria}
  {\upca@entradainicial{\upca@dedicatorianame}\vspace*{0.3\textheight}%
   \begin{flushright}\itshape}
  {\end{flushright}}
\NewDocumentEnvironment{resumo}{+b}
  {\upca@entradainicial{Resumo}%
   \upca@blocotitulo{\upca@campo\upca@titulo{Título do trabalho}}{\upca@subtitulo}%
   \upca@tituloinicial{Resumo}%
   \begin{otherlanguage}{portuguese}#1%
     \upca@palavras{Palavras-chave}{\upca@palavraschave}\end{otherlanguage}%
   \upca@contapalavras{#1}{Resumo}}{}
\RenewDocumentEnvironment{abstract}{+b}
  {\upca@entradainicial{Abstract}%
   \upca@blocotitulo{\upca@campo\upca@tituloEN{Title of the work}}{\upca@subtituloEN}%
   \upca@tituloinicial{Abstract}%
   \begin{otherlanguage}{english}#1%
     \upca@palavras{Keywords}{\upca@keywords}\end{otherlanguage}%
   \upca@contapalavras{#1}{Abstract}}{}

% Lista de siglas (se houver), índice geral, de figuras e de tabelas (se houver).
% A seguir começa a numeração árabe do corpo do trabalho.
\newcommand\indices{%
  \printnoidxglossary[type=\acronymtype,style=upca,sort=word,title=\upca@siglasname]%
  \upca@novapagina
  \newgeometry{top=\upca@r{pagina/margem-topo},bottom=\upca@r{pagina/margem-baixo},
    inner=\upca@r{indice/margens-laterais},outer=\upca@r{indice/margens-laterais},
    headheight=14pt,
    headsep=\dimexpr\upca@r{pagina/margem-topo}-\upca@r{cabecalho/distancia}-14pt\relax,
    footskip=\dimexpr\upca@r{pagina/margem-baixo}-\upca@r{rodape/distancia}-0.1cm\relax}%
  \normalsize
  \tableofcontents
  \iftotalfigures\listoffigures\fi
  \iftotaltables\listoftables\fi
  \upca@novapagina
  \restoregeometry\normalsize % o geometry repõe a entrelinha guardada no início
  \pagenumbering{arabic}}

\newcommand\referencias{\printbibliography[heading=upca,title=\upca@refname]}

% Anexos (\anexos) e apêndices (\apendices): cada \chapter{...} seguinte
% passa a "ANEXO A – ...", "ANEXO B – ...".
\newcommand*\upca@tocanexo[1]{%
  \renewcommand*\upca@tocchaplabel{\MakeUppercase{#1}~\thecontentslabel\ -- }}
\newcommand\upca@iniciaranexos[3]{% #3 = prefixo das ligações internas
  \upca@novapagina
  \phantomsection\addcontentsline{toc}{chapter}{#2}%
  \addtocontents{toc}{\protect\upca@tocanexo{#1}}%
  \setcounter{chapter}{0}%
  \renewcommand*\thechapter{\Alph{chapter}}%
  \renewcommand*\theHchapter{#3.\Alph{chapter}}%
  \renewcommand*\upca@chaplabel{\MakeUppercase{#1}~\thechapter\ -- }%
  \def\chapterautorefname{#1}}
% \anexopdf[páginas]{Título}{ficheiro.pdf}: anexo que já existe em PDF (p. ex.
% protocolo de estágio). Entra no índice como "ANEXO B – Título" e as páginas
% são reduzidas para deixar visível o número de página.
\NewDocumentCommand\anexopdf{O{-} m m}{%
  \upca@novapagina
  \setcounter{secnumdepth}{4}%
  \refstepcounter{chapter}%
  \includepdf[pages={#1},scale=0.88,pagecommand={\thispagestyle{plain}},
    addtotoc={1,chapter,0,{\protect\numberline{\thechapter}#2},upca:anexopdf:\theHchapter}]{#3}}
\newcommand\anexos{\upca@iniciaranexos{\upca@anexoname}{\upca@anexosname}{anexo}}
\newcommand\apendices{\upca@iniciaranexos{\upca@apendicename}{\upca@apendicesname}{apendice}}

%% ============================================================== Verificações
%% Avisos (não erros) quando o resumo ou as palavras-chave fogem ao modelo.
\ExplSyntaxOn
\seq_new:N \l__upca_palavras_seq
\clist_new:N \l__upca_chave_clist
\cs_new_protected:Npn \upca@contapalavras #1#2
  {
    \str_if_eq:VnF \upca@tipo { tese }
      {
        \seq_set_split:Nnn \l__upca_palavras_seq { ~ } {#1}
        \seq_remove_all:Nn \l__upca_palavras_seq { }
        \int_set:Nn \l_tmpa_int { \seq_count:N \l__upca_palavras_seq }
        \bool_lazy_or:nnT
          { \int_compare_p:nNn \l_tmpa_int < { 200 } }
          { \int_compare_p:nNn \l_tmpa_int > { 300 } }
          {
            \ClassWarningNoLine { UPCAThesis }
              { #2~com~cerca~de~\int_use:N \l_tmpa_int\space palavras~
                (o~modelo~pede~200~a~300) }
          }
      }
  }
\cs_new_protected:Npn \__upca_verifica_chave:Nn #1#2
  {
    \exp_args:NNo \clist_set:Nn \l__upca_chave_clist {#1}
    \int_compare:nNnT { \clist_count:N \l__upca_chave_clist } > { 5 }
      { \ClassWarningNoLine { UPCAThesis } { #2:~mais~de~5~(máximo~do~modelo) } }
  }
\AtBeginDocument
  {
    \__upca_verifica_chave:Nn \upca@palavraschave { Palavras-chave }
    \__upca_verifica_chave:Nn \upca@keywords { Keywords }
  }
\ExplSyntaxOff

\AtBeginDocument{%
  \hypersetup{pdftitle={\upca@tituloP},pdfauthor={\upca@autor},
    pdfsubject={\upca@designacao},pdfkeywords={\upca@palavraschave}}}

\endinput
