IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE TABLE [Ingredient] (
        [IngredientId] int NOT NULL IDENTITY,
        [IngredientName] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Ingredient] PRIMARY KEY ([IngredientId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE TABLE [Product] (
        [ProductId] int NOT NULL IDENTITY,
        [ProductName] nvarchar(max) NOT NULL,
        [ProductDescription] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Product] PRIMARY KEY ([ProductId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE TABLE [User] (
        [UserId] int NOT NULL IDENTITY,
        [UserName] nvarchar(max) NOT NULL,
        [UserEmail] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([UserId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE TABLE [Recipe] (
        [RecipeId] int NOT NULL IDENTITY,
        [RecipeName] nvarchar(max) NOT NULL,
        [IngredientId] int NOT NULL,
        CONSTRAINT [PK_Recipe] PRIMARY KEY ([RecipeId]),
        CONSTRAINT [FK_Recipe_Ingredient_IngredientId] FOREIGN KEY ([IngredientId]) REFERENCES [Ingredient] ([IngredientId]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE TABLE [Inventory] (
        [InventoryId] int NOT NULL IDENTITY,
        [UserId] nvarchar(max) NOT NULL,
        [ProductId] int NOT NULL,
        CONSTRAINT [PK_Inventory] PRIMARY KEY ([InventoryId]),
        CONSTRAINT [FK_Inventory_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([ProductId]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE INDEX [IX_Inventory_ProductId] ON [Inventory] ([ProductId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    CREATE INDEX [IX_Recipe_IngredientId] ON [Recipe] ([IngredientId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235128_initialCreate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230212235128_initialCreate', N'7.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235642_AdditionOfQuantity')
BEGIN
    ALTER TABLE [Inventory] ADD [Quantity] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230212235642_AdditionOfQuantity')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230212235642_AdditionOfQuantity', N'7.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230217234006_InventoryDate')
BEGIN
    CREATE TABLE [InventoryDate] (
        [InventoryDateId] int NOT NULL IDENTITY,
        [UserId] nvarchar(max) NOT NULL,
        [ProductId] int NOT NULL,
        [Quantity] int NOT NULL,
        [DateAdded] datetime2 NOT NULL,
        [DateModified] datetime2 NOT NULL,
        CONSTRAINT [PK_InventoryDate] PRIMARY KEY ([InventoryDateId]),
        CONSTRAINT [FK_InventoryDate_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([ProductId]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230217234006_InventoryDate')
BEGIN
    CREATE INDEX [IX_InventoryDate_ProductId] ON [InventoryDate] ([ProductId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230217234006_InventoryDate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230217234006_InventoryDate', N'7.0.3');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230217235743_InventoryDateEdit1')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[InventoryDate]') AND [c].[name] = N'DateModified');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [InventoryDate] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [InventoryDate] ALTER COLUMN [DateModified] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230217235743_InventoryDateEdit1')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[InventoryDate]') AND [c].[name] = N'DateAdded');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [InventoryDate] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [InventoryDate] ALTER COLUMN [DateAdded] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230217235743_InventoryDateEdit1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230217235743_InventoryDateEdit1', N'7.0.3');
END;
GO

COMMIT;
GO

