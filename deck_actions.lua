local deck_actions = {}

function deck_actions.draw_card(deck)
	local card = table.remove(deck)
	return card
end

return deck_actions
