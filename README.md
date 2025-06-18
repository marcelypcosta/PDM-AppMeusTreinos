# Documentação do App "Meu Treino" 🏋️‍♂️

## 1. Introdução

Este documento detalha a estrutura e as funcionalidades do aplicativo "Meu Treino", uma solução mobile desenvolvida para auxiliar usuários a registrarem e acompanharem seus treinos de academia de forma organizada e eficiente, substituindo o uso informal de blocos de notas.

O aplicativo foi concebido para oferecer uma experiência de usuário simples e direta, focada nas necessidades essenciais de quem pratica musculação.

**Autores:** Marcely, Lucas, Werner e Felipe Gabriel.

**Tecnologia:** O aplicativo foi desenvolvido utilizando Flutter, o framework de desenvolvimento de UI da Google, permitindo a criação de uma aplicação nativa compilada para mobile a partir de uma única base de código.

---

## 2. Funcionalidades e Telas

O aplicativo é estruturado em cinco telas principais, cada uma com um propósito específico para enriquecer a jornada do usuário na academia.

### Tela 1: Lista de Treinos

Esta é a tela principal do aplicativo. Ela exibe uma lista com todos os treinos criados pelo usuário.

* **Objetivo:** Oferecer acesso rápido e visualização geral dos planos de treino disponíveis (ex: Treino A, Treino B, Treino C, etc.).
* **Funcionalidades:**
    * Listagem dos treinos cadastrados.
    * Ponto de entrada para visualizar os detalhes de um treino específico.
    * Acesso à função de criar um novo treino.

### Tela 2: Criação e Edição de Treino

Nesta tela, o usuário pode montar suas rotinas de treino de forma personalizada.

* **Objetivo:** Permitir que o usuário crie ou edite um plano de treino, especificando os exercícios que o compõem.
* **Funcionalidades:**
    * Campo para nomear o treino (ex: "Treino A - Peito e Tríceps").
    * Ferramenta para adicionar múltiplos exercícios à lista.
    * Para cada exercício, é possível definir:
        * Nome do exercício (ex: "Supino Reto").
        * Número de séries (ex: 4).
        * Faixa de repetições (ex: 8-12).
    * Botão para adicionar mais exercícios e outro para salvar o treino criado.

### Tela 3: Execução do Treino

Ao selecionar um treino na tela inicial, o usuário é direcionado para esta tela, que serve como um guia durante a sessão na academia.

* **Objetivo:** Apresentar de forma clara a lista de exercícios, séries e repetições do treino selecionado para que o usuário possa segui-lo.
* **Funcionalidades:**
    * Exibição detalhada de cada exercício do treino.
    * Botão para salvar no histórico definindo com treino realizado com sucesso.
    * Interface limpa para facilitar a leitura rápida entre uma série e outra.

### Tela 4: Histórico de Treinos

Esta tela funciona como um diário, permitindo que o usuário visualize seu progresso e consistência ao longo do tempo.

* **Objetivo:** Registrar e exibir os dias em que o usuário realizou treinos.
* **Funcionalidades:**
    * Visualização de todos os treinos concluídos.
    * Motiva o usuário a manter a frequência e a disciplina.

### Tela 5: Lembretes e Anotações

Um espaço para anotações gerais, lembretes ou qualquer informação relevante que o usuário queira guardar.

* **Objetivo:** Oferecer uma funcionalidade de bloco de notas integrado ao app para anotações rápidas.
* **Funcionalidades:**
    * Criação de notas de texto simples.
    * Possibilidade de criar lembretes (ex: "Comprar luvas novas", "Agendar avaliação física").
    * Lista de anotações salvas para consulta futura.

---

## 3. Conclusão

O "Meu Treino" é uma ferramenta prática e focada, que resolve um problema real para frequentadores de academia. Com uma arquitetura de telas bem definida, o aplicativo cobre desde a criação e organização dos treinos até o acompanhamento do histórico e anotações, tornando-se um companheiro ideal para a rotina de exercícios.