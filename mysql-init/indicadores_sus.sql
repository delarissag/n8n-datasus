CREATE TABLE IF NOT EXISTS log_processamento_arquivos (
    nome_arquivo VARCHAR(255) PRIMARY KEY,
    data_processamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS populacao_municipios (
    ano VARCHAR(4),
    municipio VARCHAR(10),
    populacao_total INT DEFAULT 0,
    populacao_6_12 INT DEFAULT 0,
    PRIMARY KEY (ano, municipio)
);

CREATE TABLE IF NOT EXISTS producao_odonto_consolidada (
    data DATE,
    municipio VARCHAR(10),
    ind01_num_prim_consulta INT DEFAULT 0,
    ind02_num_trat_concluido INT DEFAULT 0,
    ind02_den_prim_consulta INT DEFAULT 0,
    ind03_num_exodontias INT DEFAULT 0,
    ind03_den_total_clinicos INT DEFAULT 0,
    ind04_num_escovacao_6_12 INT DEFAULT 0,
    ind05_num_preventivos INT DEFAULT 0,
    ind05_den_total_individuais INT DEFAULT 0,
    ind06_num_tra_art INT DEFAULT 0,
    ind06_den_restauradores INT DEFAULT 0,
    PRIMARY KEY (data, municipio)
);
