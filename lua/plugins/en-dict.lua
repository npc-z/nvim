return {
	"npc-z/cmp-dictionary",
	event = "VeryLazy",
	config = function()
		require("cmp_dictionary").setup({
			exact_length = 2,
			first_case_insensitive = true,
		})
	end,
}
