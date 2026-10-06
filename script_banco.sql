
CREATE DATABASE IF NOT EXISTS sistema_clientes;
USE sistema_clientes;

CREATE TABLE IF NOT EXISTS clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  status ENUM('ativo', 'inativo') DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10, 2) NOT NULL,
  estoque INT DEFAULT 0,
  status ENUM('ativo', 'inativo') DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  perfil ENUM('admin', 'operador') DEFAULT 'operador',
  status ENUM('ativo', 'inativo') DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
  valor_total DECIMAL(10, 2) DEFAULT 0.00,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS itens_pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE RESTRICT
);
INSERT INTO clientes (nome, email, telefone) VALUES
  ('Maria Silva', 'maria@email.com', '(11) 91111-1111'),
  ('João Santos', 'joao@email.com', '(11) 92222-2222'),
  ('Ana Oliveira', 'ana@email.com', '(11) 93333-3333');

INSERT INTO produtos (nome, descricao, preco, estoque) VALUES
  ('Notebook', 'Notebook 15" 8GB RAM', 3500.00, 10),
  ('Mouse', 'Mouse sem fio', 80.00, 50),
  ('Teclado', 'Teclado mecânico', 150.00, 30),
  ('Monitor', 'Monitor 24" Full HD', 900.00, 15);

INSERT INTO usuarios (nome, email, senha, perfil, status) VALUES
  ('Administrador', 'admin@vendas.com', '$2b$10$UbuSnTyJIbm9zbv7I0vedeXtof4i1u1A8KghNTXjFb/E4rbWIcaxq', 'admin', 'ativo'),
  ('Operador', 'operador@vendas.com', '$2b$10$R8/eJ1CXJUjbImGCQU2lqOcMQJHk2XsN97B1vjZ62lIaa7tRlW122', 'operador', 'ativo');

INSERT INTO pedidos (cliente_id, status, valor_total) VALUES
  (1, 'pago', 3660.00),
  (2, 'pendente', 1050.00),
  (3, 'pendente', 0.00);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
  (1, 1, 1, 3500.00),
  (1, 2, 2, 80.00),
  (2, 3, 1, 150.00),
  (2, 4, 1, 900.00);
