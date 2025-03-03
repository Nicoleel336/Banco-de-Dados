create database if not exists hospital;
USE hospital;

create table if not exists especialidades(
	id_especialidade INT auto_increment primary key,
    nome_especialidade varchar(45)
);

create table if not exists convenios(
	id_convenio INT auto_increment primary key,
    nome_convenio varchar(45),
    cnpj_convenio varchar(20),
    carencia varchar(50)
);

create table if not exists medicos(
	id_medico INT auto_increment primary key,
    nome_medico varchar(100) not null,
    cpf_medico varchar(20) unique not null,
    crm varchar(20) unique not null,
    email_medico varchar(45),	# pode ter ou não
    cargo varchar(20) not null,
    especialidade INT not null,
    disponibilidade tinyint default 1,
    foreign key(especialidade) references especialidades(id_especialidade) on delete cascade on update cascade 
);

create table if not exists pacientes(
	id_paciente INT auto_increment primary key,
    nome_paciente varchar(100) not null,
    cpf_paciente varchar(20) unique not null,
    data_nascimento date not null,
    rg_paciente varchar(20) not null,
    email_paciente varchar(45),	# pode ter ou não
    convenio INT default null,	# pode ter ou não
    foreign key(convenio) references convenios(id_convenio) on delete cascade on update cascade
);

create table if not exists consultas(
	id_consulta INT auto_increment primary key,
    valor_consulta decimal,	# pode ter ou não
    medico INT not null,
    paciente INT not null,
    especialidade INT not null,
    data_consulta date not null, #verificar como vou operar(date)
    hora_consulta time not null, #verificar como vou operar(time)
    foreign key(especialidade) references especialidades(id_especialidade) on delete cascade on update cascade,
    foreign key(medico) references medicos(id_medico) on delete cascade on update cascade,
    foreign key(paciente) references pacientes(id_paciente) on delete cascade on update cascade
);

create table if not exists receitas(
	id_receita INT auto_increment primary key,
    nome_medicamento varchar(45),
    qtd_medicamento INT,
    instrucao varchar(100),
    consulta INT not null,
    foreign key(consulta) references consultas(id_consulta) on delete cascade on update cascade
);

create table if not exists enfermeiros(
	id_enfermeiro INT auto_increment primary key,
    nome_enfermeiro varchar(100) not null,
    cpf_enfermeiro varchar(20) unique not null,
    cre varchar(20) unique not null
);

create table if not exists internacoes(
	id_internacao INT auto_increment primary key,
    data_entrada varchar(20) not null,
    data_alta varchar(20) not null,
    historico text,
    numero_quarto int not null,
    paciente INT not null,
    medico INT not null,
    foreign key(paciente) references pacientes(id_paciente) on delete cascade on update cascade,
    foreign key(medico) references medicos(id_medico) on delete cascade on update cascade
);

create table if not exists escalas(
	id_escala INT auto_increment primary key,
    hora_escala time,
    data_escala date,
    enfermeiro INT not null,
    internacao INT not null,
    foreign key(enfermeiro) references enfermeiros(id_enfermeiro) on delete cascade on update cascade,
    foreign key(internacao) references internacoes(id_internacao) on delete cascade on update cascade
);

# Inserindo dados
INSERT INTO especialidades(id_especialidade, nome_especialidade) values(1, 'Clínica Geral');
INSERT INTO especialidades(id_especialidade, nome_especialidade) values(2, 'Cardiologia');
INSERT INTO especialidades(id_especialidade, nome_especialidade) values(3, 'Ortopedia');
INSERT INTO especialidades(id_especialidade, nome_especialidade) values(4, 'Pediatria');

INSERT INTO convenios(id_convenio, nome_convenio, cnpj_convenio, carencia) values(1,'Unimed', '12.345.678/0001-99', '90 dias');
INSERT INTO convenios(id_convenio, nome_convenio, cnpj_convenio, carencia) values(2,'Humanas', '98.765.432/0001-55', '60 dias');

INSERT INTO medicos (id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade, disponibilidade)
VALUES
(1, 'Dr. João Mendes', '11111111111', 'CRM-SP-12345', 'joao.mendes@email.com', 'Especialista', 1, 1),
(2, 'Dra. Paula Fernandes', '22222222222', 'CRM-RJ-23456', 'paula.fernandes@email.com', 'Generalista', 2, 1),
(3, 'Dr. Ricardo Alves', '33333333333', 'CRM-MG-34567', 'ricardo.alves@email.com', 'Residente', 3, 0), 
(4, 'Dra. Camila Rocha', '44444444444', 'CRM-BA-45678', 'camila.rocha@email.com', 'Especialista', 4, 1),
(5, 'Dr. Thiago Pereira', '55555555555', 'CRM-RS-56789', 'thiago.pereira@email.com', 'Generalista', 3, 0);

INSERT INTO pacientes (id_paciente, nome_paciente, cpf_paciente, data_nascimento, rg_paciente, email_paciente, convenio)
VALUES
(1, 'Ana Souza', '12345678901', '1990-05-15', 'MG-1234567', 'ana.souza@email.com', NULL),
(2, 'Carlos Lima', '23456789012', '1985-10-20', 'SP-2345678', 'carlos.lima@email.com', 1),
(3, 'Fernanda Silva', '34567890123', '1998-07-03', 'RJ-3456789', 'fernanda.silva@email.com', 2),
(4, 'José Oliveira', '45678901234', '1972-02-25', 'BA-4567890', 'jose.oliveira@email.com', NULL),
(5, 'Mariana Castro', '56789012345', '2001-12-10', 'RS-5678901', 'mariana.castro@email.com', 1);

INSERT INTO enfermeiros (id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre)
VALUES
(1, 'Ana Souza', '66666666666', 'CRE-PR-12345'),
(2, 'Carlos Oliveira', '77777777777', 'CRE-SC-23456'),
(3, 'Mariana Lima', '88888888888', 'CRE-PE-34567');

INSERT INTO consultas (id_consulta, valor_consulta, medico, paciente, especialidade, data_consulta, hora_consulta)
VALUES
(1, 200.00, 1, 1, 1, '2025-02-01', '09:30:00'),
(2, 250.00, 2, 2, 2, '2025-02-02', '10:00:00'),
(3, 180.00, 3, 3, 3, '2025-02-03', '11:15:00'),
(4, 220.00, 4, 4, 4, '2025-02-04', '14:00:00'),
(5, 300.00, 5, 5, 1, '2025-02-05', '16:45:00');

INSERT INTO receitas (id_receita, nome_medicamento, qtd_medicamento, instrucao, consulta)
VALUES
(1, 'Paracetamol', 10, 'Tomar 1 comprimido a cada 8h', 1),
(2, 'Losartana', 30, 'Tomar 1 comprimido por dia', 2),
(3, 'Ibuprofeno', 20, 'Tomar 1 comprimido a cada 6h', 3),
(4, 'Omeprazol', 15, 'Tomar 1 cápsula antes do café da manhã', 4),
(5, 'Amoxicilina', 21, 'Tomar 1 comprimido a cada 8h', 5);

INSERT INTO enfermeiros (id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre)
VALUES
(4, 'Fernanda Souza', '99999999999', 'CRE-SP-45678'),
(5, 'Roberto Mendes', '10101010101', 'CRE-RJ-56789'),
(6, 'Luciana Alves', '11111111111', 'CRE-MG-67890');

INSERT INTO internacoes (id_internacao, data_entrada, data_alta, historico, numero_quarto, paciente, medico)
VALUES
(1, '2025-01-24', '2025-02-10', 'Paciente com quadro de pneumonia grave.', 101, 1, 1),
(2, '2025-01-25', '2025-02-15', 'Paciente em recuperação pós-cirúrgica.', 102, 2, 2);

INSERT INTO escalas (id_escala, hora_escala, data_escala, enfermeiro, internacao)
VALUES
(1, '08:00:00', '2025-01-24', 1, 1),
(2, '16:00:00', '2025-01-24', 2, 1),
(3, '08:00:00', '2025-01-25', 3, 2),
(4, '16:00:00', '2025-01-25', 4, 2);

# Consultas

# Checar quem está internado
SELECT 
    i.id_internacao, 
    p.nome_paciente, 
    p.cpf_paciente, 
    i.numero_quarto, 
    i.data_entrada, 
    i.data_alta 
FROM 
    internacoes i
JOIN 
    pacientes p ON i.paciente = p.id_paciente
WHERE 
    i.data_alta >= CURDATE(); -- Garante que a alta ainda não ocorreu
    
    # Quais os pacientes de um médico específico (exemplo: Dr. João Mendes)?
SELECT 
    m.nome_medico, 
    p.nome_paciente, 
    p.cpf_paciente, 
    c.data_consulta, 
    c.hora_consulta 
FROM 
    consultas c
JOIN 
    medicos m ON c.medico = m.id_medico
JOIN 
    pacientes p ON c.paciente = p.id_paciente
WHERE 
    m.nome_medico = 'Dr. João Mendes';

# Quais as receitas escritas para um paciente específico (exemplo: Ana Souza)?
SELECT 
    p.nome_paciente, 
    r.nome_medicamento, 
    r.qtd_medicamento, 
    r.instrucao 
FROM 
    receitas r
JOIN 
    consultas c ON r.consulta = c.id_consulta
JOIN 
    pacientes p ON c.paciente = p.id_paciente
WHERE 
    p.nome_paciente = 'Ana Souza';

# Quais consultas estão marcadas para uma data específica (exemplo: 2025-02-02)
SELECT 
    c.data_consulta, 
    c.hora_consulta, 
    m.nome_medico, 
    p.nome_paciente, 
    e.nome_especialidade 
FROM 
    consultas c
JOIN 
    medicos m ON c.medico = m.id_medico
JOIN 
    pacientes p ON c.paciente = p.id_paciente
JOIN 
    especialidades e ON c.especialidade = e.id_especialidade
WHERE 
    c.data_consulta = '2025-02-02';

# Quais enfermeiros estão escalados para uma internação específica (exemplo: Internação ID 1)?
SELECT 
    e.nome_enfermeiro, 
    es.hora_escala, 
    es.data_escala 
FROM 
    escalas es
JOIN 
    enfermeiros e ON es.enfermeiro = e.id_enfermeiro
WHERE 
    es.internacao = 1;

# Quais pacientes estão associados a determinado convenio (Ex: Unimed)?
SELECT 
    p.nome_paciente, 
    p.cpf_paciente, 
    c.nome_convenio 
FROM 
    pacientes p
JOIN 
    convenios c ON p.convenio = c.id_convenio
WHERE 
    c.nome_convenio = 'Unimed';



