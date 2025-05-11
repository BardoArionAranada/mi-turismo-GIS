-- 1) Elimina y crea la base de datos
DROP DATABASE IF EXISTS turismodb;
CREATE DATABASE turismodb;

-- 2) Conéctate a la nueva base (en psql)
\c turismodb;

-- 3) Habilita PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- 4) Crea las tablas
CREATE TABLE lugares_turisticos (
  id               SERIAL      PRIMARY KEY,
  nombre           VARCHAR(100),
  tipo             VARCHAR(50),
  direccion        VARCHAR(150),
  ciudad           VARCHAR(100),
  horario_apertura VARCHAR(20),
  horario_cierre   VARCHAR(20),
  precio_entrada   NUMERIC(8,2),
  zona_id          INTEGER,
  ubicacion        geometry(Point,4326)
);

CREATE TABLE zonas_turisticas (
  id           SERIAL      PRIMARY KEY,
  nombre_zona  VARCHAR(100),
  tipo_zona    VARCHAR(50),
  descripcion  TEXT,
  geom         geometry(Polygon,4326)
);

-- 5) Índices espaciales
CREATE INDEX ON lugares_turisticos USING GIST (ubicacion);
CREATE INDEX ON zonas_turisticas USING GIST (geom);

-- 6) Inserta los 10 polígonos originales
INSERT INTO zonas_turisticas (nombre_zona, tipo_zona, descripcion, geom) VALUES
  ('Circuito Museos CDMX','Ruta sugerida','Museos clave en CDMX',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-99.20 19.42,-99.16 19.42,-99.16 19.44,-99.20 19.44,-99.20 19.42)')
       ),4326
     )
  ),
  ('Centro Histórico Puebla','Barrio histórico','Zona colonial de Puebla',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-98.20 19.04,-98.18 19.04,-98.18 19.06,-98.20 19.06,-98.20 19.04)')
       ),4326
     )
  ),
  ('Barrio de la Valenciana','Barrio histórico','Zona minera en Guanajuato',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-101.26 21.02,-101.24 21.02,-101.24 21.04,-101.26 21.04,-101.26 21.02)')
       ),4326
     )
  ),
  ('Roma y Centro','Ruta sugerida','Iglesias y basílicas en Roma',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(12.48 41.88,12.50 41.88,12.50 41.90,12.48 41.90,12.48 41.88)')
       ),4326
     )
  ),
  ('Circuito Parques Nacionales USA','Ruta natural','Algunos NP de EE.UU.',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-119.0 35.5,-115.0 35.5,-115.0 37.5,-119.0 37.5,-119.0 35.5)')
       ),4326
     )
  ),
  ('Ruta Hotelera Cancún-Playa','Ruta hotelera','Hoteles en Cancún y Playa del Carmen',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-87.10 20.60,-86.80 20.60,-86.80 21.30,-87.10 21.30,-87.10 20.60)')
       ),4326
     )
  ),
  ('Circuito Museos Guanajuato','Ruta sugerida','Museos en el centro de Guanajuato',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-101.2640 21.0130,-101.2470 21.0130,-101.2470 21.0320,-101.2640 21.0320,-101.2640 21.0130)')
       ),4326
     )
  ),
  ('Zona Hotelera Santa Fe','Ruta hotelera','Hoteles en Santa Fe, CDMX',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-99.29 19.35,-99.25 19.35,-99.25 19.38,-99.29 19.38,-99.29 19.35)')
       ),4326
     )
  ),
  ('Ruta Parques Nacionales CE-MX','Ruta natural','Zempoala, Malinche, Monarca',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(-100.50 19.00,-98.00 19.00,-98.00 20.50,-100.50 20.50,-100.50 19.00)')
       ),4326
     )
  ),
  ('Zona Vaticano','Zona natural','Área de iglesias en el Vaticano',
     ST_SetSRID(
       ST_MakePolygon(
         ST_GeomFromText('LINESTRING(12.4450 41.8980,12.4610 41.8980,12.4610 41.9050,12.4450 41.9050,12.4450 41.8980)')
       ),4326
     )
  )
;

-- 7) Inserta los 33 puntos originales
INSERT INTO lugares_turisticos
  (nombre, tipo, direccion, ciudad, horario_apertura, horario_cierre, precio_entrada, zona_id, ubicacion)
VALUES
  ('Museo Nacional de Antropología','Museo','Av. Reforma y Gandhi, Polanco','Ciudad de México','09:00','18:00',100.00,1,ST_SetSRID(ST_Point(-99.1967,19.4260),4326)),
  ('Museo Nacional de Arte','Museo','Tacuba 8, Centro Histórico','Ciudad de México','10:00','18:00',95.00,1,ST_SetSRID(ST_Point(-99.1519,19.4340),4326)),
  ('Museo Soumaya','Museo','Blvd. Miguel de Cervantes 303, Granada','Ciudad de México','10:30','18:30',0.00,1,ST_SetSRID(ST_Point(-99.2029,19.4328),4326)),
  ('Museo Frida Kahlo','Museo','Londres 247, Coyoacán','Ciudad de México','10:00','17:00',250.00,1,ST_SetSRID(ST_Point(-99.1620,19.3550),4326)),
  ('Museo Memoria y Tolerancia','Museo','Av. Juárez 8, Centro Histórico','Ciudad de México','09:00','18:00',150.00,1,ST_SetSRID(ST_Point(-99.1456,19.4325),4326)),
  ('Papalote Museo del Niño','Museo','Av. Constituyentes 268','Ciudad de México','10:00','18:30',215.00,1,ST_SetSRID(ST_Point(-99.1965,19.4192),4326)),
  ('Museo del Chocolate','Museo','Milán 45, Col. Juárez','Ciudad de México','11:00','17:00',80.00,1,ST_SetSRID(ST_Point(-99.1624,19.4282),4326)),
  ('Museo de las Momias de Guanajuato','Museo','Explanada Panteón, Guanajuato','Guanajuato','09:00','18:00',85.00,3,ST_SetSRID(ST_Point(-101.2547,21.0278),4326)),
  ('Catedral Metropolitana','Iglesia','Plaza de la Constitución','Ciudad de México','08:00','20:00',0.00,1,ST_SetSRID(ST_Point(-99.1332,19.4326),4326)),
  ('Catedral de Puebla','Iglesia','5 Oriente 402, Puebla','Puebla','08:00','20:00',0.00,2,ST_SetSRID(ST_Point(-98.1972,19.0441),4326)),
  ('Catedral de Zacatecas','Iglesia','Av. Hidalgo 617, Zacatecas','Zacatecas','08:00','20:00',0.00,3,ST_SetSRID(ST_Point(-102.5834,22.7704),4326)),
  ('Basílica de San Pedro','Iglesia','Piazza San Pietro','Roma','07:00','19:00',0.00,4,ST_SetSRID(ST_Point(12.4534,41.9022),4326)),
  ('Basílica de San Pablo Extramuros','Iglesia','Piazzale San Paolo,1','Roma','07:00','18:30',0.00,4,ST_SetSRID(ST_Point(12.4825,41.8794),4326)),
  ('Santa María la Mayor','Iglesia','Piazza di S. M. Maggiore','Roma','07:00','19:00',0.00,4,ST_SetSRID(ST_Point(12.4989,41.8972),4326)),
  ('San Carlo alle 4 Fontane','Iglesia','Via del Quirinale 23','Roma','10:00','13:00',0.00,4,ST_SetSRID(ST_Point(12.4940,41.9008),4326)),
  ('Santa Pudenziana','Iglesia','Via Urbana 160','Roma','09:00','12:00',0.00,4,ST_SetSRID(ST_Point(12.4983,41.9002),4326)),
  ('Parque Nacional Tulum','Atracción','Carretera Federal 307, Tulum','Tulum','08:00','17:00',80.00,5,ST_SetSRID(ST_Point(-87.4643,20.2099),4326)),
  ('Lagunas de Zempoala','Atracción','México-Cuernavaca km 50','Morelos','08:00','17:00',0.00,6,ST_SetSRID(ST_Point(-99.3175,19.0421),4326)),
  ('Parque Nacional La Malinche','Atracción','Huamantla-San Miguel','Tlaxcala','08:00','17:00',0.00,6,ST_SetSRID(ST_Point(-98.1999,19.2545),4326)),
  ('Biosfera Monarca','Atracción','Sierra Chincua, Angangueo','Michoacán','09:00','17:00',50.00,6,ST_SetSRID(ST_Point(-100.4297,19.6566),4326)),
  ('Arrecifes de Xcalak','Atracción','Xcalak','Quintana Roo','08:00','17:00',0.00,7,ST_SetSRID(ST_Point(-87.7510,18.3500),4326)),
  ('Sequoia NP','Atracción','Generals Hwy 47050','California','08:00','17:00',35.00,8,ST_SetSRID(ST_Point(-118.6819,36.4864),4326)),
  ('Great Smoky Mountains NP','Atracción','107 Park Headquarters Rd','Tennessee','08:00','17:00',0.00,8,ST_SetSRID(ST_Point(-83.5085,35.6118),4326)),
  ('Joshua Tree NP','Atracción','National Park Dr','California','08:00','17:00',30.00,8,ST_SetSRID(ST_Point(-115.9010,33.8734),4326)),
  ('Banyan Tree Mayakoba','Hotel','Km 298, Playa del Carmen','Playa del Carmen','15:00','12:00',7616.34,9,ST_SetSRID(ST_Point(-87.0717,20.6383),4326)),
  ('Las Ventanas al Paraíso','Hotel','KM19.5 Transpeninsular','San José del Cabo','15:00','12:00',18433.80,9,ST_SetSRID(ST_Point(-109.6941,23.0679),4326)),
  ('The St. Regis Punta Mita','Hotel','Carretera Federal 200, Punta Mita','Punta de Mita','15:00','12:00',13167.00,9,ST_SetSRID(ST_Point(-105.3515,20.6857),4326)),
  ('Rodavento Boutique Hotel & Spa','Hotel','Carretera Valle de Bravo km3.5','Valle de Bravo','15:00','12:00',3077.83,10,ST_SetSRID(ST_Point(-100.1469,19.1833),4326)),
  ('JW Marriott Santa Fe','Hotel','Av. Santa Fe 160','Ciudad de México','15:00','12:00',2445.30,10,ST_SetSRID(ST_Point(-99.2633,19.3639),4326)),
  ('Royal Pedregal','Hotel','Periférico Sur 4363','Ciudad de México','15:00','12:00',1183.49,10,ST_SetSRID(ST_Point(-99.2102,19.3248),4326)),
  ('Hard Rock Cancún','Hotel','Blvd. Kukulcán Km 14.5','Cancún','15:00','12:00',6703.20,11,ST_SetSRID(ST_Point(-86.8515,21.1601),4326)),
  ('Atelier Playa Mujeres','Hotel','SM3 MZ1 Lote5, Cancún','Cancún','15:00','12:00',5762.70,11,ST_SetSRID(ST_Point(-86.7314,21.2369),4326)),
  ('Live Aqua Cancún','Hotel','Blvd. Kukulcán Km 12.5','Cancún','15:00','12:00',5591.70,11,ST_SetSRID(ST_Point(-86.7425,21.1290),4326))
;

-- 8) Inserta 30 lugares adicionales
INSERT INTO lugares_turisticos
  (nombre, tipo, direccion, ciudad, horario_apertura, horario_cierre, precio_entrada, zona_id, ubicacion)
VALUES
  -- Ciudad de México (zona_id = 1)
  ('Chapultepec Castle','Atracción','Bosque de Chapultepec, Primera Sección','Ciudad de México','09:00','17:00',85.00,1,ST_SetSRID(ST_Point(-99.1836,19.4200),4326)),
  ('Templo Mayor','Sitio histórico','Plaza de la Constitución S/N, Centro Histórico','Ciudad de México','08:00','18:00',80.00,1,ST_SetSRID(ST_Point(-99.1327,19.4333),4326)),
  ('Zoológico de Chapultepec','Atracción','Bosque de Chapultepec, Segunda Sección','Ciudad de México','09:00','17:00',60.00,1,ST_SetSRID(ST_Point(-99.1837,19.4156),4326)),
  ('Museo Diego Rivera Anahuacalli','Museo','Museo Anahuacalli 150, San Pablo Tepetlapa','Ciudad de México','10:00','17:00',50.00,1,ST_SetSRID(ST_Point(-99.1578,19.3498),4326)),
  ('Arena México','Atracción','Dr. Lavista 189, Doctores','Ciudad de México','12:00','23:00',150.00,1,ST_SetSRID(ST_Point(-99.1497,19.4260),4326)),
  ('Estadio Azteca Tour','Atracción','Calzada de Tlalpan 3465, Coyoacán','Ciudad de México','10:00','16:00',300.00,1,ST_SetSRID(ST_Point(-99.1507,19.3029),4326)),
  ('Basílica de Guadalupe','Iglesia','Plaza de las Américas 1, Gustavo A. Madero','Ciudad de México','05:00','21:00',0.00,1,ST_SetSRID(ST_Point(-99.1153,19.4843),4326)),

  -- Puebla (zona_id = 2)
  ('Museo Amparo','Museo','2 Poniente 708, Centro Histórico','Puebla','10:30','18:00',75.00,2,ST_SetSRID(ST_Point(-98.1980,19.0426),4326)),
  ('Sitio Museo Cinco de Mayo','Sitio histórico','Av. 5 de Mayo, Centro Histórico','Puebla','09:00','18:00',50.00,2,ST_SetSRID(ST_Point(-98.1964,19.0500),4326)),
  ('Gran Pirámide de Cholula','Atracción','Zona Arqueológica de Cholula','Cholula','08:00','17:00',70.00,2,ST_SetSRID(ST_Point(-98.3070,19.0545),4326)),
  ('Africam Safari','Atracción','Carr. Fed. Puebla-Tehuacán km 19','Puebla','09:00','17:00',90.00,2,ST_SetSRID(ST_Point(-98.1067,19.1086),4326)),

  -- Guanajuato histórico (zona_id = 3)
  ('Universidad de Guanajuato','Atracción','Juárez 125, Centro','Guanajuato','08:00','20:00',0.00,3,ST_SetSRID(ST_Point(-101.2574,21.0170),4326)),
  ('Alhóndiga de Granaditas','Museo','Plaza de la Paz, Centro','Guanajuato','09:00','18:00',70.00,3,ST_SetSRID(ST_Point(-101.2594,21.0057),4326)),

  -- León / museos (zona_id = 7)
  ('Museo Exhacienda San Gabriel de Barrera','Museo','Blvd. Adolfo López Mateos 702','León','10:00','17:00',60.00,7,ST_SetSRID(ST_Point(-101.2417,21.0364),4326)),
  ('Museo de Arte Contemporáneo de León','Museo','Calzada de los Héroes 501','León','10:00','18:00',50.00,7,ST_SetSRID(ST_Point(-101.6835,21.1218),4326)),
  ('Museo Regional de Guanajuato','Museo','Calzada Tesorería 17','Guanajuato','09:00','17:00',40.00,7,ST_SetSRID(ST_Point(-101.2540,21.0168),4326)),

  -- Roma, Italia (zona_id = 4)
  ('Colosseum','Atracción','Piazza del Colosseo','Roma','08:30','19:00',16.00,4,ST_SetSRID(ST_Point(12.4922,41.8902),4326)),
  ('Panteón','Atracción','Piazza della Rotonda','Roma','09:00','19:00',18.00,4,ST_SetSRID(ST_Point(12.4768,41.8986),4326)),
  ('Castel Sant’Angelo','Atracción','Lungotevere Castello','Roma','09:00','18:30',14.00,4,ST_SetSRID(ST_Point(12.4663,41.9039),4326)),

  -- Parques Nacionales USA (zona_id = 5)
  ('Yellowstone NP','Atracción','Wyoming, USA','Wyoming','00:00','23:59',35.00,5,ST_SetSRID(ST_Point(-110.5885,44.4280),4326)),
  ('Grand Canyon NP','Atracción','Arizona, USA','Arizona','00:00','23:59',30.00,5,ST_SetSRID(ST_Point(-112.1129,36.1069),4326)),
  ('Zion NP','Atracción','Utah, USA','Utah','00:00','23:59',25.00,5,ST_SetSRID(ST_Point(-113.0263,37.2982),4326)),

  -- Cancún / Playa (zona_id = 6)
  ('Parque Xcaret','Atracción','Carretera Chetumal-Pto. Juárez km 282','Playa del Carmen','08:30','21:30',100.00,6,ST_SetSRID(ST_Point(-87.1229,20.5650),4326)),
  ('Isla Mujeres','Atracción','Isla Mujeres','Quintana Roo','00:00','23:59',0.00,6,ST_SetSRID(ST_Point(-86.7315,21.2310),4326)),
  ('Hotel Xcaret México','Hotel','Carr. Chetumal-Puerto Juárez km 282','Playa del Carmen','15:00','12:00',25000.00,6,ST_SetSRID(ST_Point(-87.1245,20.5820),4326)),

  -- Santa Fe (zona_id = 8)
  ('Four Seasons Hotel Mexico City Santa Fe','Hotel','Paseo de la Reforma 500','Ciudad de México','15:00','12:00',25000.00,8,ST_SetSRID(ST_Point(-99.1649,19.4260),4326)),
  ('The Westin Santa Fe','Hotel','Av. Vasco de Quiroga 3800','Ciudad de México','15:00','12:00',5000.00,8,ST_SetSRID(ST_Point(-99.2814,19.3600),4326)),

  -- Rutas naturales CE-MX (zona_id = 9)
  ('Reserva Biosfera Sierra Gorda','Reserva','Sierra Gorda, Querétaro','Querétaro','00:00','23:59',0.00,9,ST_SetSRID(ST_Point(-99.1915,21.0015),4326)),
  ('Parque Nacional Sierra de Órganos','Atracción','Sombrerete, Zacatecas','Zacatecas','08:00','17:00',0.00,9,ST_SetSRID(ST_Point(-103.0489,23.3150),4326)),

  -- Vaticano (zona_id = 10)
  ('Musei Vaticani','Museo','Viale Vaticano','Ciudad del Vaticano','09:00','18:00',17.00,10,ST_SetSRID(ST_Point(12.4536,41.9065),4326))
;

-- 9) Inserta 10 zonas adicionales
INSERT INTO zonas_turisticas (nombre_zona, tipo_zona, descripcion, geom) VALUES
  ('Zona Centro León','Barrio histórico','Centro histórico de León',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-101.6860 21.1210,-101.6750 21.1210,-101.6750 21.1340,-101.6860 21.1340,-101.6860 21.1210)')),4326)
  ),
  ('Ruta Parques CDMX','Ruta natural','Principales parques de Ciudad de México',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-99.2000 19.4000,-99.1000 19.4000,-99.1000 19.5000,-99.2000 19.5000,-99.2000 19.4000)')),4326)
  ),
  ('Barrio Roma Norte','Ruta sugerida','Zona cultural y gastronómica de Roma Norte',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(12.4880 41.9000,12.5000 41.9000,12.5000 41.9150,12.4880 41.9150,12.4880 41.9000)')),4326)
  ),
  ('Zona Costera Yucatán','Zona natural','Playas de Progreso y alrededores',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-89.7400 21.3000,-89.6000 21.3000,-89.6000 21.1000,-89.7400 21.1000,-89.7400 21.3000)')),4326)
  ),
  ('Ruta Arquitectónica GDL','Ruta sugerida','Edificios emblemáticos de Guadalajara',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-103.3500 20.6500,-103.3000 20.6500,-103.3000 20.7000,-103.3500 20.7000,-103.3500 20.6500)')),4326)
  ),
  ('Cañón del Sumidero','Ruta natural','Recorrido por el Cañón del Sumidero en Chiapas',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-93.0500 16.7500,-93.0000 16.7500,-93.0000 16.8500,-93.0500 16.8500,-93.0500 16.7500)')),4326)
  ),
  ('Centro Histórico Oaxaca','Barrio histórico','Centro histórico de Oaxaca de Juárez',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.7250 17.0500,-96.7000 17.0500,-96.7000 17.0800,-96.7250 17.0800,-96.7250 17.0500)')),4326)
  ),
  ('Ruta SMA','Ruta sugerida','Atracciones de San Miguel de Allende',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-100.7400 20.9100,-100.7100 20.9100,-100.7100 20.9500,-100.7400 20.9500,-100.7400 20.9100)')),4326)
  ),
  ('Centro Histórico Veracruz','Barrio histórico','Puerto y centro histórico de Veracruz',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-96.1500 19.1800,-96.1200 19.1800,-96.1200 19.2000,-96.1500 19.2000,-96.1500 19.1800)')),4326)
  ),
  ('Ruta Viñedos Valle','Ruta natural','Ruta de viñedos en Valle de Guadalupe',
     ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(-116.6000 32.0000,-116.5000 32.0000,-116.5000 32.1000,-116.6000 32.1000,-116.6000 32.0000)')),4326)
  )
;

-- 10) Verificación final
SELECT COUNT(*) AS total_puntos FROM lugares_turisticos;
SELECT COUNT(*) AS total_zonas  FROM zonas_turisticas;
