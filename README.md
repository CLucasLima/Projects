# ConectaStore — Sistema de Recomendação em Grafos

## 1. Objetivo e Funcionamento do Sistema
O **ConectaStore** é um sistema de recomendação desenvolvido para a plataforma de comércio eletrônico MegaStore. O objetivo principal é superar as limitações das recomendações tradicionais (genéricas ou baseadas apenas em itens mais vendidos) por meio da modelagem do comportamento dos consumidores, produtos e categorias utilizando uma estrutura de **Grafo**. O sistema analisa o histórico de compras e avaliações de clientes com perfis semelhantes para sugerir produtos relevantes e assertivos.

## 2. Tecnologias e Estruturas Utilizadas
* **Linguagem:** Rust (garantindo alta performance, segurança de memória e ausência de *garbage collector*).
* **Grafo por Lista de Adjacências (`Vec<Vec<Edge>>`):** Escolhido para otimizar o consumo de memória em grafos esparsos e garantir alta localidade de cache.
* **`HashMap<String, usize>`:** Utilizado para o mapeamento instantáneo de identificadores textuais (IDs e SKUs) para índices numéricos em tempo $O(1)$.
* **`HashSet`:** Empregado para garantir a unicidade de dados e prevenir recomendações duplicadas.

## 3. Arquitetura da Solução
O projeto está modularizado para s
conectastore/
├── Cargo.toml
├── src/
│   ├── main.rs       # Execução principal e medição de desempenho
│   ├── graph.rs      # Estrutura do grafo e algoritmos de percurso
│   └── types.rs      # Definição dos vértices, arestas e tipos de relação
├── tests/
│   └── integration_tests.rs
└── README.md
## 4. Instruções para Compilação e Execução
Certifique-se de ter o [Rust e o Cargo](https://www.rust-lang.org/) instalados no seu ambiente.

1. Clone o repositório e acesse a pasta do projeto:
   ```bash
   git clone <url-do-seu-repositorio>
   cd conectastore
2. Compile e execute o projeto utilizando o Cargo:
   cargo run

## 5. Instruções para Execução dos Testes
  Para rodar os testes unitários e de integração implementados no projeto, execute o comando:
  cargo test

## 6. O sistema cadastra nós no grafo (Clientes, Produtos e Categorias) e conecta suas arestas por meio de interações como Comprou e Avaliou(u8). Ao consultar as recomendações para um determinado cliente, o algoritmo 
  mapeia os vizinhos de 2º grau e filtra os itens mais bem avaliados:
  // Exemplo conceitual implementado no main.rs
    let recomendacoes = store.recomendar_por_vizinhanca("CLI-001");
    println!("Produtos recomendados: {:?}", recomendacoes);

## 7. Resultados dos Testes de Desempenho
  Tempo de carga e construção do grafo: ~0.20 ms para o conjunto de dados base de testes.

  Tempo de execução da recomendação: Execução em frações de milissegundo, demonstrando alta eficiência no percurso de vizinhança graças ao armazenamento contíguo em vetores otimizados pelo compilador do Rust.
