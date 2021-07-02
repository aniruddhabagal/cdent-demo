package main

import (
	"errors"
	"fmt"
	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/sirupsen/logrus"

)

const migrationPath = "file://migrations"
func runMigration(logger *logrus.Logger, config *AppConfig) error {

	dsn := fmt.Sprintf("postgres://%s:%s@%s:%d/%s?sslmode=disable", config.DBUser, config.DBPassword, config.DBHost,config.DBPort, config.DBName)

	m, err := migrate.New(migrationPath,dsn)

	if err != nil {
		logger.WithError(err).Error("Error creating migrations")
		return err
	}

	defer m.Close()

	err = m.Up()

	if errors.Is(err, migrate.ErrNoChange){
		logger.Info("No new migrations")
		return nil
	}

	if err != nil {
		logger.WithError(err).Error("Error running migrations")
		return err
	}

	logger.Info("Successfully executed Migrations")
	return nil
}