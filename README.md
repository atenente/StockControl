# STOCK CONTROL

[![Ruby](https://img.shields.io/badge/Ruby%20on%20Rails-v3.2-red)](https://rubyonrails.org/)
[![Rails](https://img.shields.io/badge/Ruby%20on%20Rails-v7.1-red)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-v14-blue)](https://www.postgresql.org/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-v5.3-purple)](https://getbootstrap.com/)

Stock Control é um sistema de gerenciamento de estoque desenvolvido para pequenos comerciantes, funcionando como um mini ERP. Este projeto serve tanto como um portfólio pessoal quanto como um sistema comercializado.

## 🚧 Status do Projeto

Este projeto está **em construção** e novas funcionalidades e melhorias estão sendo implementadas.
### Funcionalidades
- [x] **Autenticação**: Usuários podem se registrar e fazer login no sistema.
- [x] **Autorização**: Controle de acesso de usuários.
- [x] **CRUD de Empresas**: Gerenciamento das empresas, que utilizaram o sistema.
- [x] **CRUD de Produtos**: Gerenciamento dos produtos por empresa.
- [ ] **CRUD de Vendas**: Gerenciamento das vendas por empresa.
- [ ] **Extração de Relatórios**: Geração de relatórios e extração (pdf, excel, csv).
- [ ] **Importação de Dados em Massa**: Importação em massa de dados em produtos.
- [ ] **Inserção de Imagens**: Upload de imagens para os logos de empresas e produtos.
- [ ] **Envio de Relatórios por Email**: Geração e envio automatizado de e-mail.
<br>
- ♾️ Testes e melhorias.

## 🛠️ Principais Tecnologias Utilizadas
- **Ruby 3.2.4** - Linguagem de programação utilizada no projeto.
- **Rails 7.1.3.4** - Framework principal.
- **PostgreSQL** - Banco de dados relacional.
- **Puma** - Servidor de aplicação web utilizado para garantir performance e escalabilidade.
- **Devise** - Implementa autenticação de usuários.
- **Pundit** - Implementa autorização de usuários
- **RSpec** - Testes automaticos.
- **Bootstrap** - Framework CSS para estilização

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Ruby](https://www.ruby-lang.org/pt/downloads/) - Versão 3.2.4
- [Rails](https://rubygems.org/gems/rails/versions/7.1.3.4) - Versão 7.1.3.4
- [PostgreSQL](https://www.postgresql.org/download/) - Versão 14

### Instalação

1. Clone o repositório:

   ```bash
   git clone https://github.com/atenente/StockControl.git
   cd StockControl
2. Preparando o ambiente
   ```bash
    rails db:create
    rails db:migrate
    rails db:seed 
   ```
    **obs: seed é necessário para criar uma empresa e usuário master, para poder obter acesso ao sistema.
