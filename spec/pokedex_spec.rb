require 'spec_helper'
require 'rails_helper'

describe 'Approve Pokedex Validations' do
	it 'Pokemon name is present' do
		new_pokemon = ::Pokedex.new
		new_pokemon.name = ""
		new_pokemon.base_health_point = 1
		new_pokemon.base_attack = 1
		new_pokemon.base_defence = 1
		new_pokemon.base_speed = 1
		new_pokemon.element_type = "fire"
		new_pokemon.image_url = "new_pokemon.jpg"
		expect(new_pokemon.save).to eq(false)
		expect(new_pokemon.errors.include?(:name)).to eq(true)
	end

	it 'Pokemon Name must me unique.' do
		first_pokemon = ::Pokedex.new
		first_pokemon.name = "Power"
		first_pokemon.base_health_point = 1
		first_pokemon.base_attack = 1
		first_pokemon.base_defence = 1
		first_pokemon.base_speed = 1
		first_pokemon.element_type = "water"
		first_pokemon.image_url = "first_pokemon.png"
		first_pokemon.save

		second_pokemon = ::Pokedex.new
		second_pokemon.name = "Power"
		second_pokemon.base_health_point = 1
		second_pokemon.base_attack = 1
		second_pokemon.base_defence = 1
		second_pokemon.base_speed = 1
		second_pokemon.element_type = "water"
		second_pokemon.image_url = "second_pokemon.png"
		expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:name)).to eq(true)
	end

	it 'Pokemon name must not pass the 45 limit name length' do
		first_pokemon = ::Pokedex.new
		first_pokemon.name = "base_health_pointbase_health_pointbase_health_pointbase_health_pointbase_health_pointbase_health_point"
		first_pokemon.base_health_point = 10
		first_pokemon.base_attack = 10
		first_pokemon.base_defence = 10
		first_pokemon.base_speed = 10
		first_pokemon.element_type = "ice"
		first_pokemon.image_url = "metapod_image.png"
		expect(first_pokemon.save).to eq(false)
		expect(first_pokemon.errors.include?(:name)).to eq(true)
	end

	it 'Pokemon HP must be present' do
    second_pokemon = ::Pokedex.new
		second_pokemon.name = "Power"
		second_pokemon.base_health_point = ""
		second_pokemon.base_attack = 1
		second_pokemon.base_defence = 1
		second_pokemon.base_speed = 1
		second_pokemon.element_type = "water"
		second_pokemon.image_url = "second_pokemon.png"
		expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_health_point)).to eq(true)
	end

	it 'Pokemon HP must be a valid integer' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = [3.42..122]
    second_pokemon.base_attack = 1
    second_pokemon.base_defence = 1
    second_pokemon.base_speed = 1
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_health_point)).to eq(true)
	end

	it 'Pokemon HP must not be a negative number.' do
    second_pokemon = ::Pokedex.new
		second_pokemon.name = "Power"
		second_pokemon.base_health_point = -1
		second_pokemon.base_attack = 1
		second_pokemon.base_defence = 1
		second_pokemon.base_speed = 1
		second_pokemon.element_type = "water"
		second_pokemon.image_url = "second_pokemon.png"
		expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_health_point)).to eq(true)
	end

	it 'Pokemon attack must be a valid integer' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = 1
    second_pokemon.base_attack = 1.1
    second_pokemon.base_defence = 1
    second_pokemon.base_speed = 1
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_attack)).to eq(true)
	end

	it 'Pokemon attack must not be a negative number.' do
    second_pokemon = ::Pokedex.new
		second_pokemon.name = "Power"
		second_pokemon.base_health_point = ""
		second_pokemon.base_attack = -1
		second_pokemon.base_defence = 1
		second_pokemon.base_speed = 1
		second_pokemon.element_type = "water"
		second_pokemon.image_url = "second_pokemon.png"
		expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_attack)).to eq(true)
	end

	it 'Pokemon defence must be a valid integer' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = 1
    second_pokemon.base_attack = 1
    second_pokemon.base_defence = 1.1
    second_pokemon.base_speed = 1
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_defence)).to eq(true)
	end

	it 'Pokemon defence must not be less than 0' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = 1
    second_pokemon.base_attack = 1.1
    second_pokemon.base_defence = -1
    second_pokemon.base_speed = 1
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_defence)).to eq(true)
	end

	it 'Pokemon speed must be a valid integer' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = 1
    second_pokemon.base_attack = 1.1
    second_pokemon.base_defence = 1
    second_pokemon.base_speed = 1.1
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_speed)).to eq(true)
	end

	it 'Pokemon speed must not be less than 0' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = 1
    second_pokemon.base_attack = 1.1
    second_pokemon.base_defence = 1
    second_pokemon.base_speed = -1
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_speed)).to eq(true)
	end

	it 'Pokemon speed must be a valid number' do
    second_pokemon = ::Pokedex.new
    second_pokemon.name = "Power"
    second_pokemon.base_health_point = 1
    second_pokemon.base_attack = 1.1
    second_pokemon.base_defence = 1
    second_pokemon.base_speed = 1.33..232
    second_pokemon.element_type = "water"
    second_pokemon.image_url = "second_pokemon.png"
    expect(second_pokemon.save).to eq(false)
		expect(second_pokemon.errors.include?(:base_speed)).to eq(true)
	end

end
