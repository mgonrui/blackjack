_G.love = require("love")
local deck_setup = require("deck_setup")
local deck_actions = require("deck_actions")
local push = require("push")

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth * 0.7, windowHeight * 0.7 --make the window a bit smaller than the screen itself
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, { fullscreen = false })

function love.load(args)
	regularFont = love.graphics.newFont("fonts/StarCrush.ttf", 23)
	Game = {
		prompt = "",
		scale = math.ceil(love.graphics.getHeight() / gameWidth),
		user_input = "",
		current_bet = nil,
		face_down_card = love.graphics.newImage("images/deck/Back_Blue_2.png"),
		bank = 800,
		deck = deck_setup.big_deck(6),
		player_hand = {},
		dealer_hand = {},
		state = {
			waiting_for_bet = true,
			player_turn = false,
			dealer_turn = false,
			resolving_bets = false,
			round_complete = false,
		},
		locations = {
			deck = {
				x = 900,
				y = 100,
			},
			cards_left = {
				y = 50,
			},
			bank = {
				x = 10,
				y = 50,
			},
			player_first_card = {
				x = 400,
				y = 400,
			},
			dealer_first_card = {
				y = 100,
			},
			player_count = {},
			dealer_count = {},
			current_bet = {
				y = 110,
			},
		},
	}
	Game.locations.cards_left.x = Game.locations.deck.x
	Game.locations.dealer_first_card.x = Game.locations.player_first_card.x
	Game.locations.current_bet.x = Game.locations.bank.x
	for _, card in ipairs(Game.deck) do
		card.img_loaded = love.graphics.newImage(card.img_path)
	end
end

function love.update(dt) end

function love.textinput(t)
	Game.prompt = Game.prompt .. t
	Game.user_input = Game.user_input .. t
end

local function set_initial_draw()
	for i = 1, #Game.dealer_hand do
		love.graphics.draw(
			Game.dealer_hand[i].img_loaded,
			Game.locations.dealer_first_card.x + (i - 1) * 30,
			Game.locations.dealer_first_card.y + (i - 1) * 30,
			0,
			Game.scale
		)
	end
	for i = 1, #Game.player_hand do
		love.graphics.draw(
			Game.player_hand[i].img_loaded,
			Game.locations.player_first_card.x + (i - 1) * 30,
			Game.locations.player_first_card.y + (i - 1) * 30,
			0,
			Game.scale
		)
	end
end

function love.draw()
	push:start()
	push:setBorderColor(love.math.colorFromBytes(60, 179, 113, 0))
	love.graphics.printf(
		"BANK: " .. Game.bank,
		regularFont,
		Game.locations.bank.x,
		Game.locations.bank.y,
		100,
		"justify"
	)
	love.graphics.printf(
		"CARDS LEFT: " .. #Game.deck,
		regularFont,
		Game.locations.cards_left.x,
		Game.locations.cards_left.y,
		100,
		"justify"
	)
	love.graphics.draw(Game.face_down_card, Game.locations.deck.x, Game.locations.deck.y, 0, Game.scale)

	if Game.state.waiting_for_bet == true then
		love.graphics.printf("BET: " .. Game.user_input, regularFont, 400, 350, 100, "justify")
		if Game.current_bet ~= nil then
			Game.bank = Game.bank - Game.current_bet
			Game.state.waiting_for_bet = false
			Game.state.player_turn = true
			deck_actions.draw_card(Game.deck, Game.player_hand, Game.dealer_hand, 2, 2)
		end
	else
		love.graphics.printf(
			"BET: " .. Game.current_bet,
			regularFont,
			Game.locations.current_bet.x,
			Game.locations.current_bet.y,
			100,
			"justify"
		)
	end

	if Game.state.player_turn == true then
		set_initial_draw()
		love.graphics.draw(
			Game.face_down_card,
			Game.locations.dealer_first_card.x + 30,
			Game.locations.dealer_first_card.y + 30,
			0,
			Game.scale
		)
	end

	if Game.state.dealer_turn == true then
		set_initial_draw()
	end
	push:finish()
end

function love.keypressed(key, _, _)
	if Game.state.waiting_for_bet == true then
		if key == "return" then
			Game.current_bet = tonumber(Game.user_input)
		end
	end
	if Game.state.player_turn == true then
		if key == "s" then
			Game.state.player_turn = false
			Game.state.dealer_turn = true
		end
		if key == "h" then
			deck_actions.draw_card(Game.deck, Game.player_hand, Game.dealer_hand, 1, 0)
		end
	end
end
