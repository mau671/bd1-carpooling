USE carpooling_adm;

-- ===================================
-- Institution related data
-- ===================================

-- Insert institution
INSERT INTO INSTITUTION (name)
VALUES ('Costa Rica Institute of Technology');

-- Insert domains
INSERT INTO DOMAIN (name)
VALUES 
  ('itcr.ac.cr'),
  ('tec.ac.cr'),
  ('estudiantec.cr');

-- Institution-Domain relations
INSERT INTO INSTITUTION_DOMAIN (institution_id, domain_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3);

-- ===================================
-- Person related data
-- ===================================

-- Insert gender options (IDs auto-generated)
INSERT INTO GENDER (name) VALUES
    ('Male'),
    ('Female'),
    ('Other'),
    ('Prefer not to say');

-- Insert identification types
INSERT INTO TYPE_IDENTIFICATION (name) VALUES
    ('ID Card'),
    ('Passport');

-- Insert phone types
INSERT INTO TYPE_PHONE (name) VALUES
    ('Mobile'),
    ('Landline'),
    ('Fax');

-- ===================================
-- Payment and trip related data
-- ===================================

-- Insert payment methods
INSERT INTO PAYMENTMETHOD (name) VALUES
    ('Credit Card'),
    ('Debit Card'),
    ('PayPal'),
    ('Sinpe Movil'),
    ('Cash');

-- Insert currencies
INSERT INTO CURRENCY (name) VALUES
    ('Colones'),
    ('US Dollar');

-- Insert trip status options
INSERT INTO STATUS (name) VALUES
    ('Pending'),
    ('In Progress'),
    ('Completed'),
    ('Cancelled');

-- Insert vehicle capacity options
INSERT INTO MAXCAPACITY (capacity_number) VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6);
-- ==============================
-- Insert into the COUNTRY table
-- ==============================
INSERT INTO COUNTRY (name)
VALUES ('Costa Rica');

-- ==============================
-- Insert into the PROVINCE table
-- ==============================
INSERT INTO PROVINCE (country_id, name) VALUES
    (1, 'San José'),
    (1, 'Alajuela'),
    (1, 'Cartago'),
    (1, 'Heredia'),
    (1, 'Guanacaste'),
    (1, 'Puntarenas'),
    (1, 'Limón');

-- ==============================
-- Insert into CANTON table
-- ==============================

-- San José (province_id = 1)
INSERT INTO CANTON (province_id, name) VALUES
(1, 'San José'),
(1, 'Escazú'),
(1, 'Desamparados'),
(1, 'Puriscal'),
(1, 'Tarrazú'),
(1, 'Aserrí'),
(1, 'Mora'),
(1, 'Goicoechea'),
(1, 'Santa Ana'),
(1, 'Alajuelita'),
(1, 'Coronado'),
(1, 'Acosta'),
(1, 'Tibás'),
(1, 'Moravia'),
(1, 'Montes de Oca'),
(1, 'Turrubares'),
(1, 'Dota'),
(1, 'Pérez Zeledón'),
(1, 'León Cortés');

-- Alajuela (province_id = 2)
INSERT INTO CANTON (province_id, name) VALUES
(2, 'Alajuela'),
(2, 'San Ramón'),
(2, 'Grecia'),
(2, 'San Mateo'),
(2, 'Atenas'),
(2, 'Naranjo'),
(2, 'Palmares'),
(2, 'Poas'),
(2, 'Orotina'),
(2, 'San Carlos'),
(2, 'Zarcero'),
(2, 'Valverde Vega'),
(2, 'Upala'),
(2, 'Los Chiles'),
(2, 'Guatuso');

-- Cartago (province_id = 3)
INSERT INTO CANTON (province_id, name) VALUES
(3, 'Cartago'),
(3, 'Paraíso'),
(3, 'La Unión'),
(3, 'Jiménez'),
(3, 'Turrialba'),
(3, 'Alvarado'),
(3, 'Oreamuno'),
(3, 'El Guarco');

-- Heredia (province_id = 4)
INSERT INTO CANTON (province_id, name) VALUES
(4, 'Heredia'),
(4, 'Barva'),
(4, 'Santo Domingo'),
(4, 'Santa Barbara'),
(4, 'San Rafael'),
(4, 'San Isidro'),
(4, 'Belén'),
(4, 'Flores'),
(4, 'San Pablo'),
(4, 'Sarapiqui');

-- Guanacaste (province_id = 5)
INSERT INTO CANTON (province_id, name) VALUES
(5, 'Liberia'),
(5, 'Nicoya'),
(5, 'Santa Cruz'),
(5, 'Bagaces'),
(5, 'Carrillo'),
(5, 'Cañas'),
(5, 'Abangares'),
(5, 'Tilarán'),
(5, 'Nandayure'),
(5, 'La Cruz'),
(5, 'Hojancha');

-- Puntarenas (province_id = 6)
INSERT INTO CANTON (province_id, name) VALUES
(6, 'Puntarenas'),
(6, 'Esparza'),
(6, 'Buenos Aires'),
(6, 'Montes de Oro'),
(6, 'Osa'),
(6, 'Aguirre'),
(6, 'Golfito'),
(6, 'Brus'),
(6, 'Parrita'),
(6, 'Corredores'),
(6, 'Garabito');

-- Limón (province_id = 7)
INSERT INTO CANTON (province_id, name) VALUES
(7, 'Limón'),
(7, 'Pococí'),
(7, 'Siquirres'),
(7, 'Talamanca'),
(7, 'Matina'),
(7, 'Guácimo');

-- ==============================
-- Insert into DISTRICT table
-- ==============================

-- San Jose (canton_id = 1)
INSERT INTO DISTRICT (canton_id, name) VALUES
(1, 'Carmen'),
(1, 'Merced'),
(1, 'Hospital'),
(1, 'Catedral'),
(1, 'Zapote'),
(1, 'San Francisco de Dos Ríos'),
(1, 'Uruca'),
(1, 'Mata Redonda'),
(1, 'Pavas'),
(1, 'Hatillo'),
(1, 'San Sebastian');

-- Escazu (canton_id = 2)
INSERT INTO DISTRICT (canton_id, name) VALUES
(2, 'Escazú'),
(2, 'San Antonio'),
(2, 'San Rafael');

-- Desamparados (canton_id = 3)
INSERT INTO DISTRICT (canton_id, name) VALUES
(3, 'Desamparados'),
(3, 'San Miguel'),
(3, 'San Juan de Dios'),
(3, 'San Rafael Arriba'),
(3, 'San Antonio'),
(3, 'Frailes'),
(3, 'Patarra'),
(3, 'San Cristobal'),
(3, 'Rosario'),
(3, 'Damas'),
(3, 'San Rafael Abajo'),
(3, 'Gravilias'),
(3, 'Los Guido');

-- Puriscal (canton_id = 4)
INSERT INTO DISTRICT (canton_id, name) VALUES
(4, 'Santiago'),
(4, 'Mercedes Sur'),
(4, 'Barbacoas'),
(4, 'Grifo Alto'),
(4, 'San Rafael'),
(4, 'Candelaria'),
(4, 'Desamparaditos'),
(4, 'San Antonio'),
(4, 'Chires'),
(4, 'San Marcos');

-- Tarrazu (canton_id = 5)
INSERT INTO DISTRICT (canton_id, name) VALUES
(5, 'San Marcos'),
(5, 'San Lorenzo'),
(5, 'San Carlos');

-- Aserri (canton_id = 6)
INSERT INTO DISTRICT (canton_id, name) VALUES
(6, 'Aserrí'),
(6, 'Tarbaca o Praga'),
(6, 'Vuelta de Jorco'),
(6, 'San Gabriel'),
(6, 'La Legua'),
(6, 'Monterrey'),
(6, 'Salitrillos');

-- Mora (canton_id = 7)
INSERT INTO DISTRICT (canton_id, name) VALUES
(7, 'Colón'),
(7, 'Guayabo'),
(7, 'Tabarcia'),
(7, 'Piedras Negras'),
(7, 'Picagres');

-- Goicoechea (canton_id = 8)
INSERT INTO DISTRICT (canton_id, name) VALUES
(8, 'Guadalupe'),
(8, 'San Francisco'),
(8, 'Calle Blancos'),
(8, 'Mata de Plátano'),
(8, 'Ipís'),
(8, 'Rancho Redondo'),
(8, 'Purnal');

-- Santa Ana (canton_id = 9)
INSERT INTO DISTRICT (canton_id, name) VALUES
(9, 'Santa Ana'),
(9, 'Salitral'),
(9, 'Pozos o Concepción'),
(9, 'Uruca o San Joaquín'),
(9, 'Piedades'),
(9, 'Brasil');

-- Alajuelita (canton_id = 10)
INSERT INTO DISTRICT (canton_id, name) VALUES
(10, 'Alajuelita'),
(10, 'San Josecito'),
(10, 'San Antonio'),
(10, 'Concepción'),
(10, 'San Felipe');

-- Coronado (canton_id = 11)
INSERT INTO DISTRICT (canton_id, name) VALUES
(11, 'San Isidro'),
(11, 'San Rafael'),
(11, 'Dulce Nombre o Jesús'),
(11, 'Patallilo'),
(11, 'Cascajal');

-- Acosta (canton_id = 12)
INSERT INTO DISTRICT (canton_id, name) VALUES
(12, 'San Ignacio'),
(12, 'Guaitil'),
(12, 'Palmichal'),
(12, 'Cangrejal'),
(12, 'Sabanillas');

-- Tibas (canton_id = 13)
INSERT INTO DISTRICT (canton_id, name) VALUES
(13, 'San Juan'),
(13, 'Cinco Esquinas'),
(13, 'Anselmo Llorente'),
(13, 'León XIII'),
(13, 'Colima');

-- Moravia (canton_id = 14)
INSERT INTO DISTRICT (canton_id, name) VALUES
(14, 'San Vicente'),
(14, 'San Jerónimo'),
(14, 'La Trinidad');

-- Montes de Oca (canton_id = 15)
INSERT INTO DISTRICT (canton_id, name) VALUES
(15, 'San Pedro'),
(15, 'Sabanilla'),
(15, 'Mercedes o Betania'),
(15, 'San Rafael');

-- Turrubares (canton_id = 16)
INSERT INTO DISTRICT (canton_id, name) VALUES
(16, 'San Pablo'),
(16, 'San Pedro'),
(16, 'San Juan de Mata'),
(16, 'San Luis'),
(16, 'Carara');

-- Dota (canton_id = 17)
INSERT INTO DISTRICT (canton_id, name) VALUES
(17, 'Santa María'),
(17, 'Jardín'),
(17, 'Copey');

-- Pérez Zeledón (canton_id = 18)
INSERT INTO DISTRICT (canton_id, name) VALUES
(18, 'San Isidro'),
(18, 'General'),
(18, 'Daniel Flores'),
(18, 'Rivas'),
(18, 'San Pedro'),
(18, 'Platanares'),
(18, 'Pejibaye'),
(18, 'Cajón o Carmen'),
(18, 'Bard'),
(18, 'Río Nuevo'),
(18, 'Páramo');

-- León Cortés (canton_id = 19)
INSERT INTO DISTRICT (canton_id, name) VALUES
(19, 'San Pablo'),
(19, 'San Andrés'),
(19, 'Llano Bonito'),
(19, 'San Isidro'),
(19, 'Santa Cruz'),
(19, 'San Antonio');

-- Alajuela (canton_id = 20)
INSERT INTO DISTRICT (canton_id, name) VALUES
(20, 'Alajuela'),
(20, 'San José'),
(20, 'Carrizal'),
(20, 'San Antonio'),
(20, 'Guácima'),
(20, 'San Isidro'),
(20, 'Sabanilla'),
(20, 'San Rafael'),
(20, 'Río Segundo'),
(20, 'Desamparados'),
(20, 'Turrucares'),
(20, 'Tambor'),
(20, 'La Garita'),
(20, 'Sarapiquí');

-- San Ramón (canton_id = 21)
INSERT INTO DISTRICT (canton_id, name) VALUES
(21, 'San Ramón'),
(21, 'Santiago'),
(21, 'San Juan'),
(21, 'Piedades Norte'),
(21, 'Piedades Sur'),
(21, 'San Rafael'),
(21, 'San Isidro'),
(21, 'Angeles'),
(21, 'Alfaro'),
(21, 'Volio'),
(21, 'Concepción'),
(21, 'Zapotal'),
(21, 'San Isidro de Peñas Blancas');

-- Grecia (canton_id = 22)
INSERT INTO DISTRICT (canton_id, name) VALUES
(22, 'Grecia'),
(22, 'San Isidro'),
(22, 'San José'),
(22, 'San Roque'),
(22, 'Tacares'),
(22, 'Río Cuarto'),
(22, 'Puente Piedra'),
(22, 'Bolívar');

-- San Mateo (canton_id = 23)
INSERT INTO DISTRICT (canton_id, name) VALUES
(23, 'San Mateo'),
(23, 'Desmonte'),
(23, 'Jesús María');

-- Atenas (canton_id = 24)
INSERT INTO DISTRICT (canton_id, name) VALUES
(24, 'Atenas'),
(24, 'Jesús'),
(24, 'Mercedes'),
(24, 'San Isidro'),
(24, 'Concepción'),
(24, 'San José'),
(24, 'Santa Eulalia'),
(24, 'Escobal');

-- Naranjo (canton_id = 25)
INSERT INTO DISTRICT (canton_id, name) VALUES
(25, 'Naranjo'),
(25, 'San Miguel'),
(25, 'San José'),
(25, 'Cirrí Sur'),
(25, 'San Jerónimo'),
(25, 'San Juan'),
(25, 'Rosario');

-- Palmares (canton_id = 26)
INSERT INTO DISTRICT (canton_id, name) VALUES
(26, 'Palmares'),
(26, 'Zaragoza'),
(26, 'Buenos Aires'),
(26, 'Santiago'),
(26, 'Candelaria'),
(26, 'Esquipulas'),
(26, 'La Granja');

-- Poás (canton_id = 27)
INSERT INTO DISTRICT (canton_id, name) VALUES
(27, 'San Pedro'),
(27, 'San Juan'),
(27, 'San Rafael'),
(27, 'Carrillos'),
(27, 'Sabana Redonda');

-- Orotina (canton_id = 28)
INSERT INTO DISTRICT (canton_id, name) VALUES
(28, 'Orotina'),
(28, 'Mastate'),
(28, 'Hacienda Vieja'),
(28, 'Coyolar'),
(28, 'Ceiba');

-- San Carlos (canton_id = 29)
INSERT INTO DISTRICT (canton_id, name) VALUES
(29, 'Quesada'),
(29, 'Florencia'),
(29, 'Buenavista'),
(29, 'Aguas Zarcas'),
(29, 'Venecia'),
(29, 'Pital'),
(29, 'Fortuna'),
(29, 'Tigra'),
(29, 'Palmera'),
(29, 'Venado'),
(29, 'Cutris'),
(29, 'Monterrey'),
(29, 'Pocosol');

-- Alfaro Ruiz (canton_id = 30)
INSERT INTO DISTRICT (canton_id, name) VALUES
(30, 'Zarcero'),
(30, 'Laguna'),
(30, 'Tapezco'),
(30, 'Guadalupe'),
(30, 'Palmira'),
(30, 'Zapote'),
(30, 'Brisas');

-- Valverde Vega (canton_id = 31)
INSERT INTO DISTRICT (canton_id, name) VALUES
(31, 'Sarchí Norte'),
(31, 'Sarchí Sur'),
(31, 'Toro Amarillo'),
(31, 'San Pedro'),
(31, 'Rodríguez');

-- Upala (canton_id = 32)
INSERT INTO DISTRICT (canton_id, name) VALUES
(32, 'Upala'),
(32, 'Aguas Claras'),
(32, 'San José o Pizote'),
(32, 'Bijagua'),
(32, 'Delicias'),
(32, 'Dos Ríos'),
(32, 'Yollilal');

-- Los Chiles (canton_id = 33)
INSERT INTO DISTRICT (canton_id, name) VALUES
(33, 'Los Chiles'),
(33, 'Caño Negro'),
(33, 'Amparo'),
(33, 'San Jorge');

-- Guatuso (canton_id = 34)
INSERT INTO DISTRICT (canton_id, name) VALUES
(34, 'San Rafael'),
(34, 'Buenavista'),
(34, 'Cote');

-- Cartago (canton_id = 35)
INSERT INTO DISTRICT (canton_id, name) VALUES
(35, 'Oriental'),
(35, 'Occidental'),
(35, 'Carmen'),
(35, 'San Nicolás'),
(35, 'Aguacaliente (San Francisco)'),
(35, 'Guadalupe (Arenilla)'),
(35, 'Corralillo'),
(35, 'Tierra Blanca'),
(35, 'Dulce Nombre'),
(35, 'Llano Grande'),
(35, 'Quebradilla');

-- Paraíso (canton_id = 36)
INSERT INTO DISTRICT (canton_id, name) VALUES
(36, 'Paraíso'),
(36, 'Santiago'),
(36, 'Orosi'),
(36, 'Cachí'),
(36, 'Llanos de Sta Lucia');

-- La Unión (canton_id = 37)
INSERT INTO DISTRICT (canton_id, name) VALUES
(37, 'Tres Ríos'),
(37, 'San Diego'),
(37, 'San Juan'),
(37, 'San Rafael'),
(37, 'Concepción'),
(37, 'Dulce Nombre'),
(37, 'San Ramón'),
(37, 'Río Azul');

-- Jiménez (canton_id = 38)
INSERT INTO DISTRICT (canton_id, name) VALUES
(38, 'Juan Viñas'),
(38, 'Tucurrique'),
(38, 'Pejibaye');

-- Turrialba (canton_id = 39)
INSERT INTO DISTRICT (canton_id, name) VALUES
(39, 'Turrialba'),
(39, 'La Suiza'),
(39, 'Peralta'),
(39, 'Santa Cruz'),
(39, 'Santa Teresita'),
(39, 'Pavones'),
(39, 'Tuis'),
(39, 'Tayutic'),
(39, 'Santa Rosa'),
(39, 'Tres Equis'),
(39, 'La Isabel'),
(39, 'Chirripo');

-- Alvarado (canton_id = 40)
INSERT INTO DISTRICT (canton_id, name) VALUES
(40, 'Pacayas'),
(40, 'Cervantes'),
(40, 'Capellades');

-- Oreamuno (41)
INSERT INTO DISTRICT (canton_id, name) VALUES
(41, 'San Rafael'),
(41, 'Cot'),
(41, 'Potrero Cerrado'),
(41, 'Cipreses'),
(41, 'Santa Rosa');

-- El Guarco (42)
INSERT INTO DISTRICT (canton_id, name) VALUES
(42, 'El Tejar'),
(42, 'San Isidro'),
(42, 'Tobosi'),
(42, 'Patio de Agua');

-- Heredia (43)
INSERT INTO DISTRICT (canton_id, name) VALUES
(43, 'Heredia'),
(43, 'Mercedes'),
(43, 'San Francisco'),
(43, 'Ulloa'),
(43, 'Vara Blanca');

-- Barva (44)
INSERT INTO DISTRICT (canton_id, name) VALUES
(44, 'Barva'),
(44, 'San Pedro'),
(44, 'San Pablo'),
(44, 'San Roque'),
(44, 'Santa Lucía'),
(44, 'San Jose de la Montaña');

-- Santo Domingo (45)
INSERT INTO DISTRICT (canton_id, name) VALUES
(45, 'Santo Domingo'),
(45, 'San Vicente'),
(45, 'San Miguel'),
(45, 'Paracito'),
(45, 'Santo Tomás'),
(45, 'Santa Rosa'),
(45, 'Tures'),
(45, 'Pará');

-- Santa Bárbara (46)
INSERT INTO DISTRICT (canton_id, name) VALUES
(46, 'Santa Bárbara'),
(46, 'San Pedro'),
(46, 'San Juan'),
(46, 'Jesús'),
(46, 'Santo Domingo del Roble'),
(46, 'Puraba');

-- San Rafael (47)
INSERT INTO DISTRICT (canton_id, name) VALUES
(47, 'San Rafael'),
(47, 'San Josecito'),
(47, 'Santiago'),
(47, 'Angeles'),
(47, 'Concepción');

-- San Isidro (48)
INSERT INTO DISTRICT (canton_id, name) VALUES
(48, 'San Isidro'),
(48, 'San José'),
(48, 'Concepción'),
(48, 'San Francisco');

-- Belén (49)
INSERT INTO DISTRICT (canton_id, name) VALUES
(49, 'San Antonio'),
(49, 'La Ribera'),
(49, 'Asunción');

-- Flores (50)
INSERT INTO DISTRICT (canton_id, name) VALUES
(50, 'San Joaquín'),
(50, 'Barrantes'),
(50, 'Llorente');

-- San Pablo (51)
INSERT INTO DISTRICT (canton_id, name) VALUES
(51, 'San Pablo');

-- Sarapiquí (52)
INSERT INTO DISTRICT (canton_id, name) VALUES
(52, 'Puerto Viejo'),
(52, 'La Virgen'),
(52, 'Horquetas'),
(52, 'Llanuras del Gaspar'),
(52, 'Cureña');

-- Liberia (53)
INSERT INTO DISTRICT (canton_id, name) VALUES
(53, 'Liberia'),
(53, 'Cañas Dulces'),
(53, 'Mayorga'),
(53, 'Nacascolo'),
(53, 'Curubande');

-- Nicoya (54)
INSERT INTO DISTRICT (canton_id, name) VALUES
(54, 'Nicoya'),
(54, 'Mansión'),
(54, 'San Antonio'),
(54, 'Quebrada Honda'),
(54, 'Sámara'),
(54, 'Nosara'),
(54, 'Belén de Nosarita');

-- Santa Cruz (55)
INSERT INTO DISTRICT (canton_id, name) VALUES
(55, 'Santa Cruz'),
(55, 'Bolsón'),
(55, 'Veintisiete de Abril'),
(55, 'Tempate'),
(55, 'Cartagena'),
(55, 'Cuajiniquil'),
(55, 'Diriá'),
(55, 'Cabo Velas'),
(55, 'Tamarindo');

-- Bagaces (56)
INSERT INTO DISTRICT (canton_id, name) VALUES
(56, 'Bagaces'),
(56, 'Fortuna'),
(56, 'Mogote'),
(56, 'Río Naranjo');

-- Carrillo (57)
INSERT INTO DISTRICT (canton_id, name) VALUES
(57, 'Filadelfia'),
(57, 'Palmira'),
(57, 'Sardinal'),
(57, 'Belén');

-- Cañas (58)
INSERT INTO DISTRICT (canton_id, name) VALUES
(58, 'Cañas'),
(58, 'Palmira'),
(58, 'San Miguel'),
(58, 'Bebedero'),
(58, 'Porozal');

-- Abangares (59)
INSERT INTO DISTRICT (canton_id, name) VALUES
(59, 'Juntas'),
(59, 'Sierra'),
(59, 'San Juan'),
(59, 'Colorado');

-- Tilarán (60)
INSERT INTO DISTRICT (canton_id, name) VALUES
(60, 'Tilarán'),
(60, 'Quebrada Grande'),
(60, 'Tronadora'),
(60, 'Santa Rosa'),
(60, 'Líbano'),
(60, 'Tierras Morenas'),
(60, 'Arenal');

-- Nandayure (61)
INSERT INTO DISTRICT (canton_id, name) VALUES
(61, 'Carmona'),
(61, 'Santa Rita'),
(61, 'Zapotal'),
(61, 'San Pablo'),
(61, 'Porvenir'),
(61, 'Bejuco');

-- La Cruz (62)
INSERT INTO DISTRICT (canton_id, name) VALUES
(62, 'La Cruz'),
(62, 'Santa Cecilia'),
(62, 'Garita'),
(62, 'Santa Elena');

-- Hojancha (63)
INSERT INTO DISTRICT (canton_id, name) VALUES
(63, 'Hojancha'),
(63, 'Monte Romo'),
(63, 'Puerto Carrillo'),
(63, 'Huacas');

-- Puntarenas (64)
INSERT INTO DISTRICT (canton_id, name) VALUES
(64, 'Puntarenas'),
(64, 'Pitahaya'),
(64, 'Chomes'),
(64, 'Lepanto'),
(64, 'Paquera'),
(64, 'Manzanillo'),
(64, 'Guacimal'),
(64, 'Barranca'),
(64, 'Monte Verde'),
(64, 'Isla del Coco'),
(64, 'Cóbano'),
(64, 'Chacarita'),
(64, 'Chira (Isla)'),
(64, 'Acapulco'),
(64, 'El Roble'),
(64, 'Arancibia');

-- Esparza (65)
INSERT INTO DISTRICT (canton_id, name) VALUES
(65, 'Espíritu Santo'),
(65, 'San Juan Grande'),
(65, 'Macacona'),
(65, 'San Rafael'),
(65, 'San Jerónimo');

-- Buenos Aires (66)
INSERT INTO DISTRICT (canton_id, name) VALUES
(66, 'Buenos Aires'),
(66, 'Volcán'),
(66, 'Potrero Grande'),
(66, 'Boruca'),
(66, 'Pilas'),
(66, 'Colinas o Bajo de Maíz'),
(66, 'Chánguena'),
(66, 'Bioley'),
(66, 'Brunka');

-- Montes de Oro (67)
INSERT INTO DISTRICT (canton_id, name) VALUES
(67, 'Miramar'),
(67, 'Unión'),
(67, 'San Isidro');

-- Osa (68)
INSERT INTO DISTRICT (canton_id, name) VALUES
(68, 'Puerto Cortés'),
(68, 'Palmar'),
(68, 'Sierpe'),
(68, 'Bahía Ballena'),
(68, 'Piedras Blancas');

-- Aguirre (69)
INSERT INTO DISTRICT (canton_id, name) VALUES
(69, 'Quepos'),
(69, 'Savegre'),
(69, 'Naranjito');

-- Golfito (70)
INSERT INTO DISTRICT (canton_id, name) VALUES
(70, 'Golfito'),
(70, 'Puerto Jiménez'),
(70, 'Guaycará'),
(70, 'Pavones o Villa Conte');

-- Coto Brus (71)
INSERT INTO DISTRICT (canton_id, name) VALUES
(71, 'San Vito'),
(71, 'Sabalito'),
(71, 'Agua Buena'),
(71, 'Limoncito'),
(71, 'Pittier');

-- Parrita (72)
INSERT INTO DISTRICT (canton_id, name) VALUES
(72, 'Parrita');

-- Corredores (73)
INSERT INTO DISTRICT (canton_id, name) VALUES
(73, 'Corredores'),
(73, 'La Cuesta'),
(73, 'Paso Canoas'),
(73, 'Laurel');

-- Garabito (74)
INSERT INTO DISTRICT (canton_id, name) VALUES
(74, 'Jacó'),
(74, 'Tárcoles');

-- Canton Limón (75)
INSERT INTO DISTRICT (canton_id, name) VALUES
(75, 'Limón'),
(75, 'Valle La Estrella'),
(75, 'Río Blanco'),
(75, 'Matama');

-- Canton Pococí (76)
INSERT INTO DISTRICT (canton_id, name) VALUES
(76, 'Guápiles'),
(76, 'Jiménez'),
(76, 'Rita'),
(76, 'Roxana'),
(76, 'Cariari'),
(76, 'Colorado');

-- Canton Siquirres (77)
INSERT INTO DISTRICT (canton_id, name) VALUES
(77, 'Siquirres'),
(77, 'Pacuare'),
(77, 'Florida'),
(77, 'Germania'),
(77, 'Cairo'),
(77, 'Alegría');

-- Canton Talamanca (78)
INSERT INTO DISTRICT (canton_id, name) VALUES
(78, 'Bratsi'),
(78, 'Sixaola'),
(78, 'Cahuita'),
(78, 'Telire');

-- Canton Matina (79)
INSERT INTO DISTRICT (canton_id, name) VALUES
(79, 'Matina'),
(79, 'Batán'),
(79, 'Carrandi');

-- Canton Guácimo (80)
INSERT INTO DISTRICT (canton_id, name) VALUES
(80, 'Guácimo'),
(80, 'Mercedes'),
(80, 'Pocora'),
(80, 'Río Jiménez'),
(80, 'Duacari');
