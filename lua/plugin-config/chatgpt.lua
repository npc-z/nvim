local chatgpt = require("chatgpt")

chatgpt.setup({
    api_key_cmd = "echo $OPENAI_API_KEY",
})
