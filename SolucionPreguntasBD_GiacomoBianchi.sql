/*cantidad de registro tabla vuelos  (2972)*/
SELECT COUNT(*) FROM usairlineflights2.flights;

/*avg retraso salida y reso llegada segundo aerop origen*/
SELECT Origin, AVG(ArrDelay), AVG(DepDelay) FROM usairlineflights2.flights GROUP BY Origin ORDER BY Origin desc;

/*Retraso promedio de llegada de los vuelos, por meses y según el aeropuerto origen. Además,
quieren que los resultado se muestren de la siguiente forma (fíjate en el orden de las filas):*/
SELECT Origin, colYear, colMonth,  
if (AVG(ArrDelay)>=1, 'RETRASO','')
FROM usairlineflights2.flights  WHERE ArrDelay >=1
GROUP BY Origin, colYear, colMonth ORDER BY Origin, colYear, colMonth;

/*Retraso promedio de llegada de los vuelos, por meses y según el aeropuerto origen
(Misma consulta que antes y con el mismo orden). Pero además, ahora quieren que en vez del código 
del aeropuerto se muestra el nombre de la ciudad.*/
SELECT City, colYear, colMonth, if (AVG(ArrDelay)>=1,'RETRASO','')
FROM usairlineflights2.flights
INNER JOIN usairlineflights2.usairports on usairlineflights2.flights.Origin =
usairlineflights2.usairports.IATA WHERE ArrDelay >=1
GROUP BY City, colYear, colMonth ORDER BY City, colYear, colMonth;

/*El identificador de los 10 aviones que más distancia han recorrido haciendo vuelos.*/
Select sum(distance) AS distance, TailNum FROM usairlineflights2.flights where TailNum != 'NA'
group by TailNum order by distance desc limit 10;

/*Compañías con su retraso promedio sólo de aquellas las que sus vuelos llegan 
a su destino con un retraso promedio mayor de 10 minutos.*/
SELECT Description, AVG(ArrDelay)
FROM usairlineflights2.flights LEFT JOIN usairlineflights2.carriers on usairlineflights2.flights.UniqueCarrier =
usairlineflights2.carriers.CarrierCode WHERE ArrDelay > 10
GROUP BY Description ORDER BY AVG(ArrDelay);
