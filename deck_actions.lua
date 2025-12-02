local function draw_card(deck, player_hand, dealer_hand, num_player, num_dealer)
	for _ = 1, num_player do
		local card = table.remove(deck)
		table.insert(player_hand, card)
	end
	for _ = 1, num_dealer do
		local card = table.remove(deck)
		table.insert(dealer_hand, card)
	end
end

return draw_card
