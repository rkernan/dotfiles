local function setup()
    local mini_icons = require('mini.icons')
    mini_icons.setup()
    mini_icons.mock_nvim_web_devicons()
end

return { setup = setup }
