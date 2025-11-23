-- Crear la base de datos
CREATE DATABASE BookStoreDB;
GO

-- Usar la base de datos
USE BookStoreDB;
GO

------------------------------------------------
-- TABLA: Administrador
------------------------------------------------
CREATE TABLE Administrador (
    Id_Administrador INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Contraseña NVARCHAR(100) NOT NULL
);

------------------------------------------------
-- TABLA: Cliente
------------------------------------------------
CREATE TABLE Cliente (
    Id_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(20)
);

------------------------------------------------
-- TABLA: Libro
------------------------------------------------
CREATE TABLE Libro (
    Id_Libro INT IDENTITY(1,1) PRIMARY KEY,
    Titulo NVARCHAR(150) NOT NULL,
    Autor NVARCHAR(100),
    ISBN NVARCHAR(20) UNIQUE,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    Categoria NVARCHAR(50),
    Editorial NVARCHAR(100)
);

------------------------------------------------
-- TABLA: Carrito
------------------------------------------------
CREATE TABLE Carrito (
    Id_Carrito INT IDENTITY(1,1) PRIMARY KEY,
    Id_Cliente INT NOT NULL,
    Fecha_Creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

------------------------------------------------
-- TABLA: CarritoDetalle
------------------------------------------------
CREATE TABLE Carrito_Detalle (
    Id_Carrito_Detalle INT IDENTITY(1,1) PRIMARY KEY,
    Id_Carrito INT NOT NULL,
    Id_Libro INT NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (Id_Carrito) REFERENCES Carrito(Id_Carrito),
    FOREIGN KEY (Id_Libro) REFERENCES Libro(Id_Libro)
);

------------------------------------------------
-- TABLA: Pedido
------------------------------------------------
CREATE TABLE Pedido (
    Id_Pedido INT IDENTITY(1,1) PRIMARY KEY,
    Id_Cliente INT NOT NULL,
    Fecha_Pedido DATETIME DEFAULT GETDATE(),
    Metodo_Pago NVARCHAR(50) NOT NULL,
    Total DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

------------------------------------------------
-- TABLA: PedidoDetalle
------------------------------------------------
CREATE TABLE Pedido_Detalle (
    Id_Pedido_Detalle INT IDENTITY(1,1) PRIMARY KEY,
    Id_Pedido INT NOT NULL,
    Id_Libro INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido),
    FOREIGN KEY (Id_Libro) REFERENCES Libro(Id_Libro)
);

------------------------------------------------
-- TABLA: Comprobante
------------------------------------------------
CREATE TABLE Comprobante (
    Id_Comprobante INT IDENTITY(1,1) PRIMARY KEY,
    Id_Pedido INT NOT NULL UNIQUE,
    Tipo NVARCHAR(20) NOT NULL, -- Boleta o Factura
    Fecha_Emision DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido)
);

INSERT INTO Administrador (Nombre, Contraseña)
VALUES
('admin', '1234'),
('lider', 'abc123'),
('gerente', 'pass789'),
('director', 'libros2025'),
('principal', 'admin@2025');

INSERT INTO Cliente (Nombre, Email, Direccion, Telefono)
VALUES
('Carlos Mendoza', 'carlos.mendoza@email.com', 'Av. Los Pinos 245, Lima', '987654321'),
('Lucía Torres', 'lucia.torres@email.com', 'Calle Primavera 103, Arequipa', '956784123'),
('Jorge Salazar', 'jorge.salazar@email.com', 'Jr. Las Flores 89, Trujillo', '923456789'),
('María López', 'maria.lopez@email.com', 'Av. Grau 750, Chiclayo', '998877665'),
('Ana Castillo', 'ana.castillo@email.com', 'Calle Los Olivos 56, Piura', '912345678');

INSERT INTO Libro (Titulo, Autor, ISBN, Precio, Stock, Categoria, Editorial)
VALUES
('Cien Años de Soledad', 'Gabriel García Márquez', '9780307474728', 59.90, 12, 'Novela', 'Sudamericana'),
('El Principito', 'Antoine de Saint-Exupéry', '9780156012195', 35.50, 25, 'Infantil', 'Gallimard'),
('1984', 'George Orwell', '9780451524935', 49.99, 18, 'Ficción', 'Secker & Warburg'),
('Don Quijote de la Mancha', 'Miguel de Cervantes', '9788420471839', 79.90, 10, 'Clásico', 'Alianza Editorial'),
('La Ciudad y los Perros', 'Mario Vargas Llosa', '9788439727948', 54.90, 14, 'Literatura Peruana', 'Alfaguara');
('Rayuela', 'Julio Cortázar', '9788437604944', 62.50, 10, 'Novela', 'Editorial Sudamericana'),
('Pedro Páramo', 'Juan Rulfo', '9789681604754', 44.00, 8, 'Realismo Mágico', 'Fondo de Cultura Económica'),
('El Amor en los Tiempos del Cólera', 'Gabriel García Márquez', '9780307389732', 56.50, 9, 'Romance', 'Penguin Random House'),
('Fahrenheit 451', 'Ray Bradbury', '9781451673319', 48.90, 12, 'Ciencia Ficción', 'Ballantine Books'),
('Crimen y Castigo', 'Fiódor Dostoievski', '9780143058144', 68.20, 7, 'Clásico', 'Penguin Classics'),
('Los Miserables', 'Victor Hugo', '9780451419439', 70.00, 5, 'Drama Histórico', 'Penguin Classics'),
('Orgullo y Prejuicio', 'Jane Austen', '9780141439518', 50.00, 10, 'Romance', 'Oxford University Press'),
('Moby Dick', 'Herman Melville', '9781503280786', 61.75, 6, 'Aventura', 'Harper & Brothers'),
('La Sombra del Viento', 'Carlos Ruiz Zafón', '9788408172177', 60.50, 9, 'Misterio', 'Planeta'),
('Ensayo Sobre la Ceguera', 'José Saramago', '9780156007757', 52.00, 10, 'Filosofía', 'Alfaguara'),
('El Retrato de Dorian Gray', 'Oscar Wilde', '9780141439570', 46.99, 11, 'Clásico', 'Penguin Books'),
('La Metamorfosis', 'Franz Kafka', '9788491050297', 40.00, 13, 'Ficción', 'Editorial Alianza'),
('El Nombre de la Rosa', 'Umberto Eco', '9780156001311', 64.75, 7, 'Misterio', 'Bompiani'),
('Las Aventuras de Sherlock Holmes', 'Arthur Conan Doyle', '9780141034379', 47.50, 15, 'Policial', 'George Newnes'),
('Los Pilares de la Tierra', 'Ken Follett', '9780451225245', 78.90, 5, 'Histórico', 'Penguin Random House'),
('Drácula', 'Bram Stoker', '9780486411095', 42.80, 12, 'Terror', 'Archibald Constable'),
('El Hobbit', 'J.R.R. Tolkien', '9780261102217', 58.90, 14, 'Fantasía', 'Allen & Unwin'),
('El Señor de los Anillos: La Comunidad del Anillo', 'J.R.R. Tolkien', '9780618640157', 72.50, 8, 'Fantasía', 'Allen & Unwin'),
('It', 'Stephen King', '9781501142970', 75.00, 6, 'Terror', 'Viking Press'),
('Los Juegos del Hambre', 'Suzanne Collins', '9780439023481', 49.50, 20, 'Ciencia Ficción', 'Scholastic Press');

ALTER TABLE Libro
ADD Formato NVARCHAR(20) NOT NULL 
    CONSTRAINT DF_Libro_Formato DEFAULT 'Físico';

UPDATE Libro
SET Formato = 'Digital'
WHERE Id_Libro IN (2, 3, 5, 20, 24, 25, 27, 28, 29, 31);
