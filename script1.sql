create table cidades
(
	id_cidade serial primary key,
	nome varchar(50) not null
);

create table grupos
(
	id_grupo serial primary key,
	nome varchar(50) not null,
	id_cidade int not null,
	foreign key(id_cidade) references cidades
);
create table utensilios(
	id_utensilio serial primary key,
	nome varchar(30)
);
create table funcoes
(
	id_funcao SERIAL primary key,
	nome varchar(50) not null,
	id_utensilio int not null,
	foreign key(id_utensilio) references utensilios
);
create table pessoa
(
	id_pessoa SERIAL primary key,
	nome varchar(50) not null,
	id_grupo int not null,
	id_funcao int not null,
	foreign key(id_grupo) references grupos,
	foreign key(id_funcao) references funcoes
);
create table zumbi(
	id_zumbi serial primary key,
	nome varchar(50) not null,
	nivel_perigo int not null
);
create table vencedor(
	id_tipo_vencedor serial primary key,
	resumo_vencedor varchar(30) not null
);
create table embates(
	id_embate serial primary key,
	id_pessoa int not null,
	id_zumbi int not null,
	id_tipo_vencedor int not null,
	foreign key(id_pessoa) references pessoa,
	foreign key(id_zumbi) references zumbi,
	foreign key(id_tipo_vencedor) references vencedor
);
commit 


insert into cidades(nome) values ('Toxicity'), ('Seattle'), ('Melbourne'), ('Seoul'), ('Oslo'), ('Moscow')

insert into grupos(nome, id_cidade) values ('Beattles', 2), ('Ghost Busters', 1), ('Gallagers', 6), ('Kangurus', 3), ('Jormungandr', 5), ('Biters', 4)
delete from grupos where id_grupo in (1, 5)

insert into utensilios (nome) values ('Facao'), ('Revolver'), ('Machado'), ('arco e flecha'), ('Canivete'), ('Espingarda')
update utensilios set nome = 'utensilios de cozinha' where id_utensilio = 5

insert into funcoes (nome, id_utensilio) values ('Coletor', 1), ('Soldado', 2), ('Cacador', 4), ('cozinheiro', 5), ('Construtor', 3), ('Lider', 6)

insert into pessoa (nome, id_grupo, id_funcao) values ('Maria', 6, 1), ('Jimmy', 6, 4), ('Josh', 6, 6), ('Jack', 6, 2)
insert into pessoa (nome, id_grupo, id_funcao) values ('Fiona', 3, 6), ('Cecilia', 3, 2), ('Leo', 3, 3), ('Debbie', 3, 5)
insert into pessoa (nome, id_grupo, id_funcao) values ('Laura', 2, 6), ('Steven', 2, 2), ('El John', 2, 3), ('Heitor', 2, 1)
insert into pessoa (nome, id_grupo, id_funcao) values ('Lana', 4, 4), ('One eye', 4, 6), ('Elvis', 4, 5), ('Well', 4, 1)

insert into zumbi(nome, nivel_perigo) values ('baiacu', 10), ('Estaladores', 7), ('Honey', 2)
update zumbi set nome = 'Baiacu' where nome like '%baiacu%'

insert into vencedor(resumo_vencedor) values ('Pessoa venceu'), ('O mal venceu')
update vencedor set resumo_vencedor = 'Zumbi venceu' where id_tipo_vencedor = 2

insert into embates (id_pessoa, id_zumbi, id_tipo_vencedor) values (10, 1, 1), (6, 2, 2), (4, 3, 1)



select * from cidades
select * from grupos
select * from utensilios
select * from funcoes
select * from pessoa
select * from zumbi
select * from vencedor
select * from embates

select 
	g.id_grupo,
	g.nome as nome_grupo,
	c.nome as nome_cidade
from 
	grupos g
join 
	cidades c on c.id_cidade = g.id_cidade
	
select 
	f.id_funcao,
	f.nome as nome_funcao,
	u.nome as utensilio
from 
	funcoes f
join
	utensilios u on u.id_utensilio = f.id_utensilio
	
select 
	*
from 
	pessoa
where 
	id_funcao = 2
	
select * from embates

select 
	e.id_embate,
	p.nome as nome_pessoa,
	z.nome as zumbi,
	v.resumo_vencedor as resumo
from 
	embates e
join 
	pessoa p on p.id_pessoa = e.id_pessoa
join 
	zumbi z on z.id_zumbi = e.id_zumbi
join 
	vencedor v on v.id_tipo_vencedor = e.id_tipo_vencedor
