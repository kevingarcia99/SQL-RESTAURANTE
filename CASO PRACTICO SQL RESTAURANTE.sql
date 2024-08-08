/* El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente acogedor.

Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando información 
detallada sobre las transacciones de los clientes para identificar áreas de oportunidad y 
aprovechar al máximo sus datos para optimizar las ventas.

Objetivo

Identificar cuáles son los productos del menú que han tenido más éxito y cuáles son los que menos 
han gustado a los clientes.*/

select * from order_details
select * from menu_items

- Encontrar el número de artículos en el menú
select count (menu_item_id)
from menu_items;
R= '32 artículos.'
- ¿Cuál es el artículo menos caro y el más caro en el menú?
select item_name,price from menu_items
where price=
	(select min(price) from menu_items);
R='Edamame'
select item_name,price from menu_items
where price=
	(select max (price) from menu_items);
R='Shrimp Scampi'
- ¿Cuántos platos americanos hay en el menú?
select count (menu_item_id)
from menu_items
where category='American';
R='6'
- ¿Cuál es el precio promedio de los platos?
select round (avg(price))
from menu_items;
R='13'
- ¿Cuántos pedidos únicos se realizaron en total?
select * from order_details
select count (distinct order_id)
from order_details; 
R='5,370'
- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
select * from order_details
select order_id, count (order_details_id) as total_items
from order_details
group by order_id
order by total_items desc
limit 5;
R= 'La orden 443, 1957, 330, 440 y 2675 con un total de 14 artículos.'

- ¿Cuándo se realizó el primer pedido y el último pedido?
select * from order_details
order by order_date, order_time;
R='Primero: 2023-01-01 11:38:36'
select * from order_details
order by order_date desc, order_time desc;
R='Último: 2023-03-31 22:15:48'
- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
select count (distinct (order_id))
from order_details
where order_date between '2023-01-01' and '2023-01-05';
R='308'
	
Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

1- Realizar un left join entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).

select * from order_details as o
left join menu_items as m
on o.item_id = m.menu_item_id
	
Una vez que hayas explorado los datos en las tablas correspondientes y respondido
las preguntas planteadas, realiza un análisis adicional utilizando este join entre 
tablas. El objetivo es identificar 5 puntos clave que puedan ser de utlidad para los
dueños del restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias
consultas y utiliza los resultados obtenidos para llegar a estas conclusiones. */
	
select m.menu_item_id, count (menu_item_id) as total_pedidos
	from menu_items as m
	left join order_details as o
	on m.menu_item_id = o.item_id
	group by menu_item_id,item_id
	order by total_pedidos asc;

R='El artículo que se pidió en menor cantidad fue el Chicken Tacos de la categoría Mexican por lo que se recomienda
introducirlos en alguna promoción o modificarlo/eliminarlo para así poder tener un mayor número de ventas y generen mayor rendimiento.'

select m.menu_item_id,
m.item_name,
m.price,
count (o.item_id)as cantidad_total_vendida,
count (o.item_id) * m.price as ingreso_total
from order_details as o
join menu_items as m 
on m.menu_item_id=o.item_id
group by m.menu_item_id, m.price
order by ingreso_total desc
limit 3;

R='El platillo más fuerte que tiene el restaurante "Sabores del Mundo" es el Korean Beef Bowl, ya que es el tercer platillo
más pedido por los clientes y debido a su precio es el platillo que genera más ingresos para el restaurante.'

select m.category, count (o.order_details_id) as total_pedidos
from order_details as o
join menu_items as m 
on o.item_id = m.menu_item_id
group by m.category
Order by total_pedidos desc;

R='La categoría de comida que más se solicita en el restaurante es Asian, incrementar el número de platillos de esta 
categoría puede aumentar las ventas pues es el tipo de comida más pedida.'

select m.menu_item_id,item_name, count (menu_item_id) as cantidad_total_vendida
	from menu_items as m
	left join order_details as o
	on m.menu_item_id = o. item_id
	group by menu_item_id,item_id
	order by cantidad_total_vendida desc;

R='Los artículos más vendidos fueron Hamburger, Edamame, Korean Beef Bowl, utilizar la fama de estos productos y meterlos
en promociones o en la publicidad puede lograr que la gente realice más compras de éstos y generar más rendimiento.'

SELECT m.menu_item_id,
       m.item_name,
       COUNT(DISTINCT o.order_date) AS cantidad_dias_pedidos
FROM order_details as o
JOIN menu_items as m
ON o.item_id = m.menu_item_id
GROUP BY m.menu_item_id, m.item_name
order by cantidad_dias_pedidos desc;

R='Existieron 12 artículos que se pidieron todos los días durante los 3 meses que se están analizando, por lo que se sugiere
tener siempre los insumos necesarios para la preparación de estos alimentos de manera diaria pues su demanda es muy alta.
Los platillos son los siguientes:
	- Hamburger
	- Cheeseburger
	- French Fries
	- Tofu Pad Thai
	- Korean Beef Bowl
	- Edamame
	- Steak Burrito
	- Chicken Torta
	- Steak Torta
	- Chips & Salsa
	- Spaghetti & Meatballs
	- Eggplant Parmesan'


