# Análise de RH — Visualização de Dados e Business Intelligence \[T3]

> Situação de Aprendizagem — Projeto Avaliativo · Módulo 1 · Semana 13

**Aluno:** Leonardo Schlichmann  
**Turma:** T3 · Visualização de Dados e Business Intelligence  
**Vídeo de apresentação:** *(cole aqui o link do seu vídeo — YouTube/Drive/Loom)*

> Este projeto (código e documentação) foi desenvolvido com o \*\*auxílio da
> OreateAI\*\*, usada como ferramenta de apoio à geração e organização do código,
> das consultas e deste README.

\---

## Tecnologias utilizadas

|Tecnologia|Uso no projeto|
|-|-|
|**FreeSQL** (MySQL)|Banco de dados em nuvem com o esquema HR.|
|**SQL**|Consultas com `LEFT JOIN` e `WHERE` para extrair os dados.|
|**Python 3**|Linguagem da análise de dados.|
|**pandas**|Leitura dos CSV, estatísticas e agrupamentos (EDA).|
|**matplotlib**|Geração dos gráficos (histograma, boxplot e barras).|
|**Jupyter Notebook**|Ambiente da análise exploratória interativa.|
|**Git / GitHub**|Versionamento (branches e commits) e publicação.|
|**VS Code**|Editor utilizado no desenvolvimento.|
|**OreateAI**|Assistente de IA usada como apoio na geração do código, das consultas SQL e deste README.|

\---

## 1\. Objetivo do trabalho

Atuando como analista de dados, o objetivo é estudar os dados de **Recursos
Humanos (RH)** da base **HR** disponível no **FreeSQL**, com foco em:

* distribuição dos **salários** por **departamento** e **cargo**;
* **distribuição geográfica** dos funcionários (cidade, país e região) e as
diferenças salariais entre regiões.

O projeto pratica, de ponta a ponta, o fluxo básico de análise: **SQL** para
extrair os dados do FreeSQL → **CSV** para armazenar o resultado → **Python
(pandas + matplotlib)** para a Análise Exploratória de Dados (EDA), estatísticas
e gráficos.

\---

## 2\. Tabelas utilizadas (esquema HR)

|Tabela|Para que serve na análise|
|-|-|
|`EMPLOYEES`|Funcionários, salário, cargo e departamento (tabela central).|
|`DEPARTMENTS`|Nome do departamento e o local (`LOCATION\_ID`).|
|`JOBS`|Nome do cargo (`JOB\_TITLE`) associado ao `JOB\_ID`.|
|`LOCATIONS`|Cidade e país de cada local.|
|`COUNTRIES`|Nome do país e a região (`REGION\_ID`).|
|`REGIONS`|Nome da região (Europe, Americas, Asia, Middle East and Africa).|

\---

## 3\. Resumo das consultas SQL

As consultas estão em [`sql/query\_1.sql`](sql/query_1.sql) e
[`sql/query\_2.sql`](sql/query_2.sql) e foram executadas no **FreeSQL (esquema
HR)**. Cada uma usa **pelo menos dois LEFT JOIN** e **um WHERE simples**.

### Query 1 — Salário por Departamento e Cargo

`hr.employees` **LEFT JOIN** `hr.departments` **LEFT JOIN** `hr.jobs`.  
Colunas: `EMPLOYEE\_ID, FIRST\_NAME, LAST\_NAME, SALARY, DEPARTMENT\_NAME, JOB\_TITLE`.  
**Filtro:** `WHERE e.salary IS NOT NULL`.

### Query 2 — Funcionários por Região

`hr.employees` **LEFT JOIN** `hr.departments` **LEFT JOIN** `hr.jobs`
**LEFT JOIN** `hr.locations` **LEFT JOIN** `hr.countries` **LEFT JOIN**
`hr.regions`.  
Colunas: `..., CITY, COUNTRY\_NAME, REGION\_NAME`.  
**Filtro:** `WHERE e.salary IS NOT NULL`.

Resultados exportados: [`data/query\_01.csv`](data/query_01.csv) e
[`data/query\_02.csv`](data/query_02.csv) — **107 linhas cada**. Observação:
**1 funcionário não possui departamento** (e, por consequência, cidade/país/
região em branco na Query 2); ele é desconsiderado nos agrupamentos por
departamento e por região.

\---

## 4\. Análise em Python (EDA)

A análise está no notebook [`analysis/analise\_eda.ipynb`](analysis/analise_eda.ipynb)
(executado, com tabelas e gráficos já renderizados). Etapas:

1. **Importação** dos dois CSV com `pandas` e padronização dos nomes de colunas.
2. **Visão geral**: formato, tipos de dados e valores ausentes.
3. **Estatísticas descritivas** do salário: média, mediana, mínimo, máximo,
desvio-padrão e quartis.
4. **Agrupamentos**: salário médio por departamento, por cargo e por região.
5. **Visualizações**: histograma, boxplot e gráfico de barras.
6. **Insights** resumidos ao final da execução.

> A \*\*primeira célula do notebook instala automaticamente\*\* `pandas` e
> `matplotlib` caso ainda não estejam no ambiente, evitando o erro
> `ModuleNotFoundError`.

\---

## 5\. Principais resultados

**Estatísticas do salário (107 funcionários):**

|Medida|Valor|
|-|-|
|Média|6.462|
|Mediana|6.200|
|Mínimo|2.100|
|Máximo|24.000|

* **Média (6.462) > Mediana (6.200):** distribuição **assimétrica à direita** —
poucos salários muito altos (ex.: presidência e vice-presidências) puxam a
média para cima.
* **Por departamento:** *Executive* tem o maior salário médio (\~19.333) e
*Shipping* o menor (\~3.476). *Shipping* (45) e *Sales* (34) concentram a
maior parte dos funcionários.
* **Por região:** *Europe* apresenta salário médio maior (\~8.917) que
*Americas* (\~5.192); a maioria dos funcionários está em *Americas*
(EUA + Canadá).

### Gráficos gerados

**Histograma da distribuição salarial**  
!\[Histograma dos salários](images/histograma\_salarios.png)

**Boxplot de salário por departamento**  
!\[Boxplot por departamento](images/boxplot\_salarios\_departamento.png)

**Salário médio por região**  
!\[Barras por região](images/barras\_salario\_medio\_regiao.png)

\---

## 6\. Como executar o projeto

### Pré-requisitos

* Python 3.10+ (recomendado 3.11, 3.12 ou 3.13 — versões estáveis)
* (Opcional) acesso ao FreeSQL, esquema HR: [https://freesql.com/](https://freesql.com/)

### Passo a passo (Windows / VS Code)

```powershell
# 1) clonar o repositório
git clone <URL-DO-SEU-REPOSITORIO>
cd projeto-hr-bi

# 2) criar e ativar um ambiente virtual
python -m venv .venv
.\\.venv\\Scripts\\activate

# 3) instalar as bibliotecas
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# 4) abrir o notebook da análise
jupyter notebook analysis\\analise\_eda.ipynb
#  (requer: pip install jupyter — ou abra o .ipynb direto no VS Code)
```

No Linux/macOS a ativação do venv é `source .venv/bin/activate`.

> \*\*Importante (VS Code):\*\* após criar o `.venv`, selecione o interpretador do
> `.venv` em \*Python: Select Interpreter\* (canto inferior direito). Assim o
> editor e o terminal usam o mesmo Python com as bibliotecas instaladas — isso
> evita o `ModuleNotFoundError: No module named 'pandas'`.

Os gráficos são salvos em `images/`.

\---

## 7\. Estrutura do repositório

```
projeto-hr-bi/
├── sql/
│   ├── query\_1.sql              # salários por departamento e cargo
│   └── query\_2.sql              # funcionários por região (com localização)
├── data/
│   ├── query\_01.csv             # resultado real da Query 1 (FreeSQL)
│   └── query\_02.csv             # resultado real da Query 2 (FreeSQL)
├── analysis/
│   └── analise\_eda.ipynb        # EDA, estatísticas e gráficos (Jupyter Notebook)
├── relatorio\_analise\_eda.pdf    # versão estática (PDF) do notebook executado
├── images/                      # gráficos gerados (PNG)
├── ROTEIRO\_VIDEO.md             # roteiro do vídeo de apresentação
├── requirements.txt
├── .gitignore
└── README.md
```

\---

## 8\. Sugestões de melhoria (versões futuras)

* Incluir a tabela `JOB\_HISTORY` para analisar evolução de cargos/salários.
* Considerar a comissão (`COMMISSION\_PCT`) na remuneração total dos vendedores.
* Adicionar gráficos interativos (Plotly) e um pequeno dashboard.
* Automatizar a extração direta do FreeSQL via conector SQL.
* Tratar e enriquecer dados geográficos ausentes (funcionário sem departamento).

\---

## 9\. Fluxo de versionamento (Git)

Branches por etapa e commits curtos e padronizados, por exemplo:

```
feat(sql):      adiciona consultas de salários e localização
feat(dados):    adiciona arquivos CSV extraídos do FreeSQL
feat(analise):  implementa análise exploratória em Python
feat(graficos): adiciona boxplot de salários
docs:           atualiza README com resultados e instruções de execução
```

## 10\. Vídeo do Projeto
https://drive.google.com/drive/u/2/folders/1Mla-j19Hp_5Jwerhwm_9Wh8dXMq1WUSn

