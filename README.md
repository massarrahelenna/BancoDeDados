# BancoDeDados

Correções no Código Estacionamento:

Não mudamos nada, pois já está tudo em pt-br.

Achamos melhor manter a foreign key id_professor, para manter o encadeamento de todas as tabelas com a tabela professor. 

Criamos índices para status e para nome, em vez de email, pois faz mais sentido dentro no nosso código

Adicionamos CHECKS em  ano, valor_mensal, data_reportagem e data_hora_saida.
 
Os valores ENUM e status_pagamento nunca vão mudar, portanto usá-los na mesma tabela é suficiente.
 
Sugestão implementada


