_G.love = require("love")
local text, pos
local cards = {
	"images/deck/Back_Blue_2.png",
	"images/deck/Joker_Black.png",
	"images/deck/Joker_Red.png",
	"images/deck/Clubs_10.png",
	"images/deck/Clubs_11.png",
	"images/deck/Clubs_12.png",
	"images/deck/Clubs_13.png",
	"images/deck/Clubs_1.png",
	"images/deck/Clubs_2.png",
	"images/deck/Clubs_3.png",
	"images/deck/Clubs_4.png",
	"images/deck/Clubs_5.png",
	"images/deck/Clubs_6.png",
	"images/deck/Clubs_7.png",
	"images/deck/Clubs_8.png",
	"images/deck/Clubs_9.png",
	"images/deck/Diamond_10.png",
	"images/deck/Diamond_11.png",
	"images/deck/Diamond_12.png",
	"images/deck/Diamond_13.png",
	"images/deck/Diamond_1.png",
	"images/deck/Diamond_2.png",
	"images/deck/Diamond_3.png",
	"images/deck/Diamond_4.png",
	"images/deck/Diamond_5.png",
	"images/deck/Diamond_6.png",
	"images/deck/Diamond_7.png",
	"images/deck/Diamond_8.png",
	"images/deck/Diamond_9.png",
	"images/deck/Hearts_10.png",
	"images/deck/Hearts_11.png",
	"images/deck/Hearts_12.png",
	"images/deck/Hearts_13.png",
	"images/deck/Hearts_1.png",
	"images/deck/Hearts_2.png",
	"images/deck/Hearts_3.png",
	"images/deck/Hearts_4.png",
	"images/deck/Hearts_5.png",
	"images/deck/Hearts_6.png",
	"images/deck/Hearts_7.png",
	"images/deck/Hearts_8.png",
	"images/deck/Hearts_9.png",
	"images/deck/Spades_10.png",
	"images/deck/Spades_11.png",
	"images/deck/Spades_12.png",
	"images/deck/Spades_13.png",
	"images/deck/Spades_1.png",
	"images/deck/Spades_2.png",
	"images/deck/Spades_3.png",
	"images/deck/Spades_4.png",
	"images/deck/Spades_5.png",
	"images/deck/Spades_6.png",
	"images/deck/Spades_7.png",
	"images/deck/Spades_8.png",
	"images/deck/Spades_9.png",
}
local cards_loaded = {}

local function wrap_deck_bounds()
	if _G.card_index > #cards_loaded then
		_G.card_index = 1
	elseif _G.card_index == 0 then
		_G.card_index = #cards_loaded
	end
end

function love.keypressed(key, _, _)
	if key == "k" then
		_G.card_index = _G.card_index + 1
		wrap_deck_bounds()
	elseif key == "j" then
		_G.card_index = _G.card_index - 1
		wrap_deck_bounds()
	end
end

function love.load(args)
	for i, value in ipairs(cards) do
		cards_loaded[i] = love.graphics.newImage(value)
	end
	_G.card_index = 1
	_G.timer = 0
end

function love.update(dt) end

function love.draw()
	love.graphics.draw(cards_loaded[_G.card_index], nil, nil, nil, 2)
end
