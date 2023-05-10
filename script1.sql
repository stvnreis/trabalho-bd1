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
create table utensilios
(
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
create table zumbi
(
	id_zumbi serial primary key,
	nome varchar(50) not null,
	nivel_perigo int not null
);
create table vencedor
(
	id_tipo_vencedor serial primary key,
	resumo_vencedor varchar(30) not null
);
create table embates
(
	id_embate serial primary key,
	id_pessoa int not null,
	id_zumbi int not null,
	id_tipo_vencedor int not null,
	foreign key(id_pessoa) references pessoa,
	foreign key(id_zumbi) references zumbi,
	foreign key(id_tipo_vencedor) references vencedor
);

commit 

insert into cidades(nome) values ('Toxicity'), ('Seattle'), ('Melbourne'), ('Seoul'), ('Oslo'), ('Moscow');

insert into grupos(nome, id_cidade) values ('Beattles', 2), ('Ghost Busters', 1), ('Gallagers', 6), ('Kangurus', 3), ('Jormungandr', 5), ('Biters', 4);
delete from grupos where id_grupo in (1, 5);

insert into utensilios (nome) values ('Facao'), ('Revolver'), ('Machado'), ('arco e flecha'), ('Canivete'), ('Espingarda');
update utensilios set nome = 'utensilios de cozinha' where id_utensilio = 5;

insert into funcoes (nome, id_utensilio) values ('Coletor', 1), ('Soldado', 2), ('Cacador', 4), ('cozinheiro', 5), ('Construtor', 3), ('Lider', 6);

insert into pessoa (nome, id_grupo, id_funcao) values ('Maria', 6, 1), ('Jimmy', 6, 4), ('Josh', 6, 6), ('Jack', 6, 2);
insert into pessoa (nome, id_grupo, id_funcao) values ('Fiona', 3, 6), ('Cecilia', 3, 2), ('Leo', 3, 3), ('Debbie', 3, 5);
insert into pessoa (nome, id_grupo, id_funcao) values ('Laura', 2, 6), ('Steven', 2, 2), ('El John', 2, 3), ('Heitor', 2, 1);
insert into pessoa (nome, id_grupo, id_funcao) values ('Lana', 4, 4), ('One eye', 4, 6), ('Elvis', 4, 5), ('Well', 4, 1);

insert into zumbi(nome, nivel_perigo) values ('baiacu', 10), ('Estaladores', 7), ('Honey', 2);
update zumbi set nome = 'Baiacu' where nome like '%baiacu%';

insert into vencedor(resumo_vencedor) values ('Pessoa venceu'), ('O mal venceu');
update vencedor set resumo_vencedor = 'Zumbi venceu' where id_tipo_vencedor = 2;

insert into embates (id_pessoa, id_zumbi, id_tipo_vencedor) values (10, 1, 1), (6, 2, 2), (4, 3, 1);
insert into embates (id_pessoa, id_zumbi, id_tipo_vencedor) values (10, 2, 1), (4, 2, 1);
insert into embates (id_pessoa, id_zumbi, id_tipo_vencedor) values (10, 3, 1);

commit


-------------------------------------------------------------------
-- Consultas simples para cada uma das tabelas --
-------------------------------------------------------------------



select * from cidades
select * from grupos
select * from utensilios
select * from funcoes
select * from pessoa
select * from zumbi
select * from vencedor
select * from embates



--------------------------------------------
-- Consultas com juncoes de tabela (JOIN) --
--------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Objetivo da consulta é trazer o identificador do grupo, juntamente de seu nome e o nome da cidade a qual pertence --
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------

select 
	g.id_grupo,
	g.nome as nome_grupo,
	c.nome as nome_cidade
from 
	grupos g
join 
	cidades c on c.id_cidade = g.id_cidade
	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Objetivo da consulta é trazer o identificador da função, juntamente de seu nome e o nome do utensilio que possui direito a uso --
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select 
	f.id_funcao,
	f.nome as nome_funcao,
	u.nome as utensilio
from 
	funcoes f
join
	utensilios u on u.id_utensilio = f.id_utensilio
	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Objetivo da consulta é trazer o identificador do combate, juntamente do nome do humano que participou, o nome do tipo do zumbi e quem foi o vencedor H/Z(Humano, Zumbi) --
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
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
	

	
-----------------------------------------
-- Consultas com agregacao --
-----------------------------------------
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Objetivo da consulta é trazer todas as pessoas que tiveram em algum combate e mostrar qual foi o maior nivel de perigo que enfrentaram --
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
select 
	p.id_pessoa,
	p.nome,
	max(z.nivel_perigo) as maximo_perigo_enfrentado
from 
	embates e 
join
	pessoa p on p.id_pessoa = e.id_pessoa 
join 
	zumbi z on z.id_zumbi = e.id_zumbi
group by 
	p.id_pessoa,
	p.nome
order by 
	p.nome asc 	
		
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Objetivo da consulta é trazer todas as pessoas que tiveram em algum combate e mostrar qual foi o menor nivel de perigo que enfrentaram --
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select 
	p.id_pessoa,
	p.nome,
	min(z.nivel_perigo) as minimo_perigo_enfrentado
from 
	embates e 
join
	pessoa p on p.id_pessoa = e.id_pessoa 
join 
	zumbi z on z.id_zumbi = e.id_zumbi
group by 
	p.id_pessoa,
	p.nome
order by 
	p.nome asc 
	
--------------------------------------------------------------------------------------------------------------------------------------
-- Objetivo da consulta é trazer todas as pessoas e contar em quantos combates elas participaram --
--------------------------------------------------------------------------------------------------------------------------------------
	
select 
	p.id_pessoa,
	p.nome,
	count(e.id_embate) as qt_embates
from 
	pessoa p 
join
	embates e on p.id_pessoa = e.id_pessoa
group by 
	p.id_pessoa,
	p.nome 
	
------------------------------
-- Consulta com subconsulta --
------------------------------
	
select 
	p.id_pessoa,
	p.nome
from
	pessoa p
where 
	(
		select 
			count(*)
		from
			embates e
		where 
			e.id_pessoa = p.id_pessoa
	) >= 2

	
select 
	p.id_pessoa,
	p.nome,
	(
		select 
			count(*)
		from
			embates e 
		where 
			e.id_pessoa = p.id_pessoa
	) as qt_embates
from 
	pessoa p 
