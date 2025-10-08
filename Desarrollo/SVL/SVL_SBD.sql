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
