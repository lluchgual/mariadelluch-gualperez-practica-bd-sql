--MARÍA DE LLUCH GUAL PÉREZ

--PRÁCTICA MODELADO Y SQL 
-- Script con la consulta SQL solicitada.


--Crear una consulta SQL para sacar el siguiente listado de coches activos que hay en KeepCoding:

-- *Nombre modelo, marca y grupo de coches (los nombre de todos)
-- *Fecha de compra
-- *Matricula
-- *Nombre del color del coche
-- *Total kilómetros
-- *Nombre empresa que esta asegurado el coche
-- *Numero de póliza


create schema lgp_consulta authorization gxrphjip;

-- SELECT CON JOIN ---

select  v.id_vehicle as "ID_VEHICLE",
		m.model_name || ' / ' || b.brand_name || ' / ' || g.group_name as "Nombres de Modelo / Marca / Grupo", 
		v.dt_purchase as "Fecha de compra", 
		v.reg_plate as "Matrícula", 
		c.color_name as "Color", 
		v.total_km as "Total Kms", 
		ic.insurance_company_name as "Empresa aseguradora", 
		ip.number_policy as "Número de póliza"
		
from lgp.vehicles_kc v
left join lgp.car_models m on v.id_model = m.id_model 
left join lgp.car_brands b on m.id_brand = b.id_brand 
left join lgp.car_groups g on b.id_group = g.id_group
left join lgp.car_colors c on v.id_color = c.id_color
left join lgp.insurance_policies_vehicle ip on v.id_vehicle = ip.id_vehicle  
left join lgp.insurance_companies ic  on ip.id_insurance_company  = ic.id_insurance_company  
where ip.dt_end > CURRENT_DATE;
