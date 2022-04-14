


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IPCAThesis}[2022-04-03 v1.0 IPCA Dissertation document class]
\def\extbase@baseclass{report}

%\DeclareOption{myoption}{\typeout{This is a nice option}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
%\LoadClass[a4paper]{report}
%\documentclass[a4paper]{report}

\LoadClass{\extbase@baseclass}
