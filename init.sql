-- 1) Borrar la base de datos si existe
DROP DATABASE IF EXISTS turismodb;

-- 2) Crear la base de datos con parámetros por defecto
CREATE DATABASE turismodb;
\c turismodb

-- 3) Habilitar PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- 4) Crear tablas e índices
CREATE TABLE zonas_turisticas (
  id SERIAL PRIMARY KEY,
  nombre_zona VARCHAR(100),
  tipo_zona VARCHAR(50),
  descripcion TEXT,
  geom geometry(Polygon,4326)
);
CREATE TABLE lugares_turisticos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  tipo VARCHAR(50),
  direccion VARCHAR(150),
  ciudad VARCHAR(100),
  horario_apertura VARCHAR(20),
  horario_cierre VARCHAR(20),
  precio_entrada NUMERIC(8,2),
  zona_id INTEGER REFERENCES zonas_turisticas(id),
  ubicacion geometry(Point,4326)
);
CREATE INDEX ON zonas_turisticas USING GIST(geom);
CREATE INDEX ON lugares_turisticos USING GIST(ubicacion);

-- 5) Insertar 60 zonas turísticas
INSERT INTO zonas_turisticas(nombre_zona, tipo_zona, descripcion, geom) VALUES
('Bosque de Chapultepec','Parque urbano','Gran parque historico de CDMX',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1900 19.4170,-99.1770 19.4170,-99.1770 19.4270,-99.1900 19.4270,-99.1900 19.4170)')),4326)),
('Condesa','Barrio urbano','Zona hipster de CDMX',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1750 19.4070,-99.1610 19.4070,-99.1610 19.4170,-99.1750 19.4170,-99.1750 19.4070)')),4326)),
('Coyoacan','Barrio historico','Barrio bohemio de CDMX',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1650 19.3480,-99.1500 19.3480,-99.1500 19.3620,-99.1650 19.3620,-99.1650 19.3480)')),4326)),
('San Angel','Barrio historico','Zona cultural y museos',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1980 19.3450,-99.1830 19.3450,-99.1830 19.3570,-99.1980 19.3570,-99.1980 19.3450)')),4326)),
('Centro Historico CDMX','Barrio historico','Corazon de la capital',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1450 19.4280,-99.1250 19.4280,-99.1250 19.4420,-99.1450 19.4420,-99.1450 19.4280)')),4326)),
('Polanco','Barrio urbano','Zona de negocios y museos',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.2120 19.4300,-99.1860 19.4300,-99.1860 19.4460,-99.2120 19.4460,-99.2120 19.4300)')),4326)),
('Zona Rosa','Barrio urbano','Zona de vida nocturna',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1700 19.4240,-99.1570 19.4240,-99.1570 19.4340,-99.1700 19.4340,-99.1700 19.4240)')),4326)),
('Santa Fe','Distrito financiero','Rascacielos y centros comerciales',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.2600 19.3650,-99.2380 19.3650,-99.2380 19.3830,-99.2600 19.3830,-99.2600 19.3650)')),4326)),
('Paseo de la Reforma','Avenida principal','Corredor cultural y financiero',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1860 19.4270,-99.1700 19.4270,-99.1700 19.4410,-99.1860 19.4410,-99.1860 19.4270)')),4326)),
('Xochimilco','Zona natural','Canales y trajineras',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1100 19.2500,-99.0800 19.2500,-99.0800 19.2700,-99.1100 19.2700,-99.1100 19.2500)')),4326)),
('Roma y Centro','Ruta cultural','Iglesias y plazas en Roma Italia',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(12.4800 41.8800,12.5000 41.8800,12.5000 41.9000,12.4800 41.9000,12.4800 41.8800)')),4326)),
('Barrio de la Valenciana','Barrio historico','Zona minera en Guanajuato',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.2680 21.0200,-101.2450 21.0200,-101.2450 21.0450,-101.2680 21.0450,-101.2680 21.0200)')),4326)),
('Centro Historico Puebla','Barrio historico','Zona colonial de Puebla',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-98.2050 19.0380,-98.1850 19.0380,-98.1850 19.0580,-98.2050 19.0580,-98.2050 19.0380)')),4326)),
('Centro Historico Oaxaca','Barrio historico','Centro de Oaxaca de Juarez',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.7350 17.0460,-96.7050 17.0460,-96.7050 17.0740,-96.7350 17.0740,-96.7350 17.0460)')),4326)),
('Centro Historico Veracruz','Barrio historico','Puerta de mar y malecones',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.1620 19.1770,-96.1420 19.1770,-96.1420 19.1970,-96.1620 19.1970,-96.1620 19.1770)')),4326)),
('Centro Historico Merida','Barrio historico','Plaza Grande y catedral',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-89.6300 20.9690,-89.6060 20.9690,-89.6060 20.9810,-89.6300 20.9810,-89.6300 20.9690)')),4326)),
('Centro Historico Campeche','Barrio historico','Murallas y baluartes coloniales',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-90.5400 19.8380,-90.5000 19.8380,-90.5000 19.8820,-90.5400 19.8820,-90.5400 19.8380)')),4326)),
('Centro Historico Zacatecas','Barrio historico','Calles empedradas y mina',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-102.5800 22.7670,-102.5500 22.7670,-102.5500 22.7830,-102.5800 22.7830,-102.5800 22.7670)')),4326)),
('Centro San Miguel Allende','Barrio historico','Parroquia y jardines',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.7500 20.9130,-100.7220 20.9130,-100.7220 20.9310,-100.7500 20.9310,-100.7500 20.9130)')),4326)),
('Centro Historico Morelia','Barrio historico','Catedral y universidad',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.1950 19.7000,-101.1700 19.7000,-101.1700 19.7200,-101.1950 19.7200,-101.1950 19.7000)')),4326)),
('Centro Historico San Luis Potosi','Barrio historico','Catedral y centro',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.9950 22.1480,-100.9650 22.1480,-100.9650 22.1620,-100.9950 22.1620,-100.9950 22.1480)')),4326)),
('Centro Historico Queretaro','Barrio historico','Acueducto y plazas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.3950 20.5820,-100.3700 20.5820,-100.3700 20.6000,-100.3950 20.6000,-100.3950 20.5820)')),4326)),
('Centro Historico Chihuahua','Barrio historico','Palacio Gobierno y zocalo',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-106.0750 28.6320,-106.0450 28.6320,-106.0450 28.6520,-106.0750 28.6520,-106.0750 28.6320)')),4326)),
('Centro Historico Puerto Vallarta','Barrio historico','Malecon y parroquia',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-104.8800 20.6060,-104.8600 20.6060,-104.8600 20.6240,-104.8800 20.6240,-104.8800 20.6060)')),4326)),
('Ruta Hotelera Cancun Playa','Ruta hotelera','Hoteles y playas Caribe',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-87.1200 20.5900,-86.8500 20.5900,-86.8500 21.2500,-87.1200 21.2500,-87.1200 20.5900)')),4326)),
('Ruta Vinedos Valle','Ruta vinicola','Vinedos Valle de Guadalupe',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-116.6200 31.9900,-116.4800 31.9900,-116.4800 32.0900,-116.6200 32.0900,-116.6200 31.9900)')),4326)),
('Ruta Hotelera Los Cabos','Ruta hotelera','Cabo San Lucas y San Jose',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-109.7400 23.0000,-109.6400 23.0000,-109.6400 23.1100,-109.7400 23.1100,-109.7400 23.0000)')),4326)),
('Parque Nacional Tikal','Parque natural','Ruinas mayas en Peten Guatemala',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-89.6330 17.2220,-89.6100 17.2220,-89.6100 17.2450,-89.6330 17.2450,-89.6330 17.2220)')),4326)),
('Zona Arqueologica Teotihuacan','Zona arqueologica','Piramides del Sol y la Luna',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-98.8520 19.6800,-98.8350 19.6800,-98.8350 19.7100,-98.8520 19.7100,-98.8520 19.6800)')),4326)),
('Zona Arqueologica Chichen Itza','Zona arqueologica','Templo de Kukulkan',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-88.5790 20.6820,-88.5560 20.6820,-88.5560 20.7060,-88.5790 20.7060,-88.5790 20.6820)')),4326)),
('Ruta Playas Oaxaca','Ruta natural','Costa oaxaquena',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-97.1500 15.6000,-95.2000 15.6000,-95.2000 16.2000,-97.1500 16.2000,-97.1500 15.6000)')),4326)),
('Ruta Playas Guerrero','Ruta natural','Costas de Guerrero',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.8000 16.4000,-100.9000 16.4000,-100.9000 17.2000,-101.8000 17.2000,-101.8000 16.4000)')),4326)),
('Ruta Playas Quintana Roo','Ruta natural','Costa Maya y Riviera Maya',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-88.2000 18.3000,-86.6000 18.3000,-86.6000 20.8000,-88.2000 20.8000,-88.2000 18.3000)')),4326)),
('Ruta Parques Nacionales USA','Ruta natural','Parques del suroeste USA',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-115.0000 32.0000,-110.0000 32.0000,-110.0000 37.0000,-115.0000 37.0000,-115.0000 32.0000)')),4326)),
('Ruta Cenotes Yucatan','Ruta natural','Cenotes del norte de Yucatan',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-89.0000 20.4000,-88.3000 20.4000,-88.3000 21.0000,-89.0000 21.0000,-89.0000 20.4000)')),4326)),
('Isla Mujeres','Isla','Playas y arrecifes',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-86.7900 21.2180,-86.7600 21.2180,-86.7600 21.2500,-86.7900 21.2500,-86.7900 21.2180)')),4326)),
('Isla Holbox','Isla','Reserva natural y playas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-87.3950 21.5100,-87.3550 21.5100,-87.3550 21.5400,-87.3950 21.5400,-87.3950 21.5100)')),4326)),
('Isla Cozumel','Isla','Arrecifes y buceo',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-86.9600 20.4900,-86.9200 20.4900,-86.9200 20.5300,-86.9600 20.5300,-86.9600 20.4900)')),4326)),
('Islas Marietas','Islas','Playas ocultas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-105.5100 20.6750,-105.4900 20.6750,-105.4900 20.6950,-105.5100 20.6950,-105.5100 20.6750)')),4326)),
('Isla Espiritu Santo','Isla','Ecoturismo en Baja California',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-111.0600 24.3000,-111.0200 24.3000,-111.0200 24.3400,-111.0600 24.3400,-111.0600 24.3000)')),4326)),
('Isla Contoy','Isla','Reserva natural',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-86.9700 21.5350,-86.9300 21.5350,-86.9300 21.5550,-86.9700 21.5550,-86.9700 21.5350)')),4326)),
('Isla Tiburon','Isla','Reserva del Mar de Cortes',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-112.0900 28.0300,-112.0400 28.0300,-112.0400 28.0600,-112.0900 28.0600,-112.0900 28.0300)')),4326)),
('Barrancas del Cobre','Parque natural','Canones en Chihuahua',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-107.6200 27.1900,-107.5500 27.1900,-107.5500 27.2600,-107.6200 27.2600,-107.6200 27.1900)')),4326)),
('Valle de Bravo','Pueblo magico','Lago y montanas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.1500 19.1900,-100.1100 19.1900,-100.1100 19.2200,-100.1500 19.2200,-100.1500 19.1900)')),4326)),
('Taxco','Pueblo magico','Ciudades mineras coloniales',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.6200 18.5500,-99.5900 18.5500,-99.5900 18.5700,-99.6200 18.5700,-99.6200 18.5500)')),4326)),
('San Cristobal de las Casas','Pueblo magico','Centro colonial y cafe',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-92.6450 16.7300,-92.6290 16.7300,-92.6290 16.7450,-92.6450 16.7450,-92.6450 16.7300)')),4326)),
('Guadalajara Centro','Barrio historico','Plaza de Armas y catedral',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-103.3620 20.6700,-103.3360 20.6700,-103.3360 20.6800,-103.3620 20.6800,-103.3620 20.6700)')),4326)),
('Valladolid Centro','Barrio historico','Plaza y convento',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-88.6580 20.6650,-88.6420 20.6650,-88.6420 20.6770,-88.6580 20.6770,-88.6580 20.6650)')),4326)),
('Puebla Centro','Barrio historico','Zocalo y talavera',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-98.2120 19.0380,-98.1800 19.0380,-98.1800 19.0530,-98.2120 19.0530,-98.2120 19.0380)')),4326)),
('Tlaxcala Centro','Barrio historico','Plaza mayor y museos',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-98.2400 19.3100,-98.1800 19.3100,-98.1800 19.3200,-98.2400 19.3200,-98.2400 19.3100)')),4326)),
('Atlixco Centro','Barrio historico','Flores y haciendas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-98.4500 18.8600,-98.4200 18.8600,-98.4200 18.8900,-98.4500 18.8900,-98.4500 18.8600)')),4326)),
('Mazatlan Centro','Barrio historico','Malecon y centro',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-106.4350 23.2450,-106.4050 23.2450,-106.4050 23.2650,-106.4350 23.2650,-106.4350 23.2450)')),4326)),
('Campeche Centro','Barrio historico','Murallas y plazas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-90.5450 19.8260,-90.5180 19.8260,-90.5180 19.8420,-90.5450 19.8420,-90.5450 19.8260)')),4326)),
('Oaxaca Centro','Barrio historico','Templo de Santo Domingo',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.7300 17.0600,-96.7100 17.0600,-96.7100 17.0720,-96.7300 17.0720,-96.7300 17.0600)')),4326)),
('Guanajuato Centro','Barrio historico','Alhondiga y callejones',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.2610 21.0250,-101.2430 21.0250,-101.2430 21.0350,-101.2610 21.0350,-101.2610 21.0250)')),4326)),
('Morelia Centro','Barrio historico','Catedral y acueducto',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.1980 19.7020,-101.1800 19.7020,-101.1800 19.7160,-101.1980 19.7160,-101.1980 19.7020)')),4326)),
('Queretaro Centro','Barrio historico','Acueducto y teatros',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.3950 20.5880,-100.3780 20.5880,-100.3780 20.6020,-100.3950 20.6020,-100.3950 20.5880)')),4326)),
('Chihuahua Centro','Barrio historico','Palacio y museos',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-106.0750 28.6350,-106.0550 28.6350,-106.0550 28.6550,-106.0750 28.6550,-106.0750 28.6350)')),4326)),
('Puerto Vallarta Centro','Barrio historico','Malecones y playas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-104.8800 20.6200,-104.8550 20.6200,-104.8550 20.6400,-104.8800 20.6400,-104.8800 20.6200)')),4326)),
('Cabo San Lucas Centro','Barrio urbano','Arco y marina',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-109.7060 22.8800,-109.6720 22.8800,-109.6720 22.9000,-109.7060 22.9000,-109.7060 22.8800)')),4326));

-- 6) Insertar 150 lugares turísticos (dos por cada zona + 30 extras)
INSERT INTO lugares_turisticos(nombre,tipo,direccion,ciudad,horario_apertura,horario_cierre,precio_entrada,zona_id,ubicacion) VALUES
('Monumento a los Ninos Heroes','Monumento','Av. Mundo 1','Ciudad de Mexico','06:00','22:00',0.00,1,ST_SetSRID(ST_Point(-99.1835,19.4230),4326)),
('Puerta de los Leones','Arco','Bosque de Chapultepec','Ciudad de Mexico','00:00','23:59',0.00,1,ST_SetSRID(ST_Point(-99.1860,19.4205),4326)),
('Parque Mexico','Parque urbano','Av. Mexico 42','Ciudad de Mexico','06:00','22:00',0.00,2,ST_SetSRID(ST_Point(-99.1690,19.4135),4326)),
('Parque Espana','Parque urbano','Av. Mexico 48','Ciudad de Mexico','06:00','22:00',0.00,2,ST_SetSRID(ST_Point(-99.1675,19.4140),4326)),
('Museo Casa Azul','Museo','Hidalgo 152','Ciudad de Mexico','10:00','17:30',90.00,3,ST_SetSRID(ST_Point(-99.1555,19.3545),4326)),
('Plaza Hidalgo','Plaza publica','Hidalgo y Allende','Ciudad de Mexico','00:00','23:59',0.00,3,ST_SetSRID(ST_Point(-99.1550,19.3535),4326)),
('Ex Convento Churubusco','Museo','Av. Rio Churubusco 79','Ciudad de Mexico','09:00','17:00',50.00,4,ST_SetSRID(ST_Point(-99.1870,19.3515),4326)),
('Museo de Arte Moderno','Museo','Bosque de Chapultepec','Ciudad de Mexico','10:00','18:00',60.00,4,ST_SetSRID(ST_Point(-99.1890,19.3540),4326)),
('Catedral Metropolitana','Iglesia','Plaza de la Constitucion','Ciudad de Mexico','08:00','20:00',0.00,5,ST_SetSRID(ST_Point(-99.1332,19.4326),4326)),
('Templo Mayor','Sitio historico','Plaza de la Constitucion','Ciudad de Mexico','08:00','18:00',80.00,5,ST_SetSRID(ST_Point(-99.1327,19.4333),4326)),
('Museo Jumex','Museo','Blvd. Miguel de Cervantes Saavedra 303','Ciudad de Mexico','10:00','19:00',70.00,6,ST_SetSRID(ST_Point(-99.1910,19.4335),4326)),
('Acuario Inbursa','Atraccion','Av. Ejercito Nacional 223','Ciudad de Mexico','09:00','18:00',80.00,6,ST_SetSRID(ST_Point(-99.1915,19.4330),4326)),
('Mercado de Artesanias','Mercado','Av. Balderas 155','Ciudad de Mexico','10:00','19:00',0.00,7,ST_SetSRID(ST_Point(-99.1650,19.4305),4326)),
('La Teatreria','Bar','Tamaulipas 202','Ciudad de Mexico','18:00','02:00',0.00,7,ST_SetSRID(ST_Point(-99.1645,19.4295),4326)),
('Centro Comercial Santa Fe','Centro comercial','Av. Vasco de Quiroga 3800','Ciudad de Mexico','10:00','22:00',0.00,8,ST_SetSRID(ST_Point(-99.2500,19.3750),4326)),
('MUAC','Museo','UNAM CU','Ciudad de Mexico','10:00','18:00',0.00,8,ST_SetSRID(ST_Point(-99.2420,19.3730),4326)),
('Monumento a la Revolucion','Monumento','Plaza de la Republica','Ciudad de Mexico','09:00','20:00',50.00,9,ST_SetSRID(ST_Point(-99.1450,19.4400),4326)),
('Torre Reforma','Edificio','Paseo de la Reforma 483','Ciudad de Mexico','08:00','21:00',0.00,9,ST_SetSRID(ST_Point(-99.1470,19.4340),4326)),
('Trajineras','Atraccion','Canales de Xochimilco','Ciudad de Mexico','09:00','18:00',150.00,10,ST_SetSRID(ST_Point(-99.0950,19.2600),4326)),
('Mercado de Plantas','Mercado','Av. Guadalupe I Ramirez','Ciudad de Mexico','06:00','17:00',0.00,10,ST_SetSRID(ST_Point(-99.0960,19.2590),4326)),
('Coliseo','Atraccion','Piazza del Colosseo','Roma Italia','08:30','19:00',16.00,11,ST_SetSRID(ST_Point(12.4922,41.8902),4326)),
('Panteon Monumental','Sitio historico','Via del Pincetto','Roma Italia','09:00','17:00',0.00,11,ST_SetSRID(ST_Point(12.4960,41.9165),4326)),
('Museo de la Valenciana','Museo','Guanajuato','Guanajuato','09:00','18:00',70.00,12,ST_SetSRID(ST_Point(-101.2560,21.0260),4326)),
('Casa Museo Diego Rivera','Museo','Guanajuato','Guanajuato','10:00','17:00',50.00,12,ST_SetSRID(ST_Point(-101.2570,21.0270),4326)),
('Catedral de Puebla','Iglesia','5 Oriente 402','Puebla','08:00','20:00',0.00,13,ST_SetSRID(ST_Point(-98.1972,19.0441),4326)),
('Biblioteca Palafoxiana','Museo','2 Sur 4','Puebla','10:00','18:00',40.00,13,ST_SetSRID(ST_Point(-98.1978,19.0453),4326)),
('Catedral de Oaxaca','Iglesia','Alameda de Leon','Oaxaca de Juarez','09:00','19:00',0.00,14,ST_SetSRID(ST_Point(-96.7220,17.0650),4326)),
('MACO','Museo','ExConvento de Santo Domingo','Oaxaca de Juarez','10:00','18:00',50.00,14,ST_SetSRID(ST_Point(-96.7225,17.0660),4326)),
('Fuerte de San Juan de Ulua','Fortaleza','Veracruz','Veracruz','09:00','17:00',80.00,15,ST_SetSRID(ST_Point(-96.1610,19.1840),4326)),
('Malecones','Paseo','Veracruz','Veracruz','00:00','23:59',0.00,15,ST_SetSRID(ST_Point(-96.1680,19.1850),4326)),
('Catedral de Merida','Iglesia','Plaza Grande','Merida','08:00','20:00',0.00,16,ST_SetSRID(ST_Point(-89.6190,20.9740),4326)),
('Paseo de Montejo','Avenida','Merida','Merida','00:00','23:59',0.00,16,ST_SetSRID(ST_Point(-89.6180,20.9750),4326)),
('Fortaleza de San Miguel','Fortaleza','Campeche','Campeche','09:00','17:00',60.00,17,ST_SetSRID(ST_Point(-90.5050,19.8400),4326)),
('Catedral de Campeche','Iglesia','Campeche','Campeche','08:00','19:00',0.00,17,ST_SetSRID(ST_Point(-90.5160,19.8290),4326)),
('Catedral de Zacatecas','Iglesia','Zacatecas','Zacatecas','08:00','19:00',0.00,18,ST_SetSRID(ST_Point(-102.5680,22.7740),4326)),
('Mina El Eden','Museo','Zacatecas','Zacatecas','09:00','18:00',50.00,18,ST_SetSRID(ST_Point(-102.5670,22.7710),4326)),
('Parroquia de San Miguel','Iglesia','San Miguel Allende','San Miguel Allende','07:00','19:00',0.00,19,ST_SetSRID(ST_Point(-100.7370,20.9230),4326)),
('Jardin Principal','Plaza','San Miguel Allende','San Miguel Allende','00:00','23:59',0.00,19,ST_SetSRID(ST_Point(-100.7380,20.9235),4326)),
('Templo de San Francisco','Iglesia','Morelia','Morelia','08:00','20:00',0.00,20,ST_SetSRID(ST_Point(-101.1880,19.7035),4326)),
('Alcazar de Morelia','Palacio','Morelia','Morelia','09:00','18:00',30.00,20,ST_SetSRID(ST_Point(-101.1840,19.7030),4326)),
('Cascadas de Tamul','Parque natural','Tamasopo','San Luis Potosi','07:00','17:00',70.00,21,ST_SetSRID(ST_Point(-99.7050,21.3950),4326)),
('Catedral de SLP','Iglesia','San Luis Potosi','San Luis Potosi','08:00','19:00',0.00,21,ST_SetSRID(ST_Point(-100.9850,22.1500),4326)),
('Acueducto Centenario','Monumento','Queretaro','Queretaro','00:00','23:59',0.00,22,ST_SetSRID(ST_Point(-100.3890,20.5880),4326)),
('Teatro de la Republica','Teatro','Queretaro','Queretaro','10:00','22:00',20.00,22,ST_SetSRID(ST_Point(-100.3895,20.5885),4326)),
('Teatro de los Heroes','Teatro','Chihuahua','Chihuahua','10:00','22:00',15.00,23,ST_SetSRID(ST_Point(-106.0680,28.6325),4326)),
('Palacio de Gobierno','Edificio','Chihuahua','Chihuahua','00:00','23:59',0.00,23,ST_SetSRID(ST_Point(-106.0700,28.6340),4326)),
('Malecon Puerto Vallarta','Paseo','Puerto Vallarta','Puerto Vallarta','00:00','23:59',0.00,24,ST_SetSRID(ST_Point(-104.8680,20.6270),4326)),
('Playa Los Muertos','Playa','Puerto Vallarta','Puerto Vallarta','06:00','18:00',0.00,24,ST_SetSRID(ST_Point(-104.8690,20.6275),4326)),
('Playa Delfines','Playa publica','Cancun','Cancun','06:00','18:00',0.00,25,ST_SetSRID(ST_Point(-86.8240,21.0670),4326)),
('Playa Tortugas','Playa','Cancun','Cancun','06:00','18:00',0.00,25,ST_SetSRID(ST_Point(-86.8510,21.0220),4326)),
('Vinedo El Cielo','Vinedo','Valle de Guadalupe','Ensenada','09:00','18:00',350.00,26,ST_SetSRID(ST_Point(-116.5660,32.0030),4326)),
('Vinedo LA Cetto','Vinedo','Valle de Guadalupe','Ensenada','09:00','18:00',250.00,26,ST_SetSRID(ST_Point(-116.5780,32.0040),4326)),
('Hotel Historico Los Cabos','Hotel','Cabo San Lucas','Los Cabos','00:00','23:59',0.00,27,ST_SetSRID(ST_Point(-109.7030,22.8905),4326)),
('Playa El Medano','Playa','Cabo San Lucas','Los Cabos','06:00','18:00',0.00,27,ST_SetSRID(ST_Point(-109.7080,22.8890),4326)),
('Gran Plaza Tikal','Centro de Visitantes','Tikal Peten','Petén','08:00','17:00',80.00,28,ST_SetSRID(ST_Point(-89.6200,17.2225),4326)),
('Templo del Gran Jaguar','Zona arqueologica','Tikal Peten','Petén','08:00','17:00',80.00,28,ST_SetSRID(ST_Point(-89.6230,17.2240),4326)),
('Piramide del Sol','Piramide','Teotihuacan','Estado de Mexico','09:00','17:00',80.00,29,ST_SetSRID(ST_Point(-98.8440,19.6930),4326)),
('Museo de Sitio Teotihuacan','Museo','Teotihuacan','Estado de Mexico','09:00','17:00',30.00,29,ST_SetSRID(ST_Point(-98.8430,19.6920),4326)),
('Piramide de Kukulkan','Piramide','Chichen Itza','Yucatan','08:00','17:00',90.00,30,ST_SetSRID(ST_Point(-88.5680,20.6845),4326)),
('Juego de Pelota','Zona arqueologica','Chichen Itza','Yucatan','08:00','17:00',90.00,30,ST_SetSRID(ST_Point(-88.5668,20.6835),4326)),
('Playa Zicatela','Playa','Puerto Escondido','Oaxaca','06:00','18:00',0.00,31,ST_SetSRID(ST_Point(-98.8590,15.8590),4326)),
('Puerto Escondido Centro','Barrio','Puerto Escondido','Oaxaca','00:00','23:59',0.00,31,ST_SetSRID(ST_Point(-98.8610,15.8570),4326)),
('Playa La Ropa','Playa','Zihuatanejo','Guerrero','06:00','18:00',0.00,32,ST_SetSRID(ST_Point(-101.5600,17.6380),4326)),
('Bahia de Zihuatanejo','Bahia','Zihuatanejo','Guerrero','00:00','23:59',0.00,32,ST_SetSRID(ST_Point(-101.5550,17.6280),4326)),
('Arrecife de Xcalak','Parque Marino','Xcalak','Quintana Roo','08:00','17:00',70.00,33,ST_SetSRID(ST_Point(-87.7180,18.4120),4326)),
('Parque Marino Puerto Morelos','Parque Marino','Puerto Morelos','Quintana Roo','08:00','17:00',50.00,33,ST_SetSRID(ST_Point(-86.8510,20.5140),4326)),
('Grand Canyon Village','Pueblo','Grand Canyon','Arizona USA','00:00','23:59',35.00,34,ST_SetSRID(ST_Point(-112.1130,36.1060),4326)),
('Mather Point','Mirador','Grand Canyon','Arizona USA','00:00','23:59',0.00,34,ST_SetSRID(ST_Point(-112.1120,36.0560),4326)),
('Cenote Samula','Cenote','Hacienda Xcan','Yucatan','08:00','17:00',80.00,35,ST_SetSRID(ST_Point(-89.6860,20.4260),4326)),
('Cenote Xkeken','Cenote','Dzitnup','Yucatan','08:00','17:00',80.00,35,ST_SetSRID(ST_Point(-89.6880,20.4270),4326)),
('Playa Norte','Playa publica','Isla Mujeres','Quintana Roo','06:00','18:00',0.00,36,ST_SetSRID(ST_Point(-86.7750,21.2310),4326)),
('Punta Sur','Mirador','Isla Mujeres','Quintana Roo','00:00','23:59',0.00,36,ST_SetSRID(ST_Point(-86.7720,21.2290),4326)),
('Jardin Botanico','Parque','Cozumel','Quintana Roo','08:00','17:00',10.00,37,ST_SetSRID(ST_Point(-86.9520,20.5070),4326)),
('Museo Palenque','Museo','Palenque','Chiapas','08:00','17:00',70.00,37,ST_SetSRID(ST_Point(-91.9820,17.4840),4326)),
('Templo Guadalupe','Iglesia','San Cristobal','Chiapas','07:00','19:00',0.00,38,ST_SetSRID(ST_Point(-92.6360,16.7400),4326)),
('Catedral San Cristobal','Iglesia','San Cristobal','Chiapas','08:00','20:00',0.00,38,ST_SetSRID(ST_Point(-92.6370,16.7390),4326)),
('Plaza Borda','Plaza','Taxco','Guerrero','00:00','23:59',0.00,39,ST_SetSRID(ST_Point(-99.6140,18.5560),4326)),
('Museo Casa Borda','Museo','Taxco','Guerrero','10:00','18:00',50.00,39,ST_SetSRID(ST_Point(-99.6150,18.5550),4326)),
('Playa Balandra','Playa','La Paz','Baja California Sur','06:00','18:00',0.00,40,ST_SetSRID(ST_Point(-110.3270,24.2870),4326)),
('El Arco','Formacion rocosa','Cabo San Lucas','Baja California Sur','00:00','23:59',0.00,40,ST_SetSRID(ST_Point(-109.7010,22.8890),4326)),
('Mercado Negro','Mercado','Ensenada','Baja California','09:00','17:00',0.00,41,ST_SetSRID(ST_Point(-116.6100,31.8650),4326)),
('Playa Hermosa','Playa','Ensenada','Baja California','06:00','18:00',0.00,41,ST_SetSRID(ST_Point(-116.6130,31.8600),4326)),
('Mirador Farallon','Mirador','Dunas de Samalayuca','Chihuahua','00:00','23:59',0.00,42,ST_SetSRID(ST_Point(-105.5800,31.0350),4326)),
('Parque Dunas','Parque','Dunas de Samalayuca','Chihuahua','06:00','18:00',0.00,42,ST_SetSRID(ST_Point(-105.5850,31.0300),4326)),
('Mirador Barrancas','Mirador','Barrancas del Cobre','Chihuahua','00:00','23:59',0.00,43,ST_SetSRID(ST_Point(-107.6000,27.2200),4326)),
('Adventure Park','Parque','Barrancas del Cobre','Chihuahua','09:00','17:00',50.00,43,ST_SetSRID(ST_Point(-107.6100,27.2100),4326)),
('Lago Avandaro','Lago','Valle de Bravo','Estado de Mexico','06:00','20:00',0.00,44,ST_SetSRID(ST_Point(-100.1500,19.1900),4326)),
('Museo Pagaza','Museo','Valle de Bravo','Estado de Mexico','10:00','18:00',30.00,44,ST_SetSRID(ST_Point(-100.1450,19.1920),4326)),
('Casa Humboldt','Museo','Taxco','Guerrero','10:00','18:00',50.00,45,ST_SetSRID(ST_Point(-99.6130,18.5565),4326)),
('Templo Santo Domingo','Iglesia','Oaxaca de Juarez','Oaxaca','08:00','20:00',0.00,46,ST_SetSRID(ST_Point(-96.7240,17.0640),4326)),
('Zocalo Oaxaca','Plaza','Oaxaca de Juarez','Oaxaca','00:00','23:59',0.00,46,ST_SetSRID(ST_Point(-96.7220,17.0645),4326)),
('Teatro Degollado','Teatro','Guadalajara','Jalisco','10:00','22:00',40.00,47,ST_SetSRID(ST_Point(-103.3470,20.6730),4326)),
('Catedral Guadalajara','Iglesia','Guadalajara','Jalisco','08:00','20:00',0.00,47,ST_SetSRID(ST_Point(-103.3430,20.6770),4326)),
('Convento Bernardino','Convento','Patzcuaro','Michoacan','09:00','17:00',20.00,48,ST_SetSRID(ST_Point(-101.5880,19.7060),4326)),
('Calzada Frailes','Avenida historica','Patzcuaro','Michoacan','00:00','23:59',0.00,48,ST_SetSRID(ST_Point(-101.5850,19.7050),4326)),
('Zocalo Puebla','Plaza','Puebla','Puebla','00:00','23:59',0.00,49,ST_SetSRID(ST_Point(-98.1990,19.0410),4326)),
('Capilla Rosario','Iglesia','Puebla','Puebla','09:00','18:00',30.00,49,ST_SetSRID(ST_Point(-98.1960,19.0430),4326)),
('Palacio Gob Tlaxcala','Palacio','Tlaxcala','Tlaxcala','00:00','23:59',0.00,50,ST_SetSRID(ST_Point(-98.2400,19.3130),4326)),
('Santuario Ocotlan','Iglesia','Tlaxcala','Tlaxcala','07:00','19:00',0.00,50,ST_SetSRID(ST_Point(-98.2250,19.3160),4326)),
('Exconvento Acolman','Convento','Acolman','Estado de Mexico','09:00','17:00',15.00,51,ST_SetSRID(ST_Point(-98.8920,19.6310),4326)),
('Iglesia Asuncion','Iglesia','Acolman','Estado de Mexico','08:00','19:00',0.00,51,ST_SetSRID(ST_Point(-98.8900,19.6320),4326)),
('Malecon Mazatlan','Paseo','Mazatlan','Sinaloa','00:00','23:59',0.00,52,ST_SetSRID(ST_Point(-106.4191,23.2494),4326)),
('Teatro Angela Peralta','Teatro','Mazatlan','Sinaloa','10:00','22:00',25.00,52,ST_SetSRID(ST_Point(-106.4180,23.2490),4326)),
('Puerta Tierra','Monumento','Campeche','Campeche','00:00','23:59',0.00,53,ST_SetSRID(ST_Point(-90.5290,19.8320),4326)),
('Museo Arquitectura Maya','Museo','Campeche','Campeche','10:00','18:00',30.00,53,ST_SetSRID(ST_Point(-90.5280,19.8330),4326));
