# encoding: UTF-8

require 'spec_helper'
#require 'byebug'

describe "Usuarios" do

  describe "inicio de sesion" do
    it "no autentica con clave errada a usuario existente" do
		  #usuario = FactoryGirl.create(:usuario)
		  usuario = Usuario.find_by(nusuario: 'sjrcol')
      visit main_app.new_usuario_session_path 
			fill_in "Usuario", with: usuario.nusuario
			fill_in "Clave", with: 'ERRADA'
			click_button "Iniciar Sesión"
		  expect(page).not_to have_content("Administrar")
    end

    it "autentica con usuario creado en prueba" do
		  usuario = FactoryGirl.create(:usuario)
      skip
      visit new_usuario_session_path 
			fill_in "Usuario", with: usuario.nusuario
			fill_in "Clave", with: usuario.password
			click_button "Iniciar Sesión"
		  expect(page).to have_content("Administrar")
			usuario.destroy
    end

    it "autentica con usuario existente en base inicial" do
		  usuario = Usuario.find_by(nusuario: 'sjrcol')
      skip
			usuario.password = 'sjrcol123'
      visit new_usuario_session_path 
			fill_in "Usuario", with: usuario.nusuario
			fill_in "Clave", with: usuario.password
			click_button "Iniciar Sesión"
		  expect(page).to have_content("Administrar")
    end

  end

end
