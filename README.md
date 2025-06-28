# Carpooling TEC

**Instituto Tecnológico de Costa Rica**  
Campus Tecnológico Local San José  
Escuela de Ingeniería en Computación  

**Curso**: IC4301 Bases de datos I  
**Profesor**: Adriana Álvarez Figueroa  
**Semestre**: I Semestre, 2025  

## Descripción del proyecto

Carpooling TEC es una aplicación de escritorio desarrollada en Java que permite a los usuarios del Instituto Tecnológico de Costa Rica compartir viajes de manera eficiente y segura. La aplicación facilita la conexión entre conductores que tienen espacio disponible en sus vehículos y pasajeros que necesitan transporte, promoviendo el uso compartido de vehículos para reducir costos, tráfico y emisiones de carbono.

### Funcionalidades principales

#### Para Usuarios Generales
- **Registro e inicio de sesión seguro** con autenticación de credenciales
- **Perfil de usuario personalizable** con información personal, institucional y de contacto
- **Gestión de vehículos** para conductores (registro, modificación y eliminación)
- **Creación de rutas interactivas** usando mapas integrados con OpenStreetMap
- **Programación de viajes** con horarios, precios y capacidad de pasajeros
- **Búsqueda avanzada de viajes** por ubicación, fecha y criterios específicos
- **Reserva de viajes** para pasajeros con sistema de pagos
- **Historial de viajes** tanto como conductor como pasajero
- **Sistema de notificaciones** para actualizaciones de viajes

#### Para Administradores
- **Panel de administración completo** para gestión del sistema
- **Gestión de catálogos** (géneros, tipos de identificación, instituciones, etc.)
- **Administración de usuarios** y tipos de usuario
- **Gestión de ubicaciones** (países, provincias, cantones, distritos)
- **Configuración de parámetros del sistema**
- **Generación de reportes y estadísticas**
- **Logs del sistema** para auditoría y monitoreo

## Integrantes

- **Mauricio González Prendas** (carné: 2024143009)
- **Carmen Hidalgo Paz** (carné: 2020030538)
- **Arturo Chavarría Villarevia** (carné: 2023...)

## Tecnologías utilizadas

### Backend
- **Java 21** - Lenguaje de programación principal
- **MySQL 8.4.5 LTS** - Sistema de gestión de base de datos
- **JDBC** - Conectividad con base de datos
- **Stored Procedures** - Lógica de negocio en base de datos

### Frontend
- **Java Swing** - Framework para interfaz gráfica de usuario
- **FlatLaf 3.6** - Look and Feel moderno para Swing
- **JMapViewer** - Componente de mapas con OpenStreetMap
- **LGoodDatePicker 11.2.1** - Selector de fechas avanzado

### Librerías adicionales
- **MySQL Connector/J 9.3.0** - Driver JDBC para MySQL
- **JSON 20231013** - Procesamiento de datos JSON
- **JFreeChart 1.5.6** - Generación de gráficos y reportes
- **FlatLaf Fonts Roboto** - Fuentes personalizadas para UI

### Herramientas de desarrollo
- **NetBeans** - IDE de desarrollo
- **Docker & Docker Compose** - Containerización de base de datos
- **Adminer** - Administración web de base de datos

## Arquitectura del sistema

El proyecto sigue una arquitectura en capas bien definida:

```
src/
├── com/tec/carpooling/
│   ├── MainApp.java                 # Punto de entrada de la aplicación
│   ├── business/service/            # Capa de servicios de negocio
│   │   ├── impl/                    # Implementaciones de servicios
│   │   └── *.java                   # Interfaces de servicios
│   ├── data/                        # Capa de acceso a datos
│   │   ├── connection/              # Gestión de conexiones a BD
│   │   ├── dao/                     # Data Access Objects
│   │   └── impl/                    # Implementaciones de DAOs
│   ├── domain/entity/               # Entidades del dominio
│   ├── dto/                         # Data Transfer Objects
│   ├── exception/                   # Excepciones personalizadas
│   ├── presentation/view/           # Interfaces de usuario
│   │   ├── admin/                   # Vistas administrativas
│   │   └── *.java                   # Vistas generales
│   ├── config/                      # Configuración del sistema
│   └── util/                        # Utilidades del sistema
```

### Base de datos

El sistema utiliza MySQL 8.4.5 LTS con una arquitectura de dos bases de datos:

- **carpooling_pu**: Base de datos MySQL para usuarios públicos con tablas operacionales
- **carpooling_adm**: Base de datos MySQL administrativa con catálogos y configuraciones

## Recursos

- [Modelo conceptual](https://drive.google.com/file/d/1uyTsUURT3e6UffrTEOqjyDYny3rHm0PH/view?usp=sharing)
- [Manual de usuario](docs/Manual_de_Usuario_Carpooling.pdf)
- [Diccionario de datos](docs/03-diccionario-de-datos.xlsm)
- [Casos de prueba](docs/04-casos-de-prueba/)

## Requisitos del sistema

### Requisitos de software
- **Java Development Kit (JDK) 21** o superior
- **MySQL 8.4.5 LTS** o superior
- **Docker y Docker Compose** (opcional, para ambiente de desarrollo)

### Requisitos de hardware
- **RAM**: Mínimo 4 GB, recomendado 8 GB
- **Almacenamiento**: Mínimo 2 GB de espacio libre
- **Procesador**: Intel Core i3 o AMD equivalente (mínimo)
- **Resolución de pantalla**: 1366x768 mínimo, 1920x1080 recomendado

## Instalación y configuración

### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd bd1-carpooling
```

### 2. Configurar la base de datos

#### Opción A: Usando Docker (Recomendado)

```bash
# Navegar al directorio de base de datos
cd database

# Iniciar contenedores
docker-compose up -d

# Verificar que los contenedores estén ejecutándose
docker-compose ps

# Acceder a Adminer en http://localhost:8080
# Para MySQL: Servidor: 172.99.0.4, Usuario: root, Contraseña: carpooling
```

#### Opción B: Instalación manual de MySQL

1. Instalar MySQL 8.4.5 LTS
2. Ejecutar los scripts de configuración:

```bash
# Conectar como root
mysql -u root -p

# Ejecutar scripts en orden
source database/00_Database_Setup.sql
source database/01_Tables.sql
source database/02_Triggers.sql
# ... continuar con todos los scripts
```

### 3. Configurar la aplicación

```bash
# Navegar al directorio de la aplicación
cd app

# Copiar archivo de configuración
cp src/config/db.properties.example src/config/db.properties

# Editar configuración según tu ambiente
# Para Docker: usar 172.99.0.4:3306
# Para instalación local: usar localhost:3306
```

### 4. Compilar y ejecutar

#### Usando NetBeans
1. Abrir el proyecto `app/` en NetBeans
2. Limpiar y construir el proyecto (Clean and Build)
3. Ejecutar el proyecto (Run)

#### Usando línea de comandos
```bash
cd app

# Compilar
ant clean
ant compile

# Ejecutar
ant run
```

## Configuración

### Archivo de configuración de base de datos

Editar `app/src/config/db.properties`:

```properties
# Configuración para ambiente de desarrollo con Docker
db.url=jdbc:mysql://172.99.0.4:3306/carpooling_adm?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=America/Costa_Rica
db.username=adm_user
db.password=adm_password
db.driver=com.mysql.cj.jdbc.Driver

# Para base de datos PU (usuarios públicos)
# db.url=jdbc:mysql://172.99.0.4:3306/carpooling_pu?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=America/Costa_Rica
# db.username=pu_user
# db.password=pu_password
```

### Variables de entorno (opcional)

```bash
export DB_HOST=172.99.0.4
export DB_PORT=3306
export DB_NAME=carpooling_adm
export DB_USER=adm_user
export DB_PASSWORD=adm_password
```

## Uso de la aplicación

### Primera ejecución

1. **Ejecutar la aplicación**: Seguir los pasos de instalación
2. **Pantalla inicial**: La aplicación abrirá en la página de inicio
3. **Crear cuenta**: Registrarse como nuevo usuario
4. **Verificar cuenta**: Completar el proceso de registro
5. **Iniciar sesión**: Usar las credenciales creadas

### Flujo para conductores

1. **Registrar vehículo**: Ir a "Mis Vehículos" → "Agregar Vehículo"
2. **Crear ruta**: Usar el mapa interactivo para definir puntos de recogida
3. **Programar viaje**: Establecer fecha, hora, precio y capacidad
4. **Gestionar reservas**: Ver y administrar pasajeros registrados

### Flujo para pasajeros

1. **Buscar viajes**: Usar filtros de ubicación, fecha y hora
2. **Ver detalles**: Revisar ruta, precio y información del conductor
3. **Reservar viaje**: Seleccionar método de pago y confirmar
4. **Gestionar reservas**: Ver historial y viajes programados

### Panel administrativo

Los administradores pueden:
- Gestionar usuarios y permisos
- Configurar catálogos del sistema
- Generar reportes de uso
- Monitorear logs del sistema
- Administrar ubicaciones geográficas

## Estructura de la base de datos

### Principales entidades

- **PERSON**: Información personal de usuarios
- **USER**: Credenciales y datos de autenticación
- **VEHICLE**: Información de vehículos registrados
- **ROUTE**: Rutas definidas con waypoints
- **TRIP**: Viajes programados por conductores
- **PASSENGER**: Usuarios registrados como pasajeros
- **PASSENGERXTRIP**: Reservas de viajes

### Catálogos administrativos

- **GENDER**: Géneros disponibles
- **INSTITUTION**: Instituciones educativas
- **TYPEIDENTIFICATION**: Tipos de identificación
- **CURRENCY**: Monedas para pagos
- **COUNTRY/PROVINCE/CANTON/DISTRICT**: Ubicaciones geográficas

## Desarrollo

### Estructura del proyecto

```
bd1-carpooling/
├── app/                      # Aplicación Java
│   ├── src/                  # Código fuente
│   ├── lib/                  # Librerías JAR
│   ├── build.xml             # Script de construcción Ant
│   └── nbproject/            # Configuración NetBeans
├── database/                 # Scripts de base de datos
│   ├── procedures/           # Stored procedures
│   ├── compose.yaml          # Docker Compose
│   └── *.sql                 # Scripts de inicialización
├── docs/                     # Documentación
└── models/                   # Diagramas y modelos
```

### Patrones de diseño utilizados

- **DAO (Data Access Object)**: Abstracción de acceso a datos
- **Service Layer**: Capa de servicios de negocio
- **DTO (Data Transfer Object)**: Transferencia de datos entre capas
- **Singleton**: Gestión de conexiones de base de datos
- **Factory**: Creación de objetos DAO y servicios

### Convenciones de código

- **Nomenclatura**: CamelCase para clases, camelCase para métodos y variables
- **Idioma**: Código y comentarios en inglés, mensajes de usuario en español
- **Documentación**: JavaDoc para todas las clases y métodos públicos

## Resolución de problemas

### Problemas comunes

**Error de conexión a base de datos**
```
Verificar que MySQL esté ejecutándose
Comprobar credenciales en db.properties
Verificar que las bases de datos MySQL existan
```

**La aplicación no inicia**
```
Verificar versión de Java (JDK 21+)
Comprobar que todas las librerías estén en app/lib/
Revisar logs en consola de NetBeans
```

**Problemas con mapas**
```
Verificar conexión a internet
Comprobar configuración de proxy si aplica
Verificar que JMapViewer.jar esté en el classpath
```

### Logs del sistema

Los logs se generan en:
- Base de datos: Tabla `LOGS` en `carpooling_pu`
- Aplicación: Salida estándar de consola
- Docker: `docker-compose logs mysql`

## Contribución

### Proceso de desarrollo

1. Crear rama para nueva funcionalidad
2. Implementar cambios siguiendo las convenciones
3. Probar cambios localmente
4. Crear pull request con descripción detallada
5. Revisión de código por otros integrantes
6. Merge después de aprobación

### Reporte de bugs

Al reportar bugs, incluir:
- Pasos para reproducir el problema
- Comportamiento esperado vs. actual
- Capturas de pantalla si aplica
- Información del sistema operativo
- Versión de Java utilizada

## Licencia

Este proyecto es desarrollado con fines académicos para el curso IC4301 Bases de datos I del Instituto Tecnológico de Costa Rica.

## Contacto

Para consultas sobre el proyecto:

- **Mauricio González Prendas**: me@maugp.com
- **Repositorio**: [GitHub](https://github.com/mau671/bd1-carpooling)
- **Documentación**: Ver carpeta `docs/` para manuales detallados