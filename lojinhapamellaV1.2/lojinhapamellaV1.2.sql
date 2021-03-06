/*
	Lojinha Pamella
    @author Pamella Pereto
    @version 1.2
*/

show databases;

use lojinhapamella;

-- Unique (não permitir valores duplicados)
create table usuarios(
	idusu int primary key auto_increment,
    usuario varchar(255) not null,
    login varchar(255) not null unique,
    senha varchar(255) not null,
    perfil varchar(255) not null
);

describe usuarios;

-- Para inserir uma senha com criptografia usamos md5()
insert into usuarios(usuario,login,senha,perfil)
values('Administrador','admin',md5('admin'),'admin');
insert into usuarios(usuario,login,senha,perfil)
values('Pamella Pereto','pamellapereto',md5('123456'),'user');

select * from usuarios;

-- Acessando o sistema pela tela de login
-- and (função lógica onde todas as condições devem ser verdadeiras)
select * from usuarios where login='admin' and senha=md5('admin');

create table fornecedores(
idfor int primary key auto_increment,
cnpj varchar(255) not null unique,
ie varchar(255) unique,
im varchar(255) unique,
razao varchar(255) not null,
fantasia varchar(255) not null,
site varchar(255),
fone varchar(255) not null,
contato varchar(255),
email varchar(255),
cep varchar(255) not null,
endereco varchar(255) not null,
numero varchar(255) not null,
complemento varchar(255),
bairro varchar(255) not null,
cidade varchar(255) not null,
uf char(255) not null,
obs varchar(255)
);

describe fornecedores;

insert into  fornecedores (cnpj,razao,fantasia,fone,cep,endereco,numero,bairro,cidade,uf)
values ('99.152.736/0001-33','Pamella Pereto','Loja Senhoritta','(11) 92621-6085','03728-000','Rua São José do Campestre','390','Jardim Danfer','São Paulo','SP');

select * from fornecedores;

create table produtos(
	codigo int primary key auto_increment,
    barcode varchar(255),
    produto varchar(255) not null,
    descricao varchar(255) not null,
    fabricante varchar(255) not null,
    datacad timestamp default current_timestamp,
    dataval date,
    estoque int not null,
    estoquemin int not null,
    unidade varchar(255) not null,
    localizacao varchar(255) ,
    custo decimal(10,2) not null,
    lucro decimal(10,2),
    venda decimal(10,2),
    idfor int not null,
	foreign key (idfor) references fornecedores (idfor)
    );
    
describe produtos;
    
insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('1234567890','saia','rosa','Renner',21220525,3,5,'UN','Setor Roupas',54.90,55,109.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('1111111111','blusa','verde','Renner',21220525,20,5,'UN','Setor Roupas',59.90,60,119.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('2222222222','vestido','amarelo','Marisa',20220519,14,9,'UN','Setor Roupas',39.90,85,124.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('3333333333','cropped','azul','Marisa',20220518,19,13,'UN','Setor Roupas',99.90,99.59,199.49, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('4444444444','calça','branca','Shein',20220517,15,8,'UN','Setor Roupas',33.90,40.59,74.49, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('5555555555','chemise','listrado','Shein',21220525,4,10,'UN','Setor Roupas',49.90,65,114.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('6666666666','shorts','jeans','Forever 21',21220525,50,30,'UN','Setor Roupas',33.33,51.57,84.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('7777777777','bermuda','jeans','Forever 21',21220525,33,24,'UN','Setor Roupas',19.90,25,44.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('8888888888','casaco','marrom','C&A',21220525,22,16,'UN','Setor Roupas',24.90,25,49.90, 1);

insert into produtos (barcode,produto,descricao,fabricante,dataval,estoque,estoquemin,unidade,localizacao,custo,lucro,venda, idfor)
values ('9999999999','macacão','rosa','C&A',21220525,18,17,'UN','Setor Roupas',19,35.49,54.49, 1);
    
select * from produtos;

-- Inventário de estoque (patrimônio)
-- sum() ➙ função de soma no banco de dados
select sum(estoque * custo) as Total from produtos;

-- Relatório de reposição de estoque 1
select * from produtos where estoque < estoquemin;

-- Relatório de reposição de estoque 2
-- date_format() ➙ função usada para formatar a data
-- %d/%m/%Y dd/mm/aaaa | %d/%m/%y dd/mm/aa
select codigo,produto,
date_format(dataval, '%d/%m/%Y') as data_validade,
estoque, estoquemin as estoque_mínimo
from produtos where estoque < estoquemin;

-- Relatório de validade de produtos 1
select codigo,produto,
date_format(dataval, '%d/%m/%Y') as data_validade
from produtos;

-- Relatório de validade de produtos 2
-- datediff() ➙ calcular a diferença em dias
-- curdate() ➙ obtém a data atual
select codigo,produto,
date_format(dataval, '%d/%m/%Y') as data_validade,
datediff(dataval, curdate()) as dias_restantes
from produtos;


create table clientes (
 idcli int primary key auto_increment,
 nome varchar (255) not null,
 fone varchar(255) not null,
 cpf varchar(255) unique,
email varchar(255),
marketing varchar(255) not null,
cep varchar(255),
endereco varchar(255),
bairro varchar(255),
numero varchar(255),
complemento varchar(255),
cidade varchar(255),
uf char(2)
);

alter table clientes add column nascimento date after cpf;

describe clientes;

insert into clientes (nome, fone, cpf, nascimento, email, marketing)
values ('Pamella Pereto', '1196455-6220', '383.036.508-07', 19970714, 'pamellapereto@gmail.com', 'sim');

insert into clientes (nome, fone, cpf, nascimento, email, marketing)
values ('Henrique Neto', '1196182-4236', '377.314.998-04', 19911004, 'henriquens4@gmail.com', 'sim');

insert into clientes (nome, fone, email, marketing)
values ('Pedro Pereira', '2194292-7163', 'pedropereira@gmail.com', 'sim');

insert into clientes (nome, fone, marketing)
values ('Roberto Macedo', '2191237-3765', 'não');

insert into clientes (nome, fone, marketing, cep, endereco, numero, complemento, bairro, cidade, uf)
values ('Rosangela Aparecida', '1194123-7766', 'não', '03728-000', 'Rua São José do Campestre', '390', 'Casa 2', 'Jardim Danfer', 'São Paulo', 'SP');

insert into clientes (nome, fone, marketing, cep, endereco, numero, bairro, cidade, uf)
values ('Ana Dutra', '1193695-2312', 'não', '03324-100', 'Rua Miguel Leão', '150', 'Vila Silvia', 'São Paulo', 'SP');

select * from clientes;

update clientes set fone = '1197231-5819' where idcli=6;

-- foreign key(FK): chave estrangeira que cria o relacionamento
-- do tipo 1-N com a tabela clientes
-- FK(pedidos)______________PK(clientes)
-- Observação: Usar o mesmo nome e tipo de dados nas chaves (PK e FK)

-----------------------------------------

create table pedidos (
pedido int primary key auto_increment,
dataped timestamp default current_timestamp,
total decimal(10,2),
idcli int not null,
foreign key (idcli) references clientes(idcli)
);

-- Abertura de pedidos
insert into pedidos(idcli) values(1);

-- Verificar pedidos
select * from pedidos where pedido;

-- Verificar pedidos junto com o nome do cliente
-- inner join (unir informações de 2 ou mais tabelas)
-- IMPORTANTE! Indicar as chaves FK e PK
select * from pedidos inner join clientes
on pedidos.idcli = clientes.idcli;

-- Verificar pedidos junto com o nome do cliente (relatório simplificado)
-- %H:%i ➙ exibir também o horario formatado
select
pedidos.pedido,
date_format(pedidos.dataped, '%d%m%Y - %H:%i') as data_ped,
clientes.nome as cliente,
clientes.fone
from pedidos inner join clientes
on pedidos.idcli = clientes.idcli;


-- ====== Linha de tabela de carrinho =======
-- Tabela de apoio para criar um relacionamento de tipo M-M
-- (Muitos para Muitos), neste caso não criamos a chave primária


create table carrinho (
	pedido int not null,
    codigo int not null,
    quantidade int not null,
    foreign key(pedido) references pedidos(pedido),
    foreign key(codigo) references produtos(codigo)
);

insert into carrinho values (1,8,3);
insert into carrinho values (1,9,1);

select * from carrinho;

-- Exibir o carrinho
select pedidos.pedido,
carrinho.codigo as Código,
produtos.produto,
carrinho.quantidade,
produtos.venda,
produtos.venda * carrinho.quantidade as Subtotal
from (carrinho inner join pedidos on carrinho.pedido = pedidos.pedido)
inner join produtos on carrinho.codigo = produtos.codigo;

-- Total do pedido (encontrado em carrinho) ➙ Fechamento
select sum(produtos.venda * carrinho.quantidade) as Total
from carrinho inner join produtos on carrinho.codigo = produtos.codigo;

-- Atualização do estoque
update carrinho
inner join produtos
on carrinho.codigo = produtos.codigo
set produtos.estoque = produtos.estoque - carrinho.quantidade
where carrinho.quantidade > 0;
