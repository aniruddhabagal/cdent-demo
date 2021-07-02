package users

import "gorm.io/gorm"

type Repository struct{	
	DB *gorm.DB
}

func NewRepository(DB *gorm.DB) *Repository {
	return &Repository{DB: DB}
}

func (r *Repository) Create(user *User) error{
	return r.DB.Create(user).Error
}

func (r *Repository) Update(user *User) error{
	return r.DB.Updates(user).Where("id= ?", user.ID).Error
}

func (r *Repository) Get(id int) (*User, error){
	
	user := &User{}
	err := r.DB.Take(user, "id = ?", id).Error
	
	return user, err
}

func(r *Repository) GetAll() ([]*User, error){
	users := make([]*User, 0)
	err := r.DB.Model(&User{}).Find(&users).Error
	
	return users, err
}

func (r *Repository) Delete(user *User) error{
	return r.DB.Delete(user).Where("id = ?", user.ID).Error
}