# Modelo LaTeX UPCA (antigo IPCA)

Modelo para **Dissertação, Projeto, Relatório de Estágio e Tese de Doutoramento** da
Universidade Politécnica do Cávado e do Ave. É mantido por um antigo aluno e não é um
documento oficial: em caso de dúvida prevalecem as indicações dos Serviços Académicos.

## Em que se baseia

- **Modelo Word oficial dos Serviços Académicos (2018)**, que continua a ser o publicado
  na página de [entrega da dissertação](https://ipca.pt/sa/dissertacao-projeto-estagio/entrega-dissertacao-projeto-estagio/).
  Daí vêm as margens, os tipos de letra, os títulos, a capa e a declaração. Os modelos são
  comuns a todas as escolas.
- **Regulamento da UC de Dissertação/Projeto/Estágio** (Despacho n.º 2242/2026, DR, 2.ª série,
  n.º 36, de 20/02/2026): trabalho em português ou, com anuência do orientador, noutra língua
  (art. 7.º); um ou dois orientadores (art. 5.º); entrega só em suporte digital (art. 11.º);
  declaração de autoria (art. 14.º).
- Desde 3 de agosto de 2026 o IPCA é a **UPCA** (Lei n.º 32/2026). Ainda não há modelo novo,
  por isso a capa usa o logótipo UPCA na composição de 2018 (**provisório**). A opção `ipca`
  reproduz o modelo de 2018 tal como está.

## Começar

**Overleaf:** *New Project → Upload Project* com o ZIP deste repositório (*Code → Download ZIP*).
O compilador por omissão (pdfLaTeX) serve; o ficheiro principal é `MainThesis.tex`.
**No computador:** `latexmk -pdf MainThesis.tex` (TeX Live 2022 ou mais recente).

1. No `MainThesis.tex`, escolha as opções e preencha os dados (título, autor, orientadores, curso…).
2. Escreva o texto nos ficheiros de `Preambulo/`, `Capitulos/` e `Anexos/`.
3. Acrescente as referências em `Bibliografia/referencias.bib` (o Zotero e o Mendeley exportam neste formato).

Capa, folha de rosto, declaração, índices e listas são gerados a partir dos dados.
Um campo obrigatório por preencher aparece **a vermelho** no PDF.

## Opções

`\documentclass[dissertacao, pt, upca, provas, apa, twoside]{UPCAThesis}`

| Opção | Valores | Para quê |
|---|---|---|
| tipo | `dissertacao` · `projeto` · `estagio` · `tese` | designação, grau (Mestre/Doutor) e textos da capa e da declaração |
| língua | `pt` · `en` | títulos (Índice, Agradecimentos…) e hifenização; capa e declaração ficam em português |
| instituição | `upca` · `ipca` | designação e capa (`ipca` = modelo oficial de 2018) |
| versão | `provas` · `versaofinal` | a versão para defesa inclui a nota "não inclui as críticas e sugestões feitas pelo Júri" |
| referências | `apa` · `ieee` | APA 7.ª edição (exigida); IEEE só com autorização do orientador |
| impressão | `twoside` · `oneside` | frente e verso como o modelo oficial, ou sem páginas em branco |
| extra | `integridade` | acrescenta uma declaração de integridade (art. 14.º) |

## Comandos úteis

| Escreva | Resultado |
|---|---|
| `\textcite{chave}` · `\parencite{chave}` | Autor (2020) · (Autor, 2020) |
| `\gls{sigla}` | 1.ª vez por extenso; as siglas usadas vão para a lista (definição em `Preambulo/Siglas.tex`) |
| `\chapter*{Introdução}` | capítulo sem número, no índice (Introdução, Conclusões) |
| `\fonte{Elaboração própria.}` | linha "Fonte:" por baixo de figuras e tabelas |
| `\begin{citacao} … \end{citacao}` | citação longa (mais de 40 palavras) |
| `\autoref{fig:x}` | "Figura 2.1", com ligação |
| `\anexos` · `\apendices` | os capítulos seguintes passam a "ANEXO A – …" |
| `\orientador[Orientadora]{…}` | rótulo no feminino (também em `\coorientador`) |
| `\orientadorentidade{…}` | estágio: orientador na entidade de acolhimento |
| `\designacao{Trabalho de Projeto}` | substitui "Projeto" na capa |
| `\textoapresentacao{…}` | substitui a frase "… apresentada à … para obtenção do grau …" (cursos em associação) |
| `\reproducao{integral}` | assinala a opção na declaração (`integral`, `parcial`, `nenhuma`) |
| `\assinatura{ficheiro}` · `\datadeclaracao{dd/mm/aaaa}` | assinatura digitalizada e data na declaração |

As listas de siglas, de figuras e de tabelas só aparecem quando há conteúdo. O LaTeX avisa
(sem parar a compilação) se o resumo fugir às 200–300 palavras ou se houver mais de 5 palavras-chave.

## Antes de entregar

- Compile com a opção `provas` e entregue o PDF pela forma indicada pelos Serviços Académicos,
  com os ficheiros identificados com o número de estudante (p. ex. `99999_Dissertacao.pdf`).
- Para o depósito legal, depois da defesa, use `versaofinal` e incorpore as correções do júri.
- Assinale a opção de reprodução na declaração e assine-a.

## Estrutura

```
MainThesis.tex          opções, dados e ordem dos capítulos
UPCAThesis.cls          classe (não é preciso editar)
Configuracao/Regras.tex regras de formatação (não é preciso editar)
Preambulo/              apoios, resumo, abstract, agradecimentos, dedicatória, siglas
Capitulos/              introdução, capítulos e conclusões
Anexos/                 anexos ou apêndices
Bibliografia/           referencias.bib
Imagens/                figuras do trabalho (Institucional/ = logótipos e faixas)
Ferramentas/            EditorRegras.html (editor das regras)
```

## Manutenção do modelo

- **Regras de formatação** (margens, letras, títulos, espaçamentos, cabeçalho e rodapé, capa)
  estão todas em `Configuracao/Regras.tex`, no formato `chave = valor`. Para as alterar com
  pré-visualização, abra `Ferramentas/EditorRegras.html` no browser, ajuste e copie o resultado.
- **Novo modelo oficial UPCA:** atualize `Regras.tex` e coloque as novas imagens em
  `Imagens/Institucional/` (uma faixa em imagem usa `capa/faixa = imagem` e `capa/faixa-imagem = …`).
- **Overleaf:** carregue o ZIP do repositório num projeto novo ou substitua os ficheiros do
  projeto do template; depois volte a submeter o template na galeria.
- A cada alteração, o GitHub Actions compila quatro variantes e guarda os PDF.
