# API de Gestão de Vendas

API REST em **Node.js + Express + MySQL** (SENAI – Desenvolvimento de APIs).
Módulos: `/clientes`, `/produtos`, `/usuarios`, `/pedidos` (com itens do pedido), organizados com `express.Router()`.

## Estrutura

```
├── index.js              # app principal, registra as rotas
├── db.js                 # pool de conexão MySQL
├── routes/
│   ├── clientes.js
│   ├── produtos.js
│   ├── usuarios.js
│   └── pedidos.js        # pedidos + itens
├── script_banco.sql      # CREATE TABLE + INSERT de teste
├── insomnia_postman_collection.json
├── .env.example
└── package.json
```

## Pré-requisitos
- Node.js 18+
- MySQL 8+

## Como rodar

1. Instalar dependências:
   ```bash
   npm install
   ```
2. Configurar variáveis de ambiente: copie `.env.example` para `.env` e ajuste usuário/senha do MySQL:
   ```bash
   cp .env.example .env
   ```
3. Importar o banco (cria o banco `sistema_clientes`, tabelas e dados iniciais):
   ```bash
   mysql -u root -p < script_banco.sql
   ```
4. Iniciar a aplicação:
   ```bash
   npm run dev
   ```
   A API fica em `http://localhost:3000`.

## Endpoints

### Usuários
| Método | Rota | Descrição |
|---|---|---|
| POST | /usuarios | Cadastrar (nome, email, senha; perfil e status opcionais) |
| GET | /usuarios | Listar |
| GET | /usuarios/:id | Buscar por ID |
| PUT | /usuarios/:id | Atualização completa |
| PATCH | /usuarios/:id | Atualização parcial (ex.: só senha ou status) |
| DELETE | /usuarios/:id | Remover |

### Pedidos e itens
| Método | Rota | Descrição |
|---|---|---|
| POST | /pedidos | Criar pedido (`cliente_id`) |
| GET | /pedidos | Listar pedidos com dados do cliente |
| GET | /pedidos/:id | Pedido completo (pedido + cliente + itens) |
| PATCH | /pedidos/:id/status | Alterar status (`pendente`, `pago`, `cancelado`) |
| POST | /pedidos/:id/itens | Adicionar item (`produto_id`, `quantidade`, `preco_unitario`) |
| DELETE | /pedidos/:id_pedido/itens/:id_item | Remover item |

### Clientes e Produtos
CRUD completo (POST, GET, GET/:id, PUT, PATCH, DELETE) em `/clientes` e `/produtos`.

## Regras de negócio e validações
- Campos obrigatórios validados (400).
- Registro inexistente (404); e-mail duplicado (400).
- Senha armazenada com hash (bcrypt) e nunca retornada pela API.
- `valor_total` do pedido é recalculado ao adicionar/remover itens.
- Itens só podem ser alterados em pedidos com status `pendente`.
- Cliente/produto com pedidos vinculados não podem ser removidos (400).

## Códigos HTTP usados
200, 201, 400, 404, 500.

## Testes
Importe `insomnia_postman_collection.json` no Postman ou Insomnia (variável `baseUrl` = `http://localhost:3000`).

Usuários de teste: `admin@vendas.com` / `admin123` e `operador@vendas.com` / `123456`.
