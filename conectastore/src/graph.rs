use std::collections::{HashMap, HashSet};
use crate::types::{NodeType, RelacaoType, Edge};

#[derive(Debug, Default)]
pub struct ConectaStoreGrafo {
    pub nos: Vec<NodeType>,
    pub adjacencias: Vec<Vec<Edge>>,
    pub indice_map: HashMap<String, usize>,
}

impl ConectaStoreGrafo {
    pub fn new() -> Self {
        Self {
            nos: Vec::new(),
            adjacencias: Vec::new(),
            indice_map: HashMap::new(),
        }
    }

    pub fn adicionar_no(&mut self, id_str: String, tipo: NodeType) -> usize {
        if let Some(&idx) = self.indice_map.get(&id_str) {
            return idx;
        }
        let novo_idx = self.nos.len();
        self.nos.push(tipo);
        self.adjacencias.push(Vec::new());
        self.indice_map.insert(id_str, novo_idx);
        novo_idx
    }

    pub fn adicionar_conexao(&mut self, origem_str: &str, destino_str: &str, tipo: RelacaoType, peso: f32) {
        if let (Some(&origem), Some(&destino)) = (self.indice_map.get(origem_str), self.indice_map.get(destino_str)) {
            self.adjacencias[origem].push(Edge { destino, tipo, peso });
        }
    }

    // Algoritmo de recomendação por vizinhança qualificada (Filtragem colaborativa + pesos)
    pub fn recomendar_por_vizinhanca(&self, cliente_id: &str) -> Vec<String> {
        let mut recomendacoes = HashSet::new();
        let cliente_idx = match self.indice_map.get(cliente_id) {
            Some(&idx) => idx,
            None => return vec![],
        };

        let mut produtos_comprados = HashSet::new();
        for aresta in &self.adjacencias[cliente_idx] {
            if aresta.tipo == RelacaoType::Comprou {
                produtos_comprados.insert(aresta.destino);
            }
        }

        let mut outros_clientes = HashSet::new();
        for &prod_idx in &produtos_comprados {
            for (idx_no, vizinhos) in self.adjacencias.iter().enumerate() {
                for aresta in vizinhos {
                    if aresta.destino == prod_idx && aresta.tipo == RelacaoType::Comprou && idx_no != cliente_idx {
                        outros_clientes.insert(idx_no);
                    }
                }
            }
        }

        let mut produtos_indicados = HashSet::new();
        for &outro_cliente in &outros_clientes {
            for aresta in &self.adjacencias[outro_cliente] {
                if let RelacaoType::Avaliou(nota) = aresta.tipo {
                    if nota >= 4 && !produtos_comprados.contains(&aresta.destino) {
                        produtos_indicados.insert(aresta.destino);
                    }
                }
            }
        }

        for &prod_idx in &produtos_indicados {
            if let NodeType::Produto(ref sku) = self.nos[prod_idx] {
                recomendacoes.insert(sku.clone());
            }
        }

        recomendacoes.into_iter().collect()
    }
}

// Testes unitários integrados no próprio módulo
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_adicionar_no_e_busca() {
        let mut grafo = ConectaStoreGrafo::new();
        let idx = grafo.adicionar_no("CLI-1".to_string(), NodeType::Cliente("CLI-1".to_string()));
        assert_eq!(idx, 0);
        assert_eq!(grafo.indice_map.get("CLI-1"), Some(&0));
    }
}