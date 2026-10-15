mod types;
mod graph;

use graph::ConectaStoreGrafo;
use types::{NodeType, RelacaoType};
use std::time::Instant;

fn main() {
    let mut store = ConectaStoreGrafo::new();

    println!("--- Inicializando ConectaStore ---");
    let inicio_carga = Instant::now();

    // Populando dados de exemplo
    store.adicionar_no("CLI-001".to_string(), NodeType::Cliente("CLI-001".to_string()));
    store.adicionar_no("CLI-002".to_string(), NodeType::Cliente("CLI-002".to_string()));
    store.adicionar_no("PROD-NOTEBOOK".to_string(), NodeType::Produto("PROD-NOTEBOOK".to_string()));
    store.adicionar_no("PROD-TECLADO".to_string(), NodeType::Produto("PROD-TECLADO".to_string()));

    store.adicionar_conexao("CLI-001", "PROD-NOTEBOOK", RelacaoType::Comprou, 1.0);
    store.adicionar_conexao("CLI-002", "PROD-NOTEBOOK", RelacaoType::Comprou, 1.0);
    store.adicionar_conexao("CLI-002", "PROD-TECLADO", RelacaoType::Comprou, 1.0);
    store.adicionar_conexao("CLI-002", "PROD-TECLADO", RelacaoType::Avaliou(5), 5.0);

    let duracao_carga = inicio_carga.elapsed();
    println!("Tempo de carga e construção do grafo: {:?}", duracao_carga);

    let inicio_rec = Instant::now();
    let recomendacoes = store.recomendar_por_vizinhanca("CLI-001");
    let duracao_rec = inicio_rec.elapsed();

    println!("Produtos recomendados: {:?}", recomendacoes);
    println!("Tempo de execução da recomendação: {:?}", duracao_rec);
}