#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum NodeType {
    Cliente(String),
    Produto(String),
    Categoria(String),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum RelacaoType {
    Comprou,
    PertenceACategoria,
    Avaliou(u8),
}

#[derive(Debug, Clone)]
pub struct Edge {
    pub destino: usize,
    pub tipo: RelacaoType,
    pub peso: f32,
}