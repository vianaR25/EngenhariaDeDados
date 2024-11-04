SELECT nomecliente, genero
FROM cliente;

SELECT nomeproduto,preco
FROM produto;

SELECT idcompra,dtcompra
FROM compras;

SELECT nomecliente,cidade,estadocivil
FROM cliente;

SELECT * FROM cliente;

SELECT nomecliente,estadocivil
FROM cliente
ORDER BY nomecliente ASC;
-- Exemplo
SELECT nomecliente,estadocivil
FROM cliente
ORDER BY rand(), nomecliente
LIMIT 1 ;

SELECT nomeproduto
FROM produto
ORDER BY preco DESC;

SELECT nomecliente,estado,cidade
FROM cliente
ORDER BY estado ,cidade;


SELECT DISTINCT estado
FROM cliente;


SELECT DISTINCT dtcompra
FROM compras;

SELECT nomeproduto
 FROM produto
WHERE preco > 5;


SELECT nomecliente, estadocivil
FROM cliente
WHERE genero = 'F';


SELECT 	nomecliente,cidade
FROM cliente
WHERE estado = 'Rio de Janeiro';

SELECT nomecliente,dtnascimento
FROM cliente
WHERE dtnascimento < '2004-10-21';

SELECT nomecliente, TIMESTAMPDIFF(YEAR, dtnascimento, CURDATE()) AS idade 
FROM cliente
WHERE TIMESTAMPDIFF(YEAR, dtnascimento, CURDATE()) >20
ORDER BY idade;

SELECT DISTINCT idcliente
 FROM compras
WHERE dtcompra BETWEEN '2021-01-01' AND '2021-12-31';

SELECT DISTINCT idcliente
FROM compras
WHERE EXTRACT(YEAR FROM dtcompra) = 2020;

SELECT nomecliente
 FROM cliente
WHERE nomecliente LIKE 'A%';

SELECT nomecliente
 FROM cliente
WHERE nomecliente LIKE '%Ana%';

 SELECT nomecliente,estadocivil,estado
 FROM cliente
WHERE estado IN ('Rio de Janeiro', 'Sao Paulo', 'Espirito Santo','Minas Gerais');

Select nomecliente,
CASE
WHEN estadocivil = 'V' THEN 'VIUVO'
WHEN estadocivil = 'D' THEN 'DIVORCIADO'
WHEN estadocivil = 'S' THEN 'SOLTEIRO'
WHEN estadocivil = 'C' THEN 'CASASO'
ELSE 'Não Encontrado'
END AS estadocivil
FROM cliente;


SELECT p.nomeproduto, m.nomemarca
 FROM produto AS p, marca AS m
WHERE p.idmarca = m.idmarca;


SELECT c.nomecliente,p.nomeproduto
FROM produto AS p, cliente AS c, compras AS co
WHERE co.idcliente= c.idcliente
AND p.idproduto= co.idproduto;


SELECT cl.nomecliente,cl.estado,l.nomeloja,l.uf,co.qtd,p.nomeproduto
FROM cliente AS cl, loja AS l , compras AS co, produto AS p
WHERE cl.idcliente = co.idcliente
AND l.idloja=co.idloja
AND p.idproduto = co.idproduto
AND co.qtd > 40;

SELECT p.nomeproduto,p.preco,m.nomemarca
FROM produto as P 
INNER JOIN marca AS M 
ON p.idmarca = m.idmarca;

SELECT m.nomemarca,c.dtcompra,c.qtd
FROM marca AS m INNER JOIN produto AS p
ON m.idmarca = p.idmarca
INNER JOIN compras AS c
ON p.idproduto = c.idproduto ;

SELECT c.nomecliente,p.nomeproduto,co.qtd
FROM cliente AS c INNER JOIN compras AS co
ON c.idcliente = co.idcliente
INNER JOIN produto AS p
ON co.idproduto = p.idproduto;


INSERT INTO cliente
(idcliente,nomecliente,genero,estadocivil,dtnascimento,cidade,estado)
VALUES
(501, 'Alba', 'F', 'V', '1982/10/25', 'Duque de Caxias','Rio de Janeiro'),
(502, 'Solimar', 'F', 'V', '1972/11/25', 'Niterói','Rio de Janeiro'),
(503, 'Pablo', 'M', 'C', '1999/03/01', 'Nova Iguaçu','Rio de Janeiro'),
(504, 'Solange', 'F', 'S', '1979/06/05', 'Salvador', 'Bahia'),
(505, 'Mário', 'M', 'S', '1985/07/22', 'Bragança Paulista', 'São Paulo');

SELECT cliente.nomecliente,compras.idcompra
FROM cliente LEFT JOIN compras
ON cliente.idcliente= compras.idcliente;

INSERT INTO marca (idmarca,nomemarca)
VALUES
(6,'Delícia de Prato'),
(7,'Pajé');

SELECT marca.nomemarca, produto.nomeproduto
FROM produto RIGHT JOIN marca
ON produto.idmarca=marca.idmarca;


 SELECT MAX(preco)
 FROM produto ;

SELECT MIN(qtd)
FROM compras;

SELECT ROUND(AVG (qtd),2)
FROM compras ;

SELECT COUNT(*)
FROM cliente
WHERE estado = 'Rio de Janeiro';

SELECT ROUND(AVG (preco),2) As precomedio
FROM produto;

SELECT count(*)
FROM marca as ma INNER JOIN produto AS pr
ON pr.idmarca = ma.idmarca
INNER JOIN compras AS co
ON co.idproduto = pr.idproduto
WHERE ma.nomemarca = 'Bom Prato';

SELECT SUM(co.qtd) AS produtocomprado
FROM loja as lo INNER JOIN compras AS co
ON lo.idloja= co.idloja
WHERE lo.nomeloja = 'Vale Verde';


SELECT SUM(co.qtd) AS produtocomprado
FROM loja as lo INNER JOIN compras AS co
ON lo.idloja =co.idloja
WHERE lo.uf= 'MG';

SELECT SUM(qtd) 
FROM produto as pr INNER JOIN compras AS co
ON pr.idproduto = co.idproduto
WHERE pr.nomeproduto = 'Macarrao';

SELECT SUM(qtd)
FROM compras;


UPDATE produto 
SET nomeproduto = 'macarrao'
where idproduto = 5 ;

SELECT estado,COUNT(*)
FROM cliente
GROUP BY estado
ORDER BY estado ASC ;

SELECT UF ,COUNT(*)
FROM loja
GROUP BY UF;



SELECT nomemarca , COUNT(pr.idproduto)
FROM marca as ma INNER JOIN produto AS pr
ON ma.idmarca = pr.idmarca
GROUP BY nomemarca;

SELECT nomemarca ,CONCAT('R$', SUM(co.qtd*pr.preco)) as valortotal
FROM marca as ma INNER JOIN produto AS pr
ON ma.idmarca = pr.idmarca
INNER JOIN compras as co
ON co.idproduto = pr.idproduto
GROUP BY nomemarca
ORDER BY valor DESC;


SELECT nomeproduto ,ROUND(AVG(co.QTD),2) as mediavenda
FROM compras as co INNER JOIN produto as pr
ON co.idproduto= pr.idproduto
GROUP BY nomeproduto;

SELECT lo.nomeloja , SUM(co.qtd *pr.preco) AS faturamenti
FROM loja AS lo INNER JOIN compras AS co
ON lo.idloja = co.idloja
INNER JOIN produto AS pr
ON pr.idproduto = co.idproduto
GROUP BY lo.nomeloja
ORDER BY faturamento DESC;

SELECT cl.nomecliente ,SUM(co.qtd) AS TOTAL
FROM cliente AS cl INNER JOIN compras AS co
ON cl.idcliente = co.idcliente
GROUP BY cl.nomecliente
ORDER BY TOTAL DESC;



SELECT cidade, COUNT(idcliente) AS qtdcliente
FROM cliente
GROUP BY cidade
ORDER BY qtdcliente  DESC
LIMIT 5;


SELECT pr.nomeproduto , SUM(co.qtd) as total
FROM produto as pr INNER JOIN compras as co
ON pr.idproduto = co.idproduto
GROUP BY pr.nomeproduto
ORDER BY total desc;

SELECT cl.nomecliente, SUM(co.qtd*pr.preco) as gasto
FROM cliente AS cl INNER JOIN compras AS co
ON cl.idcliente = co.idcliente
INNER JOIN produto AS pr
ON pr.idproduto = co.idproduto
GROUP BY cl.nomecliente
ORDER BY gasto desc
LIMIT 5;


SELECT estado,COUNT(*) AS qtdcliente
FROM cliente
GROUP BY estado
HAVING qtdcliente > 50
ORDER BY estado ASC;

SELECT nomemarca , SUM(co.qtd*pr.preco) as valortotal
FROM marca as ma INNER JOIN produto AS pr
ON ma.idmarca = pr.idmarca
INNER JOIN compras as co
ON co.idproduto = pr.idproduto
GROUP BY nomemarca
HAVING valortotal >25000
ORDER BY valortotal DESC;

-- EX23 PEGAR DO PROFESSOR

-- 24
SELECT nomeproduto
FROM produto
WHERE preco =
		(SELECT MAX(preco)
        FROM produto);
        
SELECT nomecliente
FROM cliente
WHERE idcliente NOT IN (SELECT DISTINCT idcliente FROM compras);

SELECT nomeproduto
FROM produto 
WHERE idproduto NOT IN ( SELECT DISTINCT idproduto from compras where dtcompra BETWEEN '2021-01-01' AND '2021-12-31');


CREATE view vw_produto_marca AS
SELECT pr.nomeproduto, pr.preco,ma.nomemarca
FROM  produto as pr INNER JOIN marca as ma
On pr.idmarca = ma.idmarca
ORDER BY pr.nomeproduto ;


CREATE OR REPLACE VIEW visao_total AS
SELECT co.idcompra ,cl.nomecliente,pr.nomeproduto, ma.nomemarca, lo.nomeloja,co.dtcompra,co.qtd,pr.preco,pr.preco* co.qtd AS total
FROM compras AS co INNER JOIN cliente as cl
ON co.idcliente= cl.idcliente
INNER JOIN produto as pr
ON pr.idproduto = co.idproduto
INNER JOIN marca as ma
ON ma.idmarca = pr.idmarca
INNER JOIN  loja as lo
ON lo.idloja = co.idloja;




