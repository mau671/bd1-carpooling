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

-- San Jose Province Cantons (2-20)
-- San Jose (2)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Carmen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Merced');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Hospital');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Catedral');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Zapote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'San Francisco de Dos Rios');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Uruca');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Mata Redonda');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Pavas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'Hatillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 2, 'San Sebastian');

--Escazu(3)

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'Escazu');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 3, 'San Rafael');

--Desamparados (4)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Desamparados');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Miguel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Juan de Dios');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Rafael Arriba');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Frailes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Patarra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Cristobal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Rosario');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Damas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'San Rafael Abajo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Gravilias');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 4, 'Los Guido');

--Puriscal (5)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Mercedes Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Barbacoas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Grifo Alto');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'San Rafeal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Candelaria');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Desamparaditos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 5, 'Chires');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'San Marcos');

-- Canton Tarrazu (6)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'San Marcos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'San Lorenzo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 6, 'San Carlos');

-- Canton Aserri (7)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Aserrí');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Tarbaca o Praga');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Vuelta de Jorco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'San Gabriel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'La Legua');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Monterrey');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 7, 'Salitrillos');

-- Canton Mora (8)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Colón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Guayabo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Tabarcia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Piedras Negras');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 8, 'Picagres');

-- Canton Goicoechea (9)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Guadalupe');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'San Francisco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Calle Blancos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Mata de Plátano');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Ipís');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Rancho Redondo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 9, 'Purnal');

-- Canton Santa Ana (10)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Santa Ana');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Saltiral');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Pozos o Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Uruca o San Joaquín');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Piedades');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 10, 'Brasil');

-- Canton Alajuelita (11)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'Alajuelita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'San Josecito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 11, 'San Felipe');

-- Canton Coronado (12)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Dulce Nombre o Jesús');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Patallilo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 12, 'Cascajal');

-- Canton Acosta (13)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'San Ignacio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Guaitil');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Palmichal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Cangrejal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 13, 'Sabanillas');

-- Canton Tibas (14)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'Cinco Esquinas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'Anselmo Llorente');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'León XIII');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 14, 'Colima');

-- Canton Moravia (15)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'San Vicente');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'San Jerónimo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 15, 'La Trinidad');

-- Canton Montes de Oca (16)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'Sabanilla');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'Mercedes o Betania');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 16, 'San Rafael');

-- Canton Turrubares (17)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'San Juan de Mata');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'San Luis');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 17, 'Carara');

-- Canton Dota (18)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Santa María');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Jardín');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 18, 'Copey');

-- Canton Perez Zeledon (19)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'General');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Daniel Flores');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Rivas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Platanares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Pejibaye');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Cajón o Carmen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Bard');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Río Nuevo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 19, 'Páramo');

-- Canton Leon Cortes (20)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Andrés');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Llano Bonito');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'Santa Cruz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 20, 'San Antonio');

-- Alajuela Province Cantons (21-35)
-- Canton Alajuela (21)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Alajuela');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Carrizal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Antonio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Guácima');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Sabanilla');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Río Segundo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Desamparados');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Turrucares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Tambor');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'La Garita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 21, 'Sarapiquí');

-- Canton San Ramon (22)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Ramón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Piedades Norte');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Piedades Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Angeles');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Alfaro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Volio');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'Zapotal');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 22, 'San Isidro de Peñas Blancas');

-- Canton Grecia (23)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Grecia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'San Roque');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Tacares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Río Cuarto');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Puente Piedra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 23, 'Bolívar');

-- Canton San Mateo (24)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'San Mateo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Desmonte');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 24, 'Jesús María');

-- Canton Atenas (25)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Atenas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Jesús');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Mercedes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Santa Eulalia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 25, 'Escobal');

-- Canton Naranjo (26)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Naranjo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'San Miguel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'San José');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Cirrí Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'San Jerónimo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 26, 'Rosario');

-- Canton Palmares (27)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Palmares');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Zaragoza');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Buenos Aires');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Candelaria');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'Esquipulas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 27, 'La Granja');

-- Canton Poas (28)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Carrillos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 28, 'Sabana Redonda');

-- Canton Orotina (29)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Orotina');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Mastate');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Hacienda Vieja');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Coyolar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 29, 'Ceiba');

-- Canton San Carlos (30)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Quesada');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Florencia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Buenavista');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Aguas Zarcas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Venecia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Pital');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Fortuna');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Tigra');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Palmera');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Venado');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Cutris');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Monterrey');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 30, 'Pocosol');

-- Canton Alfaro Ruiz (31)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Zarcero');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Laguna');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Tapezco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Guadalupe');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Palmira');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Zapote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 31, 'Brisas');

-- Canton Valverde Vega (32)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Sarchí Norte');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Sarchí Sur');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Toro Amarillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 32, 'Rodríguez');

-- Canton Upala (33)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Upala');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Aguas Claras');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'San José o Pizote');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Bijagua');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Delicias');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Dos Ríos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 33, 'Yollilal');

-- Canton Los Chiles (34)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'Los Chiles');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'Caño Negro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'Amparo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 34, 'San Jorge');

-- Canton Guatuso (35)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Buenavista');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 35, 'Cote');

-- Cartago Province Cantons (36-43)
-- Canton Cartago (36)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Oriental');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Occidental');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Carmen');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'San Nicolás');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Aguacaliente (San Francisco)');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Guadalupe (Arenilla)');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Corralillo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Tierra Blanca');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Dulce Nombre');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Llano Grande');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 36, 'Quebradilla');

-- Canton Paraiso (37)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Paraíso');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Santiago');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Orosi');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Cachí');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 37, 'Llanos de Sta Lucia');

-- Canton La Union (38)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Tres Ríos');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'San Diego');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'San Juan');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Concepción');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Dulce Nombre');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'San Ramón');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 38, 'Río Azul');

-- Canton Jimenez (39)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Juan Viñas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Tucurrique');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 39, 'Pejibaye');

-- Canton Turrialba (40)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Turrialba');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'La Suiza');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Peralta');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Santa Cruz');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Santa Teresita');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Pavones');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Tuis');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Tayutic');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Santa Rosa');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Tres Equis');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'La Isabel');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 40, 'Chirripo');

-- Canton Alvarado (41)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Pacayas');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Cervantes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 41, 'Capellades');

-- Canton Oreamuno (42)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'San Rafael');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'Cot');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'Potrero Cerrado');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'Cipreses');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 42, 'Santa Rosa');

-- Canton El Guarco (43)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'El Tejar');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'San Isidro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'Tobosi');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 43, 'Patio de Agua');

-- Heredia Province Cantons (44-53)
-- Canton Heredia (44)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'Heredia');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'Mercedes');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'San Francisco');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'Ulloa');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 44, 'Vara Blanca');

-- Canton Barva (45)
INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Barva');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'San Pedro');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'San Pablo');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'San Roque');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'Santa Lucía');

INSERT INTO DISTRICT (id, canton_id, name)
VALUES (DISTRICT_SEQ.NEXTVAL, 45, 'San Jose de la Montaña');

-- Faltan los cantones de Santo Domingo para abajo
-- ==============================
-- ver las tablas
-- ==============================
SELECT * FROM COUNTRY;
SELECT * FROM PROVINCE;
SELECT * FROM CANTON;
SELECT * FROM DISTRICT;