require('dotenv').config();
const express = require('express');

const clientesRouter = require('./routes/clientes');
const produtosRouter = require('./routes/produtos');
const usuariosRouter = require('./routes/usuarios');
const pedidosRouter = require('./routes/pedidos');

const app = express();
app.use(express.json());

app.get('/', (req, res) => res.json({ mensagem: 'API de Gestão de Vendas no ar' }));

app.use('/clientes', clientesRouter);
app.use('/produtos', produtosRouter);
app.use('/usuarios', usuariosRouter);
app.use('/pedidos', pedidosRouter);

// JSON malformado e demais erros
app.use((err, req, res, next) => {
  if (err.type === 'entity.parse.failed') {
    return res.status(400).json({ mensagem: 'JSON inválido no corpo da requisição' });
  }
  console.error(err);
  res.status(500).json({ mensagem: 'Erro interno do servidor' });
});

// Rota não encontrada
app.use((req, res) => res.status(404).json({ mensagem: 'Rota não encontrada.' }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor rodando em http://localhost:${PORT}`));
