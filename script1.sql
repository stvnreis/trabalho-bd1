create table cidades(
	id_cidade serial primary key,
	nome varchar(50) not null
)
go
create table grupos(
	id_grupo serial primary key,
	nome varchar(50) not null,
	id_cidade int not null,
	foreign key(id_cidade) references cidades
)
go
create table funcoes(
	id_funcao SERIAL primary key,
	nome varchar(50) not null,
	id_grupo_utensilio int not null,
	foreign key(id_grupo_utensilio) references utensilios
)
go
create table pessoa(
	id_pessoa SERIAL primary key,
	nome varchar(50) not null,
	id_grupo int not null,
	id_funcao int not null,
	foreign key(id_grupo) references grupos,
	foreign key(id_funcao) references funcoes
)
go
create table zumbi(
	id_zumbi serial primary key,
	nome varchar(50) not null,
	nivel_perigo int not null
)
go
create table embates(
	id_embate serial primary key,
	id_pessoa int not null,
	id_zumbi int not null,
	resumo_vencedor char(1),
	foreign key(id_pessoa) references pessoas,
	foreign key(id_zumbi) references zumbi
)
