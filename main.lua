_G.love = require("love")
local deck_setup = require("deck_setup")
local deck_actions = require("deck_actions")

function love.load(args)
	Game = {
		prompt = "",
		user_input = "",
		current_bet = nil,
		face_down_card = love.graphics.newImage("images/deck/Back_Blue_2.png"),
		bank = 800,
		deck = deck_setup.big_deck(6),
		state = {
			waiting_for_bet = true,
			deal_initial_cards = false,
			player_turn = false,
			dealer_turn = false,
			resolving_bets = false,
			round_complete = false,
		},
	}
	for _, card in ipairs(Game.deck) do
		card.img_loaded = love.graphics.newImage(card.img_path)
	end
	love.graphics.setBackgroundColor(love.math.colorFromBytes(60, 179, 113, 0))
end

function love.update(dt) end

function love.textinput(t)
	Game.prompt = Game.prompt .. t
	Game.user_input = Game.user_input .. t
end

function love.draw()
	love.graphics.print("BANK: " .. Game.bank, 1100, 100, 0, 3)
	love.graphics.print("CARDS LEFT: " .. #Game.deck, 1700, 700, 0, 3)
	love.graphics.draw(Game.face_down_card, 1600, 200, 0, 2)
	love.graphics.draw(Game.face_down_card, 1620, 220, 0, 2)
	love.graphics.draw(Game.face_down_card, 1640, 240, 0, 2)

	if Game.state.waiting_for_bet == true then
		love.graphics.print("ENTER BET: ", 100, 100, 0, 3)
		love.graphics.print(Game.user_input, 350, 100, 0, 3)
		if Game.current_bet ~= nil then
			Game.bank = Game.bank - Game.current_bet
			first_card = deck_actions.draw_card(Game.deck)
			second_card = deck_actions.draw_card(Game.deck)
			Game.state.waiting_for_bet = false
			Game.state.deal_initial_cards = true
		end
	end
	if Game.state.deal_initial_cards == true then
		love.graphics.draw(first_card.img_loaded, 1000, 500, 0, 2)
		love.graphics.draw(second_card.img_loaded, 1000, 600, 0, 2)
		-- love.graphics.print("TIME FOR INITIAL CARDS")
		love.graphics.print(Game.current_bet)
	end
end

function love.keypressed(key, _, _)
	if key == "return" and Game.state.waiting_for_bet == true then
		Game.current_bet = tonumber(Game.user_input)
	end
end
