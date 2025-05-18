-- ==================================================================
-- Insersion de datos en bruto para valores que no seran modificados
-- ==================================================================

-- ==============================
-- Insertar en la tabla COUNTRY
-- ==============================
INSERT INTO COUNTRY (id, name)
VALUES (COUNTRY_SEQ.NEXTVAL, 'Costa Rica');

-- ==============================
-- Insertar en la tabla PROVINCE
-- ==============================
INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'San José');

INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'Alajuela');

INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'Cartago');

INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'Heredia');

INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'Guanacaste');

INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'Puntarenas');

INSERT INTO PROVINCE (id, country_id, name)
VALUES (PROVINCE_SEQ.NEXTVAL, 1, 'Limón');

-- ==============================
-- Insertar en la tabla CANTON
-- ==============================
-- San Jose
INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'San Jose');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Escazu');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Desamparados');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Puriscal');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Tarrazu');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Aserri');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Mora');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Goicoechea');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Santa Ana');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Alajuelita');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Coronado');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Acosta');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Tibas');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Moravia');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Monter de oca');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Turrubares');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Dota');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Perez Zeledon');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 1, 'Leon Cortes');

-- Alajuela

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Alajuela');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'San Ramon');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Grecia');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'San Mateo');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Atenas');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Naranjo');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Palmares');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Poas');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Orotina');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'San Carlos');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Alfaro Ruiz');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Valverde Vega');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Upala');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Los Chiles');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 2, 'Guatuso');

-- Cartago
INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'Cartago');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'Paraiso');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'La Union');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'Jimenez');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'Turrialba');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'Alvarado');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'Oreamuno');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 3, 'El GUarco');

-- Heredia
INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Heredia');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Barva');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Santo Domingo');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Santa Barbara');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'San Rafael');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'San Isidro');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Belen');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Flores');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'San Pablo');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 4, 'Sarapiqui');

-- Guanacaste
INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Liberia');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Nicoya');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Santa Cruz');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Bagaces');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Carrillo');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Cañas');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Abangares');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Tilaran');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Nandayure');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'La Cruz');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 5, 'Hojancha');

-- Puntarenas
INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Puntarenas');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Esparza');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Buenos Aires');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Montes de Oro');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Osa');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Aguirre');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Golfito');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Brus');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Parrita');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Corredores');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 6, 'Garabito');

-- Limon
INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 7, 'Limon');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 7, 'Pococi');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 7, 'Siquirres');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 7, 'Talamanca');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 7, 'Matina');

INSERT INTO CANTON (id, province_id, name)
VALUES (CANTON_SEQ.NEXTVAL, 7, 'Guacimo');

-- ==============================
-- Insertar en la tabla DISTRICT
-- ==============================

-- San Jose Province Cantons (1-18)
-- San Jose (1)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Carmen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Merced');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Hospital');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Catedral');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Zapote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'San Francisco de Dos Rios');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Uruca');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Mata Redonda');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Pavas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'Hatillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 1, 'San Sebastian');

--Escazu(2)

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Escazu');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'San Rafael');

--Desamparados (3)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Desamparados');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Miguel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Juan de Dios');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Rafael Arriba');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Frailes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Patarra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Cristobal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Rosario');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Damas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Rafael Abajo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Gravilias');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Los Guido');

--Puriscal (4)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Mercedes Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Barbacoas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Grifo Alto');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Rafeal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Candelaria');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Desamparaditos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Chires');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Marcos');

-- Canton Tarrazu (5)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'San Marcos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'San Lorenzo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'San Carlos');

-- Canton Aserri (6)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'Aserrí');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'Tarbaca o Praga');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'Vuelta de Jorco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'San Gabriel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'La Legua');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'Monterrey');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'Salitrillos');

-- Canton Mora (7)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Colón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Guayabo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Tabarcia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Piedras Negras');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Picagres');

-- Canton Goicoechea (8)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Guadalupe');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'San Francisco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Calle Blancos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Mata de Plátano');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Ipís');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Rancho Redondo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Purnal');

-- Canton Santa Ana (9)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Santa Ana');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Saltiral');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Pozos o Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Uruca o San Joaquín');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Piedades');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Brasil');

-- Canton Alajuelita (10)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Alajuelita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'San Josecito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'San Felipe');

-- Canton Coronado (11)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'Dulce Nombre o Jesús');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'Patallilo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'Cascajal');

-- Canton Acosta (12)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'San Ignacio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Guaitil');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Palmichal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Cangrejal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Sabanillas');

-- Canton Tibas (13)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Cinco Esquinas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Anselmo Llorente');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'León XIII');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Colima');

-- Canton Moravia (14)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'San Vicente');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'San Jerónimo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'La Trinidad');

-- Canton Montes de Oca (15)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'Sabanilla');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'Mercedes o Betania');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'San Rafael');

-- Canton Turrubares (16)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'San Juan de Mata');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'San Luis');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'Carara');

-- Canton Dota (17)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'Santa María');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'Jardín');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'Copey');

-- Canton Perez Zeledon (18)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'General');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Daniel Flores');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Rivas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Platanares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Pejibaye');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Cajón o Carmen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Bard');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Río Nuevo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Páramo');

-- Canton Leon Cortes (19)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'San Andrés');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Llano Bonito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Santa Cruz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'San Antonio');

-- Alajuela Province Cantons (20-33)
-- Canton Alajuela (20)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Alajuela');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Carrizal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Guácima');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Sabanilla');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Río Segundo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Desamparados');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Turrucares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Tambor');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'La Garita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Sarapiquí');

-- Canton San Ramon (21)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Ramón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Piedades Norte');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Piedades Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Angeles');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Alfaro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Volio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Zapotal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Isidro de Peñas Blancas');

-- Canton Grecia (22)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Grecia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Roque');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Tacares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Río Cuarto');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Puente Piedra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Bolívar');

-- Canton San Mateo (23)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'San Mateo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Desmonte');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Jesús María');

-- Canton Atenas (24)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Atenas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Jesús');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Mercedes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Santa Eulalia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Escobal');

-- Canton Naranjo (25)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Naranjo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'San Miguel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Cirrí Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'San Jerónimo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Rosario');

-- Canton Palmares (26)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Palmares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Zaragoza');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Buenos Aires');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Candelaria');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Esquipulas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'La Granja');

-- Canton Poas (27)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Carrillos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Sabana Redonda');

-- Canton Orotina (28)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Orotina');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Mastate');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Hacienda Vieja');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Coyolar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Ceiba');

-- Canton San Carlos (29)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Quesada');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Florencia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Buenavista');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Aguas Zarcas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Venecia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Pital');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Fortuna');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Tigra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Palmera');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Venado');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Cutris');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Monterrey');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Pocosol');

-- Canton Alfaro Ruiz (30)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Zarcero');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Laguna');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Tapezco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Guadalupe');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Palmira');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Zapote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Brisas');

-- Canton Valverde Vega (31)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Sarchí Norte');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Sarchí Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Toro Amarillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Rodríguez');

-- Canton Upala (32)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Upala');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Aguas Claras');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'San José o Pizote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Bijagua');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Delicias');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Dos Ríos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Yollilal');

-- Canton Los Chiles (33)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Los Chiles');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Caño Negro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Amparo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'San Jorge');

-- Canton Guatuso (34)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'Buenavista');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'Cote');

-- Cartago Province Cantons (35-42)
-- Canton Cartago (35)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Oriental');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Occidental');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Carmen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'San Nicolás');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Aguacaliente (San Francisco)');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Guadalupe (Arenilla)');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Corralillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Tierra Blanca');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Dulce Nombre');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Llano Grande');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Quebradilla');

-- Canton Paraiso (36)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Paraíso');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Orosi');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Cachí');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Llanos de Sta Lucia');

-- Canton La Union (37)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Tres Ríos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'San Diego');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Dulce Nombre');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'San Ramón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Río Azul');

-- Canton Jimenez (38)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Juan Viñas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Tucurrique');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Pejibaye');

-- Canton Turrialba (39)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Turrialba');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'La Suiza');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Peralta');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Santa Cruz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Santa Teresita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Pavones');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Tuis');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Tayutic');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Santa Rosa');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Tres Equis');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'La Isabel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Chirripo');

-- Canton Alvarado (40)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Pacayas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Cervantes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Capellades');

-- Canton Oreamuno (41)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Cot');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Potrero Cerrado');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Cipreses');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Santa Rosa');

-- Canton El Guarco (42)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'El Tejar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'Tobosi');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'Patio de Agua');

-- Heredia Province Cantons (43-52)
-- Canton Heredia (43)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'Heredia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'Mercedes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'San Francisco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'Ulloa');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'Vara Blanca');

-- Canton Barva (44)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'Barva');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'San Roque');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'Santa Lucía');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'San Jose de la Montaña');

-- Canton Santo Domingo (45)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Santo Domingo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'San Vicente');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'San Miguel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Paracito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Santo Tomás');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Santa Rosa');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Tures');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Pará');

-- Canton Santa Bárbara (46)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 46, 'Santa Bárbara');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 46, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 46, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 46, 'Jesús');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 46, 'Santo Domingo del Roble');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 46, 'Puraba');

-- Canton San Rafael (47)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 47, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 47, 'San Josecito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 47, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 47, 'Angeles');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 47, 'Concepción');

-- Canton San Isidro (48)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 48, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 48, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 48, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 48, 'San Francisco');

-- Canton Belén (49)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 49, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 49, 'La Ribera');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 49, 'Asunción');

-- Canton Flores (50)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 50, 'San Joaquín');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 50, 'Barrantes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 50, 'Llorente');

-- Canton San Pablo (51)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 51, 'San Pablo');

-- Canton Sarapiquí (52)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 52, 'Puerto Viejo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 52, 'La Virgen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 52, 'Horquetas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 52, 'Llanuras del Gaspar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 52, 'Cureña');

-- =============================================
-- Guanacaste province cantons (53-63)
-- =============================================

-- Canton Liberia (53)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 53, 'Liberia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 53, 'Cañas Dulces');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 53, 'Mayorga');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 53, 'Nacascolo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 53, 'Curubande');

-- Canton Nicoya (54)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'Nicoya');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'Mansión');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'Quebrada Honda');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'Sámara');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'Nosara');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 54, 'Belén de Nosarita');

-- Canton Santa Cruz (55)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Santa Cruz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Bolsón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Veintisiete de Abril');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Tempate');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Cartagena');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Cuajiniquil');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Diriá');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Cabo Velas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 55, 'Tamarindo');

-- Canton Bagaces (56)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 56, 'Bagaces');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 56, 'Fortuna');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 56, 'Mogote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 56, 'Río Naranjo');

-- Canton Carrillo (57)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 57, 'Filadelfia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 57, 'Palmira');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 57, 'Sardinal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 57, 'Belén');

-- Canton Cañas (58)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 58, 'Cañas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 58, 'Palmira');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 58, 'San Miguel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 58, 'Bebedero');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 58, 'Porozal');

-- Canton Abangares (59)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 59, 'Juntas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 59, 'Sierra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 59, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 59, 'Colorado');

-- Canton Tilarán (60)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Tilarán');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Quebrada Grande');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Tronadora');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Santa Rosa');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Líbano');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Tierras Morenas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 60, 'Arenal');

-- Canton Nandayure (61)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 61, 'Carmona');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 61, 'Santa Rita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 61, 'Zapotal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 61, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 61, 'Porvenir');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 61, 'Bejuco');

-- Canton La Cruz (62)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 62, 'La Cruz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 62, 'Santa Cecilia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 62, 'Garita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 62, 'Santa Elena');

-- Canton Hojancha (63)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 63, 'Hojancha');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 63, 'Monte Romo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 63, 'Puerto Carrillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 63, 'Huacas');

-- Puntarenas province cantons (64-74)
-- Canton Puntarenas (64)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Puntarenas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Pitahaya');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Chomes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Lepanto');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Paquera');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Manzanillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Guacimal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Barranca');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Monte Verde');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Isla del Coco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Cóbano');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Chacarita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Chira (Isla)');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Acapulco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'El Roble');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 64, 'Arancibia');

-- Canton Esparza (65)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 65, 'Espíritu Santo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 65, 'San Juan Grande');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 65, 'Macacona');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 65, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 65, 'San Jerónimo');

-- Canton Buenos Aires (66)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Buenos Aires');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Volcán');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Potrero Grande');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Boruca');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Pilas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Colinas o Bajo de Maíz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Chánguena');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Bioley');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 66, 'Brunka');

-- Canton Montes de Oro (67)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 67, 'Miramar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 67, 'Unión');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 67, 'San Isidro');

-- Canton Osa (68)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 68, 'Puerto Cortés');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 68, 'Palmar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 68, 'Sierpe');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 68, 'Bahía Ballena');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 68, 'Piedras Blancas');

-- Canton Aguirre (69)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 69, 'Quepos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 69, 'Savegre');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 69, 'Naranjito');

-- Canton Golfito (70)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 70, 'Golfito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 70, 'Puerto Jiménez');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 70, 'Guaycará');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 70, 'Pavones o Villa Conte');

-- Canton Coto Brus (71)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 71, 'San Vito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 71, 'Sabalito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 71, 'Agua Buena');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 71, 'Limoncito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 71, 'Pittier');

-- Canton Parrita (72)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 72, 'Parrita');

-- Canton Corredores (73)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 73, 'Corredores');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 73, 'La Cuesta');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 73, 'Paso Canoas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 73, 'Laurel');

-- Canton Garabito (74)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 74, 'Jacó');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 74, 'Tárcoles');

-- =============================================
-- Distritos faltantes para Limón (cantones 75-80)
-- =============================================

-- Canton Limón (75)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 75, 'Limón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 75, 'Valle La Estrella');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 75, 'Río Blanco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 75, 'Matama');

-- Canton Pococí (76)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 76, 'Guápiles');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 76, 'Jiménez');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 76, 'Rita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 76, 'Roxana');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 76, 'Cariari');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 76, 'Colorado');

-- Canton Siquirres (77)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 77, 'Siquirres');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 77, 'Pacuare');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 77, 'Florida');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 77, 'Germania');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 77, 'Cairo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 77, 'Alegría');

-- Canton Talamanca (78)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 78, 'Bratsi');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 78, 'Sixaola');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 78, 'Cahuita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 78, 'Telire');

-- Canton Matina (79)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 79, 'Matina');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 79, 'Batán');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 79, 'Carrandi');

-- Canton Guácimo (80)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 80, 'Guácimo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 80, 'Mercedes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 80, 'Pocora');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 80, 'Río Jiménez');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 80, 'Duacari');


-- ==============================
-- ver las tablas
-- ==============================
SELECT * FROM COUNTRY;
SELECT * FROM PROVINCE;
SELECT * FROM CANTON;
SELECT * FROM DISTRICT;