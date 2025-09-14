ETAPA 1: MAPEAMENTO CONCEITUAL


Fornecedor     


id_fornecedor (PK)


nome_fornecedor


contato


endereço


tipo_material






Receita Técnica


id_receita (PK)


nome_receita






Lote de Produção


id_lote (PK)


data_producao


quantidade (toneladas)


status (produzido, entregue, cancelado)


id_receita (FK)


id_cliente (FK)








Funcionário Operador


id_funcionario (PK)


nome_funcionario


cargo






Cliente Final


id_cliente (PK)


nome_cliente


CNPJ/CPF


telefone


endereco


 
Veículo de Transporte  


id_veiculo (PK)


tipo (betoneira, caminhão, etc.)


modelo


placa


capacidade (toneladas)