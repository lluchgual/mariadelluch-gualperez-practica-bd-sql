--MARÍA DE LLUCH GUAL PÉREZ

--PRÁCTICA MODELADO Y SQL 
-- Script con los comandos DDL, para la creación del modelo diseñado, y comandos DML, para cargar las tablas.

--Organización del script:
--1. DDL: creación del modelo.
--2. DML: introducción de datos en las tablas.


--------------------------------------------------------------------------------------------------------------
--1. DDL: creación del modelo.

--CREAR ESQUEMA (NO PUBLICO). 
--'lgp'- iniciales de nombre de alumna.
create schema lgp authorization gxrphjip; 

--CREAR TABLAS.
--Se crean tablas, así como las PK y FK de cada tabla.

--El modelo tiene 9 tablas: 
--	** VEHICLES_KC 
--	** CAR_COLORS
--	** CAR_MODELS 
--	** CAR_BRANDS
--	** CAR_GROUPS
--	** INSURANCE_POLICIES_VEHICLE
--	** INSURANCE_COMPANIES
--	** CAR_MAINTENANCE_HISTORY
--	** CURRENCIES


--DEFINIR CAR_GROUPS
create table lgp.car_groups(
	id_group varchar(20) not null, --PK , e.g.'G001'
	group_name varchar(200) not null, 
	description varchar(512) null
);	

--PK CAR_GROUPS
alter table lgp.car_groups
add constraint car_groups_PK primary key (id_group);




--DEFINIR CAR_BRANDS
create table lgp.car_brands(
	id_brand varchar(20) not null, --PK, e.g.'B001'
	id_group varchar(20) not null, --FK 
	brand_name varchar(200) not null, 
	description varchar(512) null
);	

--PK CAR_BRANDS
alter table lgp.car_brands
add constraint car_brands_PK primary key (id_brand);

--FK CAR_BRANDS
alter table lgp.car_brands
add constraint car_brands_id_group_FK foreign key (id_group)
references lgp.car_groups(id_group);




--DEFINIR CAR_MODELS
create table lgp.car_models(
	id_model varchar(20) not null, --PK, e.g.'M001'
	id_brand varchar(20) not null, --FK
	model_name varchar(200) not null, 
	description varchar(512) null
);

--PK CAR_MODELS
alter table lgp.car_models
add constraint car_models_PK primary key (id_model);

--FK CAR_MODELS
alter table lgp.car_models
add constraint car_models_id_brand_FK foreign key (id_brand)
references lgp.car_brands(id_brand);



-- DEFINIR CAR_COLORS 
create table lgp.car_colors(
	id_color varchar(20) not null, --PK, e.g.'C001'
	color_name varchar(200) not null, 
	description varchar(512) null
);

--PK CAR_COLORS
alter table lgp.car_colors
add constraint car_colors_PK primary key (id_color);




--DEFINIR VEHICLES_KC
create table lgp.vehicles_kc(
	id_vehicle varchar(20) not null, --PK, e.g.'V001'
	id_model varchar(20) not null, --FK
	id_color varchar(20) not null, --FK
	dt_purchase date not null default '4000-01-01',
	reg_plate varchar(20) not null, 
	total_km integer not null,
	description varchar(512) null
);

--PK VEHICLES_KC
alter table lgp.vehicles_kc
add constraint vehicles_kc_PK primary key (id_vehicle);

--FK VEHICLES_KC
alter table lgp.vehicles_kc
add constraint vehicles_kc_id_model_FK foreign key (id_model)
references lgp.car_models(id_model);

alter table lgp.vehicles_kc
add constraint vehicles_kc_id_color_FK foreign key (id_color)
references lgp.car_colors(id_color);



-- DEFINIR CURRENCIES
create table lgp.currencies(
	id_currency varchar(20) not null, --PK, e.g.'CU001')
	currency_name varchar(200) not null, 
	description varchar(512) null
);

--PK CURRENCIES
alter table lgp.currencies
add constraint id_currency_PK primary key (id_currency);



--DEFINIR CAR_MAINTENANCE_HISTORY
create table lgp.car_maintenance_history(
	id_vehicle varchar(20) not null, --PK, FK
	id_inspection integer not null, --PK, e.g.'001'
	id_currency varchar(20) not null default 'CU001', --FK
	dt_revision date not null default '4000-01-01',
	km integer not null, 
	amount_inspection decimal not null, 
	description varchar(512) null
);

--PK CAR_MAINTENANCE_HISTORY
alter table lgp.car_maintenance_history
add constraint car_maintenance_history_PK primary key (id_vehicle, id_inspection);

--FK CAR_MAINTENANCE_HISTORY
alter table lgp.car_maintenance_history
add constraint car_maintenance_history_id_vehicle_FK foreign key (id_vehicle)
references lgp.vehicles_kc(id_vehicle);

alter table lgp.car_maintenance_history
add constraint car_maintenance_history_id_currency_FK foreign key (id_currency)
references lgp.currencies(id_currency);




--DEFINIR INSURANCE_COMPANIES
create table lgp.insurance_companies(
	id_insurance_company varchar(20) not null, --PK, e.g. 'IC001'
	insurance_company_name varchar(200) not null, 
	description varchar(512) null
);	

--PK INSURANCE_COMPANIES 
alter table lgp.insurance_companies
add constraint insurance_companies_PK primary key (id_insurance_company);




--DEFINIR INSURANCE_POLICIES_VEHICLE
create table lgp.insurance_policies_vehicle(
	id_vehicle  varchar(20) not null, --PK, FK
	number_policy varchar(200) not null, --PK 
	id_insurance_company  varchar(20) not null, --FK
	dt_start date not null default '4000-01-01',
	dt_end date not null default '4000-01-01',
	description varchar(512) null
);

--PK INSURANCE_POLICIES_VEHICLE
alter table lgp.insurance_policies_vehicle
add constraint insurance_policies_vehicle_PK primary key (id_vehicle, number_policy);

--FK INSURANCE_POLICIES_VEHICLE
alter table lgp.insurance_policies_vehicle
add constraint insurance_policies_vehicle_id_vehicle_FK foreign key (id_vehicle)
references lgp.vehicles_kc(id_vehicle);

alter table lgp.insurance_policies_vehicle
add constraint insurance_policies_vehicle_id_insurance_company_FK foreign key (id_insurance_company)
references lgp.insurance_companies(id_insurance_company);





--------------------------------------------------------------------------------------------------------------
--2. DML: introducción de datos en las tablas.

--INSERTAR DATOS DE CAR_GROUPS

insert into lgp.car_groups(id_group, group_name, description) values('G001','BMW Group','');
insert into lgp.car_groups(id_group, group_name, description) values('G002','Toyota Motor Corporation','');
insert into lgp.car_groups(id_group, group_name, description) values('G003','Stellantis','');
insert into lgp.car_groups(id_group, group_name, description) values('G004','Volkswagen Group',''); 
insert into lgp.car_groups(id_group, group_name, description) values('G005','Renault–Nissan–Mitsubishi Alliance','');


--INSERTAR DATOS DE CAR_BRAND

insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B001','G001','BMW','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B002','G001','Mini','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B003','G002','Toyota','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B004','G002','Lexus','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B005','G003','Peugeot','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B006','G003','Opel','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B007','G003','Citroën','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B008','G004','Volkswagen','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B009','G004','SEAT','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B010','G005','Renault','');
insert into lgp.car_brands(id_brand, id_group, brand_name,description) values('B011','G005','Dacia','');


--INSERTAR DATOS DE CAR_MODELS

insert into lgp.car_models(id_model, id_brand, model_name, description) values('M001','B001','Serie 1','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M002','B002','Countryman','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M003','B003','Aygo','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M004','B003','Corolla','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M005','B004','CT 200h','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M006','B005','3008','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M007','B006','Corsa','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M008','B007','C3','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M009','B008','T-Cross','Hybrid');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M010','B009','Ibiza','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M011','B010','Clio','');
insert into lgp.car_models(id_model, id_brand, model_name, description) values('M012','B011','Duster','4x4');



--INSERTAR DATOS DE CAR_COLORS

insert into lgp.car_colors(id_color, color_name, description) values('C001','White','');
insert into lgp.car_colors(id_color, color_name, description) values('C002','Black','');
insert into lgp.car_colors(id_color, color_name, description) values('C003','Grey','');
insert into lgp.car_colors(id_color, color_name, description) values('C004','Silver','Metallic color');
insert into lgp.car_colors(id_color, color_name, description) values('C005','Azul','');
insert into lgp.car_colors(id_color, color_name, description) values('C006','Rojo','');
insert into lgp.car_colors(id_color, color_name, description) values('C007','Orange','');



--INSERTAR DATOS DE CURRENCIES

insert into lgp.currencies(id_currency, currency_name, description) values('CU001','EUR','Eurozone');
insert into lgp.currencies(id_currency, currency_name, description) values('CU002','USD','USA');
insert into lgp.currencies(id_currency, currency_name, description) values('CU003','GBP','Great Bretain');



--INSERTAR DATOS DE INSURANCE_COMPANIES

insert into lgp.insurance_companies(id_insurance_company, insurance_company_name, description) values('IC001','Mutua Madrileña','');
insert into lgp.insurance_companies(id_insurance_company, insurance_company_name, description) values('IC002','MAPFRE','');
insert into lgp.insurance_companies(id_insurance_company, insurance_company_name, description) values('IC003','AXA','');
insert into lgp.insurance_companies(id_insurance_company, insurance_company_name, description) values('IC004','Pelayo Mutua de Seguros','');





--INSERTAR DATOS DE VEHICLES_KC

insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V001','M012','C005','2021-10-09','1290KC1',29567,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V002','M010','C001','2021-10-14','9800KC1',20003,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V003','M011','C007','2021-11-19','8620KC2',19808,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V004','M002','C006','2021-11-30','89C9K34',35050,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V005','M002','C002','2021-11-30','9000KC2',21203,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V006','M004','C004','2021-12-04','AS03KC2',15006,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V007','M008','C005','2021-12-05','9883KC2',24702,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V008','M001','C003','2022-01-08','2000KC3',29567,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V009','M005','C001','2022-02-14','3091KC3',20003,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V010','M003','C004','2022-02-28','4555KC3',19808,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V011','M009','C006','2022-04-17','6812KC3',28050,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V012','M006','C005','2022-06-20','8432KC3',12003,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V013','M012','C007','2022-09-12','2382KC4',04721,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V014','M007','C002','2022-10-24','3645KC4',01589,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V015','M011','C007','2021-11-21','4444KC4',00618,'');
insert into lgp.vehicles_kc(id_vehicle, id_model, id_color, dt_purchase, reg_plate, total_km, description) values('V016','M008','C006','2021-11-21','4446KC2',00800,'');






--INSERTAR DATOS DE INSURANCE_POLICIES_VEHICLE

insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V001','88273997','IC004','2021-10-09','2022-10-08','cancelled');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V001','35278982','IC002','2022-10-09','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V002','59848445','IC004','2021-10-14','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V003','35179305','IC002','2021-11-19','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V004','95733537','IC004','2021-11-30','2022-11-29','cancelled');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V004','37932888','IC002','2022-11-30','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V005','19378934','IC001','2021-11-30','2022-11-29','cancelled');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V005','25930439','IC003','2022-11-30','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V006','32496030','IC002','2021-12-04','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V007','59848445','IC004','2021-12-05','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V008','35179305','IC002','2022-01-08','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V009','59848445','IC004','2022-02-14','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V010','35179305','IC002','2022-02-28','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V011','59848445','IC004','2022-04-17','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V012','35179305','IC002','2022-06-20','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V013','59848445','IC004','2022-09-12','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V014','35179305','IC002','2022-10-24','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V015','59848445','IC004','2022-11-21','4000-01-01','');
insert into lgp.insurance_policies_vehicle(id_vehicle, number_policy, id_insurance_company, dt_start, dt_end, description) values('V016','35179305','IC002','2022-11-21','4000-01-01','');



--INSERTAR DATOS DE CAR_MAINTENANCE_HISTORY
--Solo han recibido mantenimiento los coches que han cumplido un año.

insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V001','001','CU001','19089', 120.50,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V002','001','CU001','19890', 120.50,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V002','002','CU001','19089', 120.50,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V003','001','CU001','19976', 120.50,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V004','001','CU002','19965', 230.00,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V005','001','CU001','19893', 120.50,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V006','001','CU003','19089', 178.00,'1 year');
insert into lgp.car_maintenance_history (id_vehicle, id_inspection, id_currency, km, amount_inspection, description) values('V007','001','CU001','19967', 120.50,'1 year');


