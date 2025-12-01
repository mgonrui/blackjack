local deck_setup = {}
math.randomseed(os.time())

local function assign_value(rank)
	if rank > 10 then
		return 10
	else
		return rank
	end
end

local function single_deck()
	local deck = {}
	local suits = { "Clubs", "Diamond", "Hearts", "Spades" }
	local ranks = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }
	for i, suit in ipairs(suits) do
		for j, rank in ipairs(ranks) do
			local card = {
				index = (i - 1) * 13 + j,
				value = assign_value(j),
				suit = suit,
				img_path = "images/deck/" .. suit .. "_" .. rank .. ".png",
				img_loaded = nil,
			}
			table.insert(deck, card)
		end
	end
	return deck
end

local function shuffle(deck)
	for i = 2, #deck do
		local j = math.random(i)
		deck[i], deck[j] = deck[j], deck[i]
	end
	return deck
end

function deck_setup.big_deck(ndecks)
	local entire_deck = {}
	for i = 1, ndecks, 1 do
		local deck = single_deck()
		for _, card in ipairs(deck) do
			table.insert(entire_deck, card)
		end
	end
	return shuffle(entire_deck)
end

return deck_setup
