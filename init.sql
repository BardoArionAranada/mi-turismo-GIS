DROP DATABASE IF EXISTS turismodb;
CREATE DATABASE turismodb WITH OWNER=postgres ENCODING='UTF8' LC_COLLATE='es_MX.UTF-8' LC_CTYPE='es_MX.UTF-8' TEMPLATE=template0;
\c turismodb
CREATE EXTENSION IF NOT EXISTS postgis;
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
INSERT INTO zonas_turisticas(nombre_zona,tipo_zona,descripcion,geom) VALUES
('Circuito Museos CDMX','Ruta sugerida','Museos clave en Ciudad de México',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.20 19.42,-99.16 19.42,-99.16 19.44,-99.20 19.44,-99.20 19.42)')),4326)),
('Centro Histórico Puebla','Barrio histórico','Zona colonial de Puebla',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-98.20 19.04,-98.18 19.04,-98.18 19.06,-98.20 19.06,-98.20 19.04)')),4326)),
('Barrio de la Valenciana','Barrio histórico','Zona minera en Guanajuato',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.26 21.02,-101.24 21.02,-101.24 21.04,-101.26 21.04,-101.26 21.02)')),4326)),
('Roma y Centro','Ruta cultural','Iglesias y basílicas en Roma, Italia',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(12.48 41.88,12.50 41.88,12.50 41.90,12.48 41.90,12.48 41.88)')),4326)),
('Circuito Parques Nacionales USA','Ruta natural','Parques Nacionales de EE.UU.',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-119.0 35.5,-115.0 35.5,-115.0 37.5,-119.0 37.5,-119.0 35.5)')),4326)),
('Ruta Hotelera Cancún-Playa','Ruta hotelera','Hoteles de Cancún y Playa del Carmen',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-87.10 20.60,-86.80 20.60,-86.80 21.30,-87.10 21.30,-87.10 20.60)')),4326)),
('Centro Histórico Oaxaca','Barrio histórico','Centro histórico de Oaxaca de Juárez',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.7270 17.0510,-96.7080 17.0510,-96.7080 17.0700,-96.7270 17.0700,-96.7270 17.0510)')),4326)),
('Centro Histórico Veracruz','Barrio histórico','Centro histórico de Veracruz',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.1520 19.1810,-96.1220 19.1810,-96.1220 19.2010,-96.1520 19.2010,-96.1520 19.1810)')),4326)),
('Centro Histórico Mérida','Barrio histórico','Centro histórico de Mérida',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-89.6240 20.9680,-89.6100 20.9680,-89.6100 20.9800,-89.6240 20.9800,-89.6240 20.9680)')),4326)),
('Centro Histórico Campeche','Barrio histórico','Centro histórico de Campeche',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-90.5250 19.8420,-90.4700 19.8420,-90.4700 19.8800,-90.5250 19.8800,-90.5250 19.8420)')),4326)),
('Barrio Roma Norte','Ruta cultural','Zona cultural y gastronómica de Roma Norte, CDMX',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.1750 19.4170,-99.1600 19.4170,-99.1600 19.4300,-99.1750 19.4300,-99.1750 19.4170)')),4326)),
('Polanco','Barrio urbano','Zona comercial y museos en Polanco, CDMX',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.2020 19.4320,-99.1800 19.4320,-99.1800 19.4470,-99.2020 19.4470,-99.2020 19.4320)')),4326)),
('Tulum Pueblo','Zona urbana','Centro de Tulum pueblo',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-87.4680 20.2130,-87.4620 20.2130,-87.4620 20.2170,-87.4680 20.2170,-87.4680 20.2130)')),4326)),
('Ruta Viñedos Valle','Ruta natural','Viñedos en Valle de Guadalupe, BC',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-116.6100 32.0000,-116.5000 32.0000,-116.5000 32.0800,-116.6100 32.0800,-116.6100 32.0000)')),4326)),
('Centro Histórico Zacatecas','Barrio histórico','Centro histórico de Zacatecas',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-102.5760 22.7680,-102.5620 22.7680,-102.5620 22.7800,-102.5760 22.7800,-102.5760 22.7680)')),4326)),
('Centro Histórico San Miguel de Allende','Barrio histórico','Centro histórico de San Miguel de Allende',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.7430 20.9150,-100.7200 20.9150,-100.7200 20.9300,-100.7430 20.9300,-100.7430 20.9150)')),4326)),
('Centro Histórico Morelia','Barrio histórico','Centro histórico de Morelia',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.1870 19.7030,-101.1740 19.7030,-101.1740 19.7150,-101.1870 19.7150,-101.1870 19.7030)')),4326)),
('Centro Histórico San Luis Potosí','Barrio histórico','Centro histórico de San Luis Potosí',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.9860 22.1490,-100.9720 22.1490,-100.9720 22.1610,-100.9860 22.1610,-100.9860 22.1490)')),4326)),
('Centro Histórico Querétaro','Barrio histórico','Centro histórico de Querétaro',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.3890 20.5880,-100.3750 20.5880,-100.3750 20.6000,-100.3890 20.6000,-100.3890 20.5880)')),4326)),
('Centro Histórico Chihuahua','Barrio histórico','Centro histórico de Chihuahua',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-106.0650 28.6350,-106.0510 28.6350,-106.0510 28.6500,-106.0650 28.6500,-106.0650 28.6350)')),4326)),
('Centro Histórico Puerto Vallarta','Barrio histórico','Centro histórico de Puerto Vallarta',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-104.8750 20.6080,-104.8620 20.6080,-104.8620 20.6200,-104.8750 20.6200,-104.8750 20.6080)')),4326)),
('Ruta Parques CDMX','Ruta natural','Parques urbanos en Ciudad de México',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.20 19.40,-99.10 19.40,-99.10 19.50,-99.20 19.50,-99.20 19.40)')),4326)),
('Ruta Hotelera Los Cabos','Ruta hotelera','Hoteles en Cabo San Lucas y San José del Cabo',ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-109.73 23.01,-109.65 23.01,-109.65 23.11,-109.73 23.11,-109.73 23.01)')),4326));
INSERT INTO lugares_turisticos(nombre,tipo,direccion,ciudad,horario_apertura,horario_cierre,precio_entrada,zona_id,ubicacion) VALUES
('Museo Nacional de Antropología','Museo','Av. Reforma y Gandhi, Polanco','Ciudad de México','09:00','18:00',100.00,1,ST_SetSRID(ST_Point(-99.1967,19.4260),4326)),
('Museo Nacional de Arte','Museo','Tacuba 8, Centro Histórico','Ciudad de México','10:00','18:00',95.00,1,ST_SetSRID(ST_Point(-99.1519,19.4340),4326)),
('Museo Soumaya','Museo','Blvd. Miguel de Cervantes 303, Granada','Ciudad de México','10:30','18:30',0.00,1,ST_SetSRID(ST_Point(-99.2029,19.4328),4326)),
('Museo Frida Kahlo','Museo','Londres 247, Coyoacán','Ciudad de México','10:00','17:00',250.00,1,ST_SetSRID(ST_Point(-99.1620,19.3550),4326)),
('Museo Memoria y Tolerancia','Museo','Av. Juárez 8, Centro Histórico','Ciudad de México','09:00','18:00',150.00,1,ST_SetSRID(ST_Point(-99.1456,19.4325),4326)),
('Papalote Museo del Niño','Museo','Av. Constituyentes 268, CDMX','Ciudad de México','10:00','18:30',215.00,1,ST_SetSRID(ST_Point(-99.1965,19.4192),4326)),
('Templo Mayor','Sitio histórico','Plaza de la Constitución S/N, CDMX','Ciudad de México','08:00','18:00',80.00,1,ST_SetSRID(ST_Point(-99.1327,19.4333),4326)),
('Castillo de Chapultepec','Atracción','Bosque de Chapultepec I Sección, CDMX','Ciudad de México','09:00','17:00',85.00,1,ST_SetSRID(ST_Point(-99.1836,19.4200),4326)),
('Chapultepec Zoológico','Atracción','Bosque de Chapultepec II Sección, CDMX','Ciudad de México','09:00','17:00',60.00,1,ST_SetSRID(ST_Point(-99.1837,19.4156),4326)),
('Parque Xcaret','Atracción','Carretera Chetumal-Pto. Juárez km 282','Playa del Carmen','08:30','21:30',100.00,13,ST_SetSRID(ST_Point(-87.1229,20.5650),4326)),
('Tulum Ruinas','Sitio arqueológico','Carretera Coba-Tulum km 2','Tulum','08:00','17:00',80.00,12,ST_SetSRID(ST_Point(-87.4650,20.2138),4326)),
('Xel-Há','Atracción','Chetumal-Puerto Juárez km 240','Quintana Roo','09:00','17:00',75.00,12,ST_SetSRID(ST_Point(-87.0970,20.3630),4326)),
('Zona Arqueológica Teotihuacán','Sitio arqueológico','San Juan Teotihuacán','Estado de México','09:00','17:00',80.00,19,ST_SetSRID(ST_Point(-98.8433,19.6925),4326)),
('Catedral de Puebla','Iglesia','5 Oriente 402, Puebla','Puebla','08:00','20:00',0.00,2,ST_SetSRID(ST_Point(-98.1972,19.0441),4326)),
('Africam Safari','Atracción','Carr. Fed. Puebla-Tehuacán km 19','Puebla','09:00','17:00',90.00,2,ST_SetSRID(ST_Point(-98.1067,19.1086),4326)),
('Museo Amparo','Museo','2 Poniente 708, Puebla','Puebla','10:30','18:00',75.00,2,ST_SetSRID(ST_Point(-98.1980,19.0426),4326)),
('Alhóndiga de Granaditas','Museo','Plaza de la Paz, Guanajuato','Guanajuato','09:00','18:00',70.00,3,ST_SetSRID(ST_Point(-101.2594,21.0057),4326)),
('Museo de las Momias','Museo','Explanada Panteón, Guanajuato','Guanajuato','09:00','18:00',85.00,3,ST_SetSRID(ST_Point(-101.2547,21.0278),4326)),
('Coliseo','Atracción','Piazza del Colosseo, Roma','Roma','08:30','19:00',16.00,4,ST_SetSRID(ST_Point(12.4922,41.8902),4326)),
('Basílica de San Pedro','Iglesia','Piazza San Pietro, Vaticano','Ciudad del Vaticano','07:00','19:00',0.00,10,ST_SetSRID(ST_Point(12.4534,41.9022),4326)),
('Grand Canyon NP','Atracción','Arizona, USA','Arizona','00:00','23:59',30.00,5,ST_SetSRID(ST_Point(-112.1129,36.1069),4326)),
('Yellowstone NP','Atracción','Wyoming, USA','Wyoming','00:00','23:59',35.00,5,ST_SetSRID(ST_Point(-110.5885,44.4280),4326)),
('Joshua Tree NP','Atracción','California, USA','California','00:00','23:59',30.00,5,ST_SetSRID(ST_Point(-115.9010,33.8734),4326)),
('Sequoia NP','Atracción','California, USA','California','00:00','23:59',35.00,5,ST_SetSRID(ST_Point(-118.6819,36.4864),4326)),
('Viñedo El Cielo','Atracción','Ensenada–Ojos Negros km 13','Valle de Guadalupe','09:00','18:00',350.00,14,ST_SetSRID(ST_Point(-116.5660,32.0030),4326)),
('Museo Diego Rivera Anahuacalli','Museo','Museo Anahuacalli 150, CDMX','Ciudad de México','10:00','17:00',50.00,1,ST_SetSRID(ST_Point(-99.1578,19.3498),4326)),
('Arena México','Atracción','Dr. Lavista 189, CDMX','Ciudad de México','12:00','23:00',150.00,1,ST_SetSRID(ST_Point(-99.1497,19.4260),4326));
