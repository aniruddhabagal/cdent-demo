package main

import "github.com/spf13/viper"

type AppConfig struct {
	PORT    int
	Address string

	DBName     string
	DBHost     string
	DBUser     string
	DBPassword string
	DBPort     int
}

func NewAppConfig() *AppConfig {
	viper.SetConfigType("env")
	viper.AutomaticEnv()
	viper.AddConfigPath(".")
	viper.SetConfigName(".env")

	err := viper.ReadInConfig()
	if err != nil {
		panic(err)
	}

	return &AppConfig{
		PORT:       viper.GetInt("PORT"),
		Address:    viper.GetString("ADDRESS"),
		DBName:     viper.GetString("DB_NAME"),
		DBHost:     viper.GetString("DB_HOST"),
		DBPassword: viper.GetString("DB_PASS"),
		DBPort:     viper.GetInt("DB_PORT"),
		DBUser:     viper.GetString("DB_USER"),
	}
}
