# consultas a realizar
use proyecto;
#Los 5 productos más vendidos por cantidad
SELECT 
    p.CategoriaProducto,
    SUM(t.Cantidad * CAST(p.PrecioProducto AS DECIMAL)) AS VentasTotales
FROM transacciones t
JOIN producto p ON t.IDproducto = p.IDproducto
GROUP BY p.CategoriaProducto
LIMIT 5;

#Consulta 1.1
SELECT 
    p.IDproducto,
    p.NombreProducto,
    SUM(t.Cantidad) as TotalUnidadesVendidas
FROM TRANSACCIONES t
JOIN PRODUCTO p ON t.IDproducto = p.IDproducto
GROUP BY p.IDproducto, p.NombreProducto
ORDER BY TotalUnidadesVendidas DESC
LIMIT 10;

#consulta 1.2
SELECT 
    p.IDproducto,
    p.NombreProducto,
    COALESCE(SUM(t.Cantidad), 0) as TotalUnidadesVendidas
FROM PRODUCTO p
LEFT JOIN TRANSACCIONES t ON p.IDproducto = t.IDproducto
GROUP BY p.IDproducto, p.NombreProducto
HAVING TotalUnidadesVendidas = 0 OR TotalUnidadesVendidas < 10 -- Ajustar el umbral según el negocio
ORDER BY TotalUnidadesVendidas ASC;

#consulta 2.1
SELECT
    tr.IDtienda, 
    ti.PaisTienda,
    ti.EstadoTienda,
    SUM(tr.Cantidad * p.PrecioProducto) as IngresoTotal
FROM transacciones tr
JOIN tiendas ti ON tr.IDtienda = ti.IDtienda
JOIN producto p ON tr.IDproducto = p.IDproducto
GROUP BY tr.IDtienda, ti.PaisTienda, ti.EstadoTienda 
ORDER BY IngresoTotal DESC;

#consulta 3.1
SELECT 
    p.IDproducto,
    p.NombreProducto,
    p.PrecioProducto,
    p.CostoProducto,
    (p.PrecioProducto - p.CostoProducto) as MargenUnitario,
    SUM(t.Cantidad) as TotalUnidadesVendidas,
    (p.PrecioProducto - p.CostoProducto) * SUM(t.Cantidad) as MargenBeneficioTotal
FROM PRODUCTO p
JOIN TRANSACCIONES t ON p.IDproducto = t.IDproducto
GROUP BY p.IDproducto, p.NombreProducto, p.PrecioProducto, p.CostoProducto
ORDER BY MargenBeneficioTotal DESC
LIMIT 10;
